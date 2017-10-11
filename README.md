centauro-simulator meta-package README description
--------

Directores:
--------

- centauro
--------
It includes the description of the robot, i.e. the urdf represantation, in addition to the rviz launch file.

- centauro_gazebo
--------
It contains all files related to the gazebo simulator including the world files configuring the gazebo environment, and the main launch file.

- documentation
--------
It presents the naming convention of different elements of the robot; for instance:

 actuator: motor_{joint_name}: 
 	   ex. motor_hip

 transmission: t_{joint_name}:
	      ex. t_hip


--------
Running procedure:
--------

- running the simulation: 

roslaunch centauro_gazebo centauro_world.launch

- running the simulation with arguments:

roslaunch centauro_gazebo centauro_world.launch arg:=value
ex. roslaunch centauro_gazebo centauro_world.launch legs:=false paused:=false hands:=false gui:=true rviz:=true gazebo:=false

- additionally, two scripts are provided to publish missing transforms from robot_state_publisher:

rosrun centauro_ros load_fixed_transforms - loads static transforms for fixed joints not recognized by a robot_state_publisher (requires urdfdom_py package)

rosrun centauro_ros gazebo_base_transform - publishes a transform from 'world' to 'pelvis' for a floating base system 

--------
Optional arguments:
--------

### Basic simulation set-up

| Argument | Default | Description |
| ---| --- | --- |
| gazebo | true | whether the gazebo simulation should be run or not |
| rviz | false | whether the rviz visualization tool should be run or not  |
| middleware | xbotcore | which middleware should be used to connect with gazebo. Other options: **ros_control** |

### Gazebo configuration parameters

| Argument | Default | Description |
| ---| --- | --- |
| paused | true | if the simulation should be paused at the beginning, may be useful if initialization takes time |
| use_sim_time | true | if ROS should be driven by a simulation time or the world clock |
| gui | true | if gazebo GUI should be loaded |
| debug | false | if a debug information should be loaded |
| physics | ode | which physics engine should be loaded; options: **ode**, **bullet**, **simbody** |
| verbose | false | if verbose logging information should be loaded |

### CENTAURO model configuration parameters
Defined which part of the robot should be loaded

| Argument | Default | Description |
| ---| --- | --- |
| arms | true | if arms should be loaded |
| torso | true | if torso should be loaded, if not also the rest of upper-body is not loaded |
| legs | true | if legs should be loaded, if not also wheels are not loaded |
| head | true | if head should be loaded |
| wheels | false | if wheels should be loaded |
| static | false | if the system is floating base or static |
| one_arm | false | only one robot arm is loaded |
| mass | 0 | if positive value, 5x5x5 cm box is added 10 cm from a last arm joint axis |

Argument **end_effector**: default value **stick**

| Value | Description |
| ---| --- |
| stick | load sticks as arms' end-effectors |
| soft_hand | load soft_hands as arms' end-effectors |
| unknown* | no end-effector is loaded|

* 'unknown' argument means any string that is not defined as a specific value for this argument 

### CENTAURO model  actuators configuration
Defines which part of the robot should be actuated

| Argument | Default | Description |
| ---| --- | --- |
| torso_actuators | true | if torso should be actuated |
| arm_actuators | true | if arms should be actuated |
| leg_actuators | true | if legs should be actuated |
| wheels_actuators | true | if wheels should be actuated |

### CENTAURO model sensors configuration
Defines which sensors should be loaded for the robot

| Argument | Default | Description |
| ---| --- | --- |
| arm_sensors | true | if sensors on arms should be loaded |
| leg_sensors | true | if sensors on legs should be loaded |
| ft_sensors | true | if force-torque sensors should be loaded |
| bumbers | true | if bumber sensors should be loaded |
| imu | true | if imu should be loaded |

### CENTAURO collision and visualization models

Argument **visual_model**: default value **mesh**

Argument **collision_model**: default value **convex_hull**

For robot visualization and collision models two arguments 'visual_model' and 'collision_model' are defined, respectively. Each accepts any of following values

| Value | Description |
| ---| --- |
| mesh | load realistic mesh file for each link |
| convex_hull | load file describing a convex hull object for each link |
| capsule | load capsules computed based on the model |
| unknown* | load predefined primitives |

In case a specific model is not defined for some links, the predefined primitives will be loaded for these links.

* 'unknown' argument means any string that is not defined as a specific value for this argument 

### A simulation environment that should be loaded:
**WARNING:** exactly one parameter has to be true, otherwise simulation behaviour is undefined -->

| Argument | Default | Description |
| ---| --- | --- |
| world_name | $(find centauro_gazebo)/worlds/centauro.world | which simulation environment should be loaded |


--------
How To Generate URDF from Xacro
--------

- Example with current set of argument:

rosrun xacro xacro --inorder -o test.urdf centauro.urdf.xacro GAZEBO:=false ARMS:=true TORSO:=true ARM_ACTUATORS:=true LEGS:=true LEG_ACTUATORS:=true TORSO_ACTUATORS:=true WHEELS:=false WHEELS_ACTUATORS:=false ONE_ARM:=false STATIC:=false COLLISION_MODEL:=convex_hull VISUAL_MODEL:=mesh END_EFFECTOR:=stick ARM_SENSORS:=false MASS:=0 INERTIA_PARAM:=original KINEMATIC_PARAM:=original HEAD_ACTUATORS:=true HEAD:=true



