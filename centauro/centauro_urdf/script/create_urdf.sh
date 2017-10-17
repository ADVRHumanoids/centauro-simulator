
rosrun xacro xacro.py --inorder $(rospack find centauro)/centauro_urdf/urdf/centauro.urdf.xacro GAZEBO:=false ARMS:=true TORSO:=true ARM_ACTUATORS:=true LEGS:=true LEG_ACTUATORS:=true TORSO_ACTUATORS:=true WHEELS:=false WHEELS_ACTUATORS:=false ONE_ARM:=false STATIC:=false COLLISION_MODEL:=convex_hull VISUAL_MODEL:=convex_hull END_EFFECTOR:=stick ARM_SENSORS:=false MASS:=0 INERTIA_PARAM:=original KINEMATIC_PARAM:=original HEAD_ACTUATORS:=true HEAD:=true LEFT_END_EFFECTOR:=stick RIGHT_END_EFFECTOR:=schunk_hand FT_SENSORS:=true > centauro.urdf

