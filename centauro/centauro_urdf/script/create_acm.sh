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

model_filename=$(basename ${robot_name} ".urdf.xacro")

cd $SCRIPT_ROOT

HAS_MOVEIT_CDC=true;
type moveit_compute_default_collisions >/dev/null 2>&1 || { HAS_MOVEIT_CDC=false; }

if [ $HAS_MOVEIT_CDC == true ]; then
   echo
   echo
   printf "${RED}computing default allowed collision detection matrix for ${model_filename}...${NC}\n"
   if [ ! -f ../urdf/${model_filename}.urdf ]; then
      creat_urdf=true
      if [ -f ../urdf/config/ros_args ]; then
         temp=$(cat ../urdf/config/ros_args )
      fi
      rosrun xacro xacro --inorder  -o ../urdf/${model_filename}.urdf ../urdf/${model_filename}.urdf.xacro ${temp}
      unset temp
   fi
   moveit_compute_default_collisions --urdf_path ../urdf/${model_filename}.urdf --srdf_path ../../${robot_name}_srdf/srdf/${model_filename}.srdf --num_trials 1000000000
   ./save_acm.py ../../${robot_name}_srdf/srdf/${model_filename}.srdf --output
else
   echo
   printf "${RED}ERROR! moveit_compute_default_collisions was not found. Exiting${NC}\n"
   exit
fi

cd $SCRIPT_ROOT

if [ "$creat_urdf" = true ]; then
   rm  ../urdf/${model_filename}.urdf
fi

cd ../urdf

unset i
unset creat_urdf

cd $SCRIPT_ROOT
cd ../urdf
