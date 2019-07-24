#include <functional>
#include <gazebo/gazebo.hh>
#include <gazebo/physics/physics.hh>
#include <gazebo/common/common.hh>
#include <ignition/math/Vector3.hh>
#include <gazebo/transport/transport.hh>
#include <gazebo/msgs/msgs.hh>

namespace gazebo
{
  class ComputeCom : public ModelPlugin
  {
    public: void Load(physics::ModelPtr _parent, sdf::ElementPtr /*_sdf*/)
    {
      // Store the pointer to the model
      this->model = _parent;

      // Listen to the update event. This event is broadcast every
      // simulation iteration.
      this->updateConnection = event::Events::ConnectWorldUpdateBegin(
          std::bind(&ComputeCom::OnUpdate, this));

      _links = model->GetLinks();

      _node.reset(new transport::Node());
      _node->Init(this->model->GetName());
      _comPub = _node->Advertise<msgs::Vector3d>("~/center_of_mass");

    }

    // Called by the world update start event
    public: void OnUpdate()
    {
      _mass = 0;
      _com.Set(0, 0, 0);
      for(auto& link: _links){
        _mass+=link->GetInertial()->Mass();
        _link_com = link->WorldCoGPose().Pos();
        _link_com *= link->GetInertial()->Mass();
        _com +=  _link_com;
        _temp_com  = _com / _mass;

        // std::cout << link->GetName() << "\t" << link->GetInertial()->Mass() << "\t" << link->WorldCoGPose().Pos() << ",\t" << _temp_com << ",\t" << _mass << std::endl;
      }
        _com /= _mass;
        // std::cout << _com << "\t" << _mass << std::endl;

         _msg = gazebo::msgs::Convert(_com);

         //std::cout << _com << std::endl;
        _comPub->Publish(_msg);
   }


    // Pointer to the model
    private:
        physics::ModelPtr model;
        event::ConnectionPtr updateConnection;
        double _mass;
        std::vector<physics::LinkPtr> _links;
        ignition::math::Vector3d _com, _temp_com;
        ignition::math::Vector3d _link_com;

        transport::NodePtr _node;
        transport::PublisherPtr _comPub;
        msgs::Vector3d _msg;
  };

  // Register this plugin with the simulator
  GZ_REGISTER_MODEL_PLUGIN(ComputeCom)
}
