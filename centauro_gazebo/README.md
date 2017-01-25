centauro-gazebo package README description

--------
DESCRIPTION: contains all files specific to the gazebo simulator including gazebo related xacro parameters, a launch file, and a gazebo world description.
--------

file description
--------
FOLDER launch
    FILE centauro_world.launch - main file, starts gazebo, spawn urdf model, loads urdf model to gazebo and spawn controller_manager required to load controllers.
    INFO It is a first file to play to start a simulation in gazebo
    ROS-COMMAND roslaunch centauro_gazebo centauro_world.launch
--------
FOLDER urdf
    FILE centauro.gazebo - it contains gazebo-specific urdf parameters: defines gazebo materials and loads gazebo_ros_control plugin. It is called from a centauro/launch/centauro.xacro file.
--------
FOLDER worlds
    FILE centauro.world - contains a basic description of a gazebo simulatated world.

