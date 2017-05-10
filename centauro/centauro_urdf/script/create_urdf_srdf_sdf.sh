#!/bin/bash

RED='\033[0;31m'
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
YELLOW='\033[1;33m'
NC='\033[0m'

if [ "$#" -lt 1 ]; then
       printf "${RED}No robot name argument passed!${NC}" 
       echo 
       echo "Try something like:"
       echo "./create_urdf_srdf_sdf.sh coman"
       exit
fi

robot_name="$1"
printf "Robot Name is ${GREEN}${robot_name}${NC}"
echo

# this way the script can be called from any directory
SCRIPT_ROOT=$(dirname $(readlink --canonicalize --no-newline $BASH_SOURCE))
cd $SCRIPT_ROOT
cd ../urdf

echo "Processing file $i"

if [ ! -f ${robot_name}.urdf ]; then
	creat_urdf=true
	if [ -f config/ros_args ]; then
		temp=$(cat config/ros_args )
	fi
	rosrun xacro xacro --inorder -o ${robot_name}.urdf ${robot_name}.urdf.xacro ${temp}
	unset temp
fi

printf "${PURPLE}Creating capsule urdf of ${robot_name}.urdf.xacro ...${NC}\n"
robot_capsule_urdf ${robot_name}.urdf --output
printf "${GREEN}...${robot_name}_capsules.urdf correctly created!${NC}\n"
echo
echo
            
printf "${PURPLE}Creating capsule urdf (for visualization) of ${robot_name}_capsules.urdf ...${NC}\n"
robot_capsule_urdf_to_rviz ${robot_name}_capsules.urdf --output
printf "${GREEN}...${robot_name}_capsules.rviz correctly created! You can use view it by calling roslaunch ${robot_name}_urdf ${robot_name}_capsules_slider.launch${NC}\n"
echo
echo
