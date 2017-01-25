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

For specific description of avaiable arguments see wiki page on: https://gitlab.advrcloud.iit.it/centauro-simulator-control/centauro-simulator/wikis/home





