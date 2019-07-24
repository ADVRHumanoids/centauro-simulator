# Searches for gazebo_services includes and library files, including Addons.
#
# Sets the variables
#   gazebo_services_FOUND
#   gazebo_services_INCLUDE_DIR
#   gazebo_services_LIBRARY
#
# You can use the following components:
#   LuaModel
#   URDFReader
# and then link to them e.g. using gazebo_services_LuaModel_LIBRARY.

SET (gazebo_services_FOUND FALSE)



FIND_PATH (gazebo_services_INCLUDE_DIR gazebo_services/applyForce.h gazebo_services/applyForceRequest.h gazebo_services/applyForceResponse.h 
	HINTS
	$ENV{HOME}/local/include
	$ENV{gazebo_services_PATH}/src
	$ENV{gazebo_services_PATH}/include
	$ENV{gazebo_services_PATH}/
	$ENV{gazebo_services_INCLUDE_PATH}
	/usr/local/include
	/usr/include
	)


#FIND_LIBRARY (gazebo_services_LIBRARY NAMES gazebo_services
#	PATHS
#	$ENV{HOME}/local/lib
#	$ENV{HOME}/local/lib/x86_64-linux-gnu
#	$ENV{gazebo_services_PATH}/lib
#	$ENV{gazebo_services_LIBRARY_PATH}
#	/usr/local/lib
#	/usr/local/lib/x86_64-linux-gnu
#	/usr/lib
#	/usr/lib/x86_64-linux-gnu
#	)

#IF (NOT gazebo_services_LIBRARY)
#	MESSAGE (ERROR "Could not find gazebo_services")
#ENDIF (NOT gazebo_services_LIBRARY)

IF (gazebo_services_INCLUDE_DIR)
	SET (gazebo_services_FOUND TRUE)
ENDIF (gazebo_services_INCLUDE_DIR)



IF (gazebo_services_FOUND)

	 foreach ( COMPONENT ${gazebo_services_FIND_COMPONENTS} )
		 IF (gazebo_services_${COMPONENT}_FOUND)
			 IF (NOT gazebo_services_FIND_QUIETLY)
				 MESSAGE(STATUS "Found gazebo_services ${COMPONENT}: ${gazebo_services_${COMPONENT}_LIBRARY}")
			 ENDIF (NOT gazebo_services_FIND_QUIETLY)
		 ELSE (gazebo_services_${COMPONENT}_FOUND)
			 MESSAGE(SEND_ERROR "Could not find gazebo_services ${COMPONENT}")
		 ENDIF (gazebo_services_${COMPONENT}_FOUND)
	 endforeach ( COMPONENT )
ELSE (gazebo_services_FOUND)
   IF (gazebo_services_FIND_REQUIRED)
		 MESSAGE(SEND_ERROR "Could not find gazebo_services")
   ENDIF (gazebo_services_FIND_REQUIRED)
ENDIF (gazebo_services_FOUND)

MARK_AS_ADVANCED (
	gazebo_services_INCLUDE_DIR
#	gazebo_services_LIBRARY
	)
