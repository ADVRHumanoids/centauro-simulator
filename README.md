centauro-simulator meta-package README description
--------
Requirements:
--------

- Eigen Library
--------
sudo apt-get install libeigen3-dev


- RBDL Library
--------
download the library package from http://rbdl.bitbucket.org/ and extract to the RBDL folder adressed below

~$ cd catkin_ws/RBDL/

and the package is installed as follows 

~/catkin_ws/RBDL$ mkdir build

~/catkin_ws/RBDL$ cd build/

~/catkin_ws/RBDL/build$ cmake ..

~/catkin_ws/RBDL/build$ make

~/catkin_ws/RBDL/build$ ccmake .

set the configurations as follows:

> CMAKE_BUILD_TYPE                  Debug                                        
CMAKE_INSTALL_PREFIX                /usr/local                                   
CONSOLE_BRIDGE_DIR                  /usr/include                                 
CONSOLE_BRIDGE_LIBRARY              /usr/lib/x86_64-linux-gnu/libconsole_bridge.s
RBDL_BUILD_ADDON_BENCHMARK          OFF                                          
RBDL_BUILD_ADDON_LUAMODEL           OFF                                          
RBDL_BUILD_ADDON_URDFREADER         ON                                           
RBDL_BUILD_STATIC                   OFF                                          
RBDL_BUILD_TESTS                    OFF                                          
RBDL_ENABLE_LOGGING                 OFF                                          
RBDL_STORE_VERSION                  OFF                                          
RBDL_USE_SIMPLE_MATH                OFF 

and submit the new configuration (by pressing c e g).

~/catkin_ws/RBDL/build$ make 

~/catkin_ws/RBDL/build$ sudo make install


--------
Directores:
--------

- centauro
--------
It includes the description of the robot, i.e. the urdf represantation, in addition to the rviz launch file.

- centauro_control
--------
It consists of files required for the implementation of the control scheme, including nodes for defining refrences and so on, and the yaml configuration file, and the controllers' launch file which is run from the main launch file automatically. 

- centauro_gazebo
--------
It contains all files related to the gazebo simulator including the world files configuring the gazebo environment, and the main launch file.

- custom_controller
--------
It includes the custom ros control plugin comprising the controller and the passive compliance dyanmics.

- payload_estimation
--------
A  node providing a ROS Service for the mass/position estimation of a payload located on the robot pelvis.

- custom_messages / custom_services
--------
It contains the definition of all custom messages and services used for the control of the centauro simulator.

- matlab_gen
--------
It contains matlab-generated files required for the communication of matlab with ros.

- inertia
--------
It includes Matlab macro files updating the urdf file inertia parameters according to values given in data file.

- documentation
--------
It presents the naming convention of different elements of the robot; for instance:

 controller: {joint_name}_{controller_name}: 
	     ex. hip_position_controller

 actuator: motor_{joint_name}: 
 	   ex. motor_hip

 transmission: t_{joint_name}:
	      ex. t_hip


--------
Running procedure:
--------

- running the gazebo simulation: 

roslaunch centauro_gazebo centauro_world.launch

- sending references:

rosrun centauro_control setActuatorsComp_oneTopic

- running rviz model:

roslaunch centauro centauro.launch


