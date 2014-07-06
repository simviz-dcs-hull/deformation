# -*- Mode:cmake -*-

####################################################################################################
#                                                                                                  #
# Copyright (C) 2014 University of Hull                                                            #
#                                                                                                  #
####################################################################################################

MESSAGE(STATUS "Setting up: ${CMAKE_CURRENT_SOURCE_DIR}")

SET(APP "01_hello_world")

SET(SRC)

LIST(APPEND SRC "main.cpp")
LIST(APPEND SRC "object.cpp")
LIST(APPEND SRC "world.cpp")

INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR})

SET(LIBS)

LIST(APPEND LIBS ${BULLET_COLLISION_LIBRARY})
LIST(APPEND LIBS ${BULLET_DYNAMICS_LIBRARY})
LIST(APPEND LIBS ${BULLET_MATH_LIBRARY})

APPLICATION_SETUP(${APP} SOURCES ${SRC} DEPENDENCIES ${LIBS})
