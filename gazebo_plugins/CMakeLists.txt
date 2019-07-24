cmake_minimum_required(VERSION 2.8 FATAL_ERROR)
project (GazeboPlugins)

set (VERSION_MAJOR 0)
set (VERSION_MINOR 1)

set(CMAKE_CXX_STANDARD 14)

find_package(gazebo REQUIRED)

LIST( APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/config )
#set(gazebo_services_PATH /home/malgorzata/ros_course_ws/devel/include/gazebo_services)
find_package(gazebo_services REQUIRED)
find_package(roscpp REQUIRED)
find_package(gazebo_ros REQUIRED)
find_package(gazebo_plugins REQUIRED)

include_directories(${GAZEBO_INCLUDE_DIRS})
include_directories(${roscpp_INCLUDE_DIRS})
include_directories(${gazebo_ros_INCLUDE_DIRS})

include_directories(${gazebo_services_INCLUDE_DIR})
#message(WARNING " ${gazebo_services_INCLUDE_DIR}")

link_directories(${GAZEBO_LIBRARY_DIRS})
list(APPEND CMAKE_CXX_FLAGS "${GAZEBO_CXX_FLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${GAZEBO_CXX_FLAGS}")

add_library(gazebo_plugins_compute_com SHARED src/compute_com.cpp)
target_link_libraries(gazebo_plugins_compute_com ${GAZEBO_LIBRARIES})

add_library(gazebo_plugins_show_com SHARED src/show_com.cpp)
target_link_libraries(gazebo_plugins_show_com ${GAZEBO_LIBRARIES})

add_library(gazebo_plugins_apply_force SHARED src/apply_force.cpp)
target_link_libraries(gazebo_plugins_apply_force ${GAZEBO_LIBRARIES} ${roscpp_LIBRARIES} ${gazebo_ros_LIBRARIES} ${gazebo_plugins_LIBRARIES} )
