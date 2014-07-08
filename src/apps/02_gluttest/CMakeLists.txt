# -*- Mode:cmake -*-

####################################################################################################
#                                                                                                  #
# Copyright (C) 2014 University of Hull                                                            #
#                                                                                                  #
####################################################################################################

MESSAGE(STATUS "Setting up: ${CMAKE_CURRENT_SOURCE_DIR}")

SET(APP "02_gluttest")

SET(SRC)

LIST(APPEND SRC "main.cpp")

#INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR})

SET(LIBS)

#LIST(APPEND LIBS ${})

APPLICATION_SETUP(${APP} SOURCES ${SRC} DEPENDENCIES ${LIBS})
