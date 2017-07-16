#!/bin/bash

# generate urdf from xacro
rosrun xacro xacro --inorder centauro_floating_arm.urdf.xacro > centauro_floating_arm.urdf ARMS:=true  TORSO:=true ARM_ACTUATORS:=true LEGS:=false LEG_ACTUATORS:=true TORSO_ACTUATORS:=true WHEELS:=false WHEELS_ACTUATORS:=true STATIC:=false ONE_ARM:=false  VISUAL_MODEL:=mesh COLLISION_MODEL:=convex_hull END_EFFECTOR:=narrow_feet ARM_SENSORS:=true GAZEBO:=true MASS:=0.0 INERTIA_PARAM:=original KINEMATIC_PARAM:=original

# check urdf
check_urdf centauro_floating_arm.urdf

# generate pdf file
urdf_to_graphiz centauro_floating_arm.urdf
