# -*- Mode:cmake -*-

####################################################################################################
#                                                                                                  #
# Copyright (C) 2014 University of Hull                                                            #
#                                                                                                  #
####################################################################################################

CMAKE_MINIMUM_REQUIRED(VERSION 2.8.4 FATAL_ERROR)

PROJECT(DEFORMATION)

# disallow in-source build
IF("${CMAKE_SOURCE_DIR}" STREQUAL "${CMAKE_BINARY_DIR}")
  MESSAGE(FATAL_ERROR
    "\n"
    "This project requires an out-of-source build.\n"
    "Please create a separate build directory and run CMake there.\n"
    "Consult README.build for command-line examples.")
ENDIF()

IF("" STREQUAL "${CMAKE_BUILD_TYPE}")
  SET(CMAKE_BUILD_TYPE "RelWithDebInfo")
ENDIF()

MESSAGE(STATUS "CMAKE_BUILD_TYPE set to '" ${CMAKE_BUILD_TYPE} "'")

# initial cache to make life easier on window$ (if we ever get there ;)
IF(NOT DEFORMATIONINITCACHELOADED AND EXISTS ${CMAKE_SOURCE_DIR}/CMakeCacheInitial.txt)
  INCLUDE(${CMAKE_SOURCE_DIR}/CMakeCacheInitial.txt)
  SET(DEFORMATIONINITCACHELOADED TRUE CACHE INTERNAL "")
ENDIF()

# globally visible functions/modules/variables
SET(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake")
INCLUDE(SetupProjectOptions)
INCLUDE(SetupFunctions)
INCLUDE(SetupWindowsSDK)
INCLUDE(SetupProjectPaths)
INCLUDE(SetupProjectVariables)
INCLUDE(SetupCompilerPre)

# see [http://athile.net/library/blog/?p=288]
SET_PROPERTY(GLOBAL PROPERTY USE_FOLDERS ON)

# globally added include directories (-I); keep ordering
# 1. project
INCLUDE_DIRECTORIES(${CMAKE_SOURCE_DIR}/inc)

# 2. BOOST
FIND_PACKAGE(Boost ${BOOST_MINIMUM_VERSION} REQUIRED)

INCLUDE(SetupCompilerPost)

# traverse these sub dirs
ADD_SUBDIRECTORY(src)

ADD_CUSTOM_TARGET(ALL_BUILD)
SET_PROPERTY(TARGET ALL_BUILD PROPERTY FOLDER "CMakePredefinedTargets")
