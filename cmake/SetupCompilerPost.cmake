# -*- Mode:cmake -*-

####################################################################################################
#                                                                                                  #
# Copyright (C) 2014 University of Hull                                                            #
#                                                                                                  #
####################################################################################################

FUNCTION(PRINT_LIBRARY_SETUP)
  MESSAGE(STATUS "CMAKE_CXX_FLAGS           = ${CMAKE_CXX_FLAGS}")
  MESSAGE(STATUS "BOOST_LIBRARYDIR          = ${BOOST_LIBRARYDIR}")
  MESSAGE(STATUS "Boost_LIBRARY_DIR         = ${Boost_LIBRARY_DIR}")
  MESSAGE(STATUS "Boost_LIBRARY_DIRS        = ${Boost_LIBRARY_DIRS}")
  MESSAGE(STATUS "CMAKE_SHARED_LINKER_FLAGS = ${CMAKE_SHARED_LINKER_FLAGS}")
  MESSAGE(STATUS "CMAKE_MODULE_LINKER_FLAGS = ${CMAKE_MODULE_LINKER_FLAGS}")
  MESSAGE(STATUS "CMAKE_EXE_LINKER_FLAGS    = ${CMAKE_EXE_LINKER_FLAGS}")
ENDFUNCTION()

MESSAGE(STATUS "Setting Library Paths for: "
               "${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}")

# with gcc/clang handle boost/glm/gli include dirs like system-header dirs, i.e. do not warn
# questionable things from there; note: only works for real non-system-header dirs!
IF(${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU" OR ${CMAKE_CXX_COMPILER_ID} STREQUAL "Clang")
  IF(NOT ${Boost_INCLUDE_DIR} STREQUAL "/usr/include")
    ADD_DEFINITIONS("-isystem ${Boost_INCLUDE_DIR}")
  ENDIF()
ELSE()
  INCLUDE_DIRECTORIES(${Boost_INCLUDE_DIR})
ENDIF()

IF(${CMAKE_CXX_COMPILER_ID} STREQUAL "MSVC")
  # BOOST
  FOREACH(dir ${Boost_LIBRARY_DIRS})
    IF(EXISTS "${dir}" AND IS_DIRECTORY "${dir}")
      SET(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} /LIBPATH:${dir}")
      SET(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} /LIBPATH:${dir}")
      SET(CMAKE_EXE_LINKER_FLAGS    "${CMAKE_EXE_LINKER_FLAGS} /LIBPATH:${dir}")
    ENDIF()
  ENDFOREACH()
ENDIF()

IF(VERBOSE)
  PRINT_LIBRARY_SETUP()
ENDIF()
