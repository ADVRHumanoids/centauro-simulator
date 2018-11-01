#!/bin/bash

# File name
FILE_NAME=centauro_tray.urdf

# SPECIFIC STUFF
TRAY=true

# Model Configuration
STATIC=false  # Floating base or static
ARMS=true
TORSO=true
LEGS=true
WHEELS=true
HEAD=true
LEFT_END_EFFECTOR=soft_hand  # stick, soft_hand, schunk_hand
RIGHT_END_EFFECTOR=soft_hand  # stick, soft_hand, schunk_hand
MASS=0  # Kg added to the last arm joint axis

# Model actuators
TORSO_ACTUATORS=true
ARM_ACTUATORS=true
LEG_ACTUATORS=true
WHEELS_ACTUATORS=true
HEAD_ACTUATORS=true

# Model sensors
ARM_SENSORS=false
LEG_SENSORS=false
FT_SENSORS=false
BUMPERS=false
IMU=false

# Collision and visualization
VISUAL_MODEL=simplified  # mesh, convex_hull, capsule, simplified,
COLLISION_MODEL=convex_hull

# Simulation parameters
GAZEBO=false
KINEMATIC_PARAM=original
INERTIA_PARAM=original

echo "Compiling urdf with name: '$FILE_NAME'"
#rosrun xacro xacro --inorder \
#    -o ${FILE_NAME} \
#    ./centauro_urdf/urdf/centauro.urdf.xacro \
#    GAZEBO:=false \
#    STATIC:=${STATIC} \
#    ARMS:=${ARMS} \
#    TORSO:=${TORSO} \
#    LEGS:=${LEGS} \
#    HEAD:=${HEAD} \
#    WHEELS:=${WHEELS} \
#    LEFT_END_EFFECTOR:=${LEFT_END_EFFECTOR} \
#    RIGHT_END_EFFECTOR:=${RIGHT_END_EFFECTOR} \
#    MASS:=${MASS} \
#    TORSO_ACTUATORS:=${TORSO_ACTUATORS} \
#    ARM_ACTUATORS:=${ARM_ACTUATORS} \
#    LEG_ACTUATORS:=${LEG_ACTUATORS} \
#    WHEELS_ACTUATORS:=${WHEELS_ACTUATORS} \
#    HEAD_ACTUATORS:=${HEAD_ACTUATORS} \
#    ARM_SENSORS:=${ARM_SENSORS} \
#    LEG_SENSORS:=${LEG_SENSORS} \
#    FT_SENSORS:=${FT_SENSORS} \
#    BUMPERS:=${BUMPERS} \
#    IMU:=${IMU} \
#    VISUAL_MODEL:=${VISUAL_MODEL} \
#    COLLISION_MODEL:=${COLLISION_MODEL} \
#    INERTIA_PARAM:=${INERTIA_PARAM} \
#    KINEMATIC_PARAM:=${KINEMATIC_PARAM}

rosrun xacro xacro --inorder \
    -o ${FILE_NAME} \
    ./centauro_urdf/urdf/centauro_tray.urdf.xacro \
    GAZEBO:=false \
    STATIC:=${STATIC} \
    ARMS:=${ARMS} \
    TORSO:=${TORSO} \
    LEGS:=${LEGS} \
    HEAD:=${HEAD} \
    WHEELS:=${WHEELS} \
    LEFT_END_EFFECTOR:=${LEFT_END_EFFECTOR} \
    RIGHT_END_EFFECTOR:=${RIGHT_END_EFFECTOR} \
    MASS:=${MASS} \
    TORSO_ACTUATORS:=${TORSO_ACTUATORS} \
    ARM_ACTUATORS:=${ARM_ACTUATORS} \
    LEG_ACTUATORS:=${LEG_ACTUATORS} \
    WHEELS_ACTUATORS:=${WHEELS_ACTUATORS} \
    HEAD_ACTUATORS:=${HEAD_ACTUATORS} \
    ARM_SENSORS:=${ARM_SENSORS} \
    LEG_SENSORS:=${LEG_SENSORS} \
    FT_SENSORS:=${FT_SENSORS} \
    BUMPERS:=${BUMPERS} \
    IMU:=${IMU} \
    VISUAL_MODEL:=${VISUAL_MODEL} \
    COLLISION_MODEL:=${COLLISION_MODEL} \
    INERTIA_PARAM:=${INERTIA_PARAM} \
    KINEMATIC_PARAM:=${KINEMATIC_PARAM} \
    TRAY:=${TRAY}


# Substitute package by relative path
echo "Substituting '${FILE_NAME}' paths with relative ones"
sed -i -e 's@package://centauro@.@g' ${FILE_NAME}
