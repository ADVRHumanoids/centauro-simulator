#include <ros/ros.h>
#include <tf/transform_broadcaster.h>
#include <gazebo_msgs/LinkStates.h>

void poseCallback(const gazebo_msgs::LinkStates::ConstPtr& msg)
{
  static int base = 1;
  static tf::TransformBroadcaster br;
  tf::Transform transform;

  transform.setOrigin(tf::Vector3(msg->pose[base].position.x,
                                  msg->pose[base].position.y,
                                  msg->pose[base].position.z));
//  transform.setRotation(tf::Quaternion(
//        0, 0,
//        0, 1));

  transform.setRotation(tf::Quaternion(
      msg->pose[base].orientation.x, msg->pose[base].orientation.y,
      msg->pose[base].orientation.z, msg->pose[base].orientation.w));

  br.sendTransform(
      tf::StampedTransform(transform, ros::Time::now(), "world", "pelvis"));
}

int main(int argc, char** argv)
{

  ros::init(argc, argv, "floating_base_transform"); // initalize node

  ros::NodeHandle n;

  ros::Subscriber sub = n.subscribe("/gazebo/link_states", 1, &poseCallback);

  ros::Rate rate(250);

//  ros::Duration(0.5).sleep();

  while (ros::ok())
  {
    ros::spinOnce();

    rate.sleep();
  }
  return 0;
}
