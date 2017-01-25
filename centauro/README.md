centauro package README description

--------
DESCRIPTION: contains description of a centauro robot in xacro files in an "urdf" folder and a launch file for the model in rviz.
--------

file description
--------
FOLDER launch
    FILE centauro.launch - file to run the xacro model in rviz with a joint state publisher GUI. It is used to verify the model, and direction of joints without gravity.
    ROS-COMMAND: roslaunch centauro centauro.launch
--------
FOLDER urdf
    FILE centauro.urdf.xacro - main xacro files, it manges all other files and provides description of a world, a reference, and a pelvis elements.
    At a beginning of the file there are five configuration flags. They define which elements of the robot are loaded.
    FLAGS
	TORSO - if true a robot upper-body is loaded.
	ARMS - of true a robot arms are loaded; the flag ignored if TORSO flag is false.
	LEGS - if true a robot legs are loaded.
	WHEELS - if true a robot wheels are loaded.
	ARM_ACTUATORS - of true a arms actuators are loaded; ignored if the ARMS and/or TORSO flags are 
false.
	LEG_ACTUATORS - if true a legs actuators are loaded; ignored if the LEGS flag is false.
	TORSO_ACTUATORS - if true a torso actuators are loaded; ignored if the TORSO flag is false.
	WHEELS_ACTUATORS- if true a wheels actuators are loaded; ignored if the WHEELS flag is false.
    --------
    FILE centauro_arm.urdf.xacro - contains a macro defining a robot arm
    --------
    FILE centauro_leg.urdf.xacro - contains a macro defining a robot leg
    --------
    FILE centauro_torso.urdf.xacro - contains an urdf description of a robot torso
    --------
    FILE materials.xacro - contains definitions of a urdf materials. This file is used only in the rviz.
    --------
    FILE parameters.xacro - contains robot inertia parameters, defined by an outside MATLAB script. 
    WARNING: If changed manually, file will be overwritten with a next run of the MATLAB script.
     
