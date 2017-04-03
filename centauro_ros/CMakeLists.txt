cmake_minimum_required(VERSION 2.8.3)
project(centauro_ros)

set (VERSION_MAJOR 0)
set (VERSION_MINOR 1)
set (LOG_INFO ${PROJECT_NAME})

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

option(GAZEBO_FLOATING_BASE ON)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages

LIST( APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/config )

set(INSTALL_TARGETS "")
set(CATKIN_DEPENDS_SET "")
set(CATKIN_DEPENDS_BUILD "")
set(DEPENDS_OPTIONAL "")

#message(WARNING " Flags:")
#message(WARNING " COLLISION_CHECK ${COLLISION_CHECK}")
#message(WARNING " TRAJECTORY_GENERATION ${TRAJECTORY_GENERATION}")
#message(WARNING " CENTRALIZED_CONTROLLER ${CENTRALIZED_CONTROLLER}")


if(GAZEBO_FLOATING_BASE)
LIST( APPEND INSTALL_TARGETS gazebo_base_transform)
LIST( APPEND CATKIN_DEPENDS_SET gazebo_msgs tf)

endif(GAZEBO_FLOATING_BASE)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  ${CATKIN_DEPENDS_SET}
  ${CATKIN_DEPENDS_BUILD}
)

catkin_package(
  INCLUDE_DIRS ${catkin_INCLUDE_DIRS}
  CATKIN_DEPENDS 
	roscpp
	${CATKIN_DEPENDS_SET}
  DEPENDS
	${DEPENDS_OPTIONAL}
)
###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
# include_directories(include)
include_directories(
  include
  ${catkin_INCLUDE_DIRS}
)

if(GAZEBO_FLOATING_BASE)
add_executable(gazebo_base_transform src/gazebo_base_transform.cpp)
add_dependencies(gazebo_base_transform ${catkin_EXPORTED_TARGETS})
target_link_libraries(gazebo_base_transform
    ${catkin_LIBRARIES}
 )
endif(GAZEBO_FLOATING_BASE)#############

## Install ##
#############

# all install targets should use catkin DESTINATION variables
# See http://ros.org/doc/api/catkin/html/adv_user_guide/variables.html

## Mark executable scripts (Python etc.) for installation
## in contrast to setup.py, you can choose the destination
# install(PROGRAMS
#   scripts/my_python_script
#   DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark executables and/or libraries for installation
 install(TARGETS ${INSTALL_TARGETS}
   ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
   LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
   RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
 )

## Mark cpp header files for installation
# install(DIRECTORY include/${PROJECT_NAME}/
#   DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
#   FILES_MATCHING PATTERN "*.h"
#   PATTERN ".svn" EXCLUDE
# )

## Mark other files for installation (e.g. launch and bag files, etc.)
# install(FILES
#   # myfile1
#   # myfile2
#   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
# )

#############
## Testing ##
#############

## Add gtest based cpp test target and link libraries
# catkin_add_gtest(${PROJECT_NAME}-test test/test_programs.cpp)
# if(TARGET ${PROJECT_NAME}-test)
#   target_link_libraries(${PROJECT_NAME}-test ${PROJECT_NAME})
# endif()

## Add folders to be run by python nosetests
# catkin_add_nosetests(test)
