#include <thread>
#include "ros/ros.h"
#include "ros/callback_queue.h"
#include "ros/subscribe_options.h"
//#include "std_msgs/Float32.h"
#include "gazebo_services/applyForce.h"
#include <gazebo_plugins/gazebo_ros_utils.h>

#include <functional>
#include <gazebo/gazebo.hh>
#include <gazebo/physics/physics.hh>
#include <gazebo/common/common.hh>
#include <ignition/math/Vector3.hh>
#include <gazebo/transport/transport.hh>
#include <gazebo/msgs/msgs.hh>

namespace gazebo
{
  class ApplyForceCom : public ModelPlugin
  {
    public: void Load(physics::ModelPtr _parent, sdf::ElementPtr _sdf)
    {
      // Store the pointer to the model
      this->model = _parent;

      this->gazebo_ros_ = GazeboRosPtr(new GazeboRos(_parent, _sdf, "ApplyForceCom"));

      this->gazebo_ros_->isInitialized();
      // Listen to the update event. This event is broadcast every
      // simulation iteration.
      this->updateConnection = event::Events::ConnectWorldUpdateBegin(
          std::bind(&ApplyForceCom::OnUpdate, this));

      _node.reset(new transport::Node());
      _node->Init(this->model->GetName());

      if(!_sdf->HasElement("topic")) return;
      if(!_sdf->HasElement("link")) return;

      _my_subscriber = _node->Subscribe(_sdf->Get<std::string>("topic"), &ApplyForceCom::GetCom, this);
      _link = model->GetLink(_sdf->Get<std::string>("link"));

      if (!ros::isInitialized())
      {
        int argc = 0;
        char **argv = NULL;
        ros::init(argc, argv, "gazebo_client",
            ros::init_options::NoSigintHandler);
      }

      // Service for changing operating mode
      ros::AdvertiseServiceOptions ao = ros::AdvertiseServiceOptions::create<gazebo_services::applyForce>("apply_com_force",
                  boost::bind(&ApplyForceCom::Callback, this, _1, _2), ros::VoidPtr(), &this->queue_);
      this->server_ = this->gazebo_ros_->node()->advertiseService(ao);

      this->rosQueueThread =  boost::thread(std::bind(&ApplyForceCom::QueueThread, this));
    }

    void GetCom(ConstVector3dPtr& msg){
      // std::cout << "get" << std::endl;
      _com.X() = msg->x();
      _com.Y() = msg->y();
      _com.Z() = msg->z();
    }


    // Called by the world update start event
    public: void OnUpdate()
    {
      if(_steps <= 0) return;

      _link->AddForceAtWorldPosition(_force, _com);
      --_steps;
   }

    bool Callback(const gazebo_services::applyForce::Request  &req, gazebo_services::applyForce::Response& res){
      _steps = req.nr;
      _force.X() = req.Fx;
      _force.Y() = req.Fy;
      _force.Z() = req.Fz;

      res.success = true;
      return true;
    }

    // Pointer to the model
    private:
        GazeboRosPtr gazebo_ros_;
        physics::ModelPtr model;
        physics::LinkPtr _link;
        event::ConnectionPtr updateConnection;
        ignition::math::Vector3d _force, _com;

        transport::NodePtr _node;
        transport::PublisherPtr _comPub;
        msgs::Vector3d _msg;
        transport::SubscriberPtr _my_subscriber;


         boost::thread rosQueueThread;
        ros::CallbackQueue queue_;
        ros::ServiceServer server_;
        int _steps = 0;

        void QueueThread()
        {
            //std::cout << "queue" << std::endl;
            static const double timeout = 0.01;
            while (this->gazebo_ros_->node()->ok())
              this->queue_.callAvailable(ros::WallDuration(timeout));
        }
  };

  // Register this plugin with the simulator
  GZ_REGISTER_MODEL_PLUGIN(ApplyForceCom)
}
