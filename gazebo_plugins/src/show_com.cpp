#include <functional>
#include <gazebo/gazebo.hh>
#include <gazebo/physics/physics.hh>
#include <gazebo/common/common.hh>
#include <ignition/math/Vector3.hh>
#include <gazebo/transport/transport.hh>
#include <gazebo/msgs/msgs.hh>
#include <gazebo/rendering/rendering.hh>

namespace gazebo
{
  class ShowCom : public VisualPlugin
  {
    public: void Load(rendering::VisualPtr visual, sdf::ElementPtr _sdf)
    {
      // Store the pointer to the model
      this->_visual = visual;
      _rate = (_sdf->HasElement("step")) ? _sdf->Get<int>("step") : 1000;

      // _updateConnection = event::Events::ConnectPreRender(
      //             std::bind(&ShowCom::OnTest, this));
      _node.reset(new transport::Node());

      if(!_sdf->HasElement("ns")) return;
      if(!_sdf->HasElement("topic")) return;
      _node->Init(_sdf->Get<std::string>("ns"));

      _my_subscriber = _node->Subscribe(_sdf->Get<std::string>("topic"), &ShowCom::OnUpdate, this);

      // Compute radius of sphere with density of lead and equivalent mass.
        double sphereRadius = sphereRadius = 7.0;

        _sphereVis.reset(new rendering::Visual("_SPHERE_", _visual, false));
        _sphereVis->Load();

        _sphereVis->InsertMesh("unit_sphere"); // Do I need it?
        _sphereVis->AttachMesh("unit_sphere"); // Do I need it?

        _sphereVis->SetScale(ignition::math::Vector3d(
            sphereRadius*2, sphereRadius*2, sphereRadius*2));

        _sphereVis->SetMaterial("Gazebo/Purple");
        _sphereVis->SetCastShadows(false);
        _sphereVis->SetVisibilityFlags(GZ_VISIBILITY_GUI);

    }

    // Called by the world update start event
    public: void OnUpdate(ConstVector3dPtr& msg)
    {
      ++id;

      if(!(id%_rate)){
      _world_pos = _sphereVis->WorldPose();

      _world_pos.Pos().X() = msg->x();
      _world_pos.Pos().Y() = msg->y();
      _world_pos.Pos().Z() = msg->z();

      _sphereVis->SetWorldPosition(_world_pos.Pos());

      this->_visual->SetVisible(true);
    }

   }


    // Pointer to the model
    private:
        transport::NodePtr _node;
        rendering::VisualPtr _visual, _sphereVis;
        rendering::DynamicLines* _com_marker;
        ignition::math::Vector3d _position;
        ignition::math::Pose3d _world_pos;
        event::ConnectionPtr _updateConnection;
        transport::SubscriberPtr _my_subscriber;
        int id = 0, _rate;
  };

  // Register this plugin with the simulator
  GZ_REGISTER_VISUAL_PLUGIN(ShowCom)
}
