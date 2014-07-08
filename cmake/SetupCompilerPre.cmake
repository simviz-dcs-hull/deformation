# -*- Mode:cmake -*-

####################################################################################################
#                                                                                                  #
# Copyright (C) 2014 University of Hull                                                            #
#                                                                                                  #
####################################################################################################

MESSAGE(STATUS "Applying Compiler Defaults for: "
               "${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}")

INCLUDE(ProcessorCount)
PROCESSORCOUNT(NUM_CPUS)
IF(NUM_CPUS EQUAL 0)
  SET(NUM_CPUS 1)
ENDIF()

SET(CMAKE_LIBRARY_TYPE "LIBRARY_TYPE_UNDEFINED")

IF(${CMAKE_CXX_COMPILER_ID} STREQUAL "Clang")
  SET(CMAKE_LIBRARY_TYPE "SHARED")

  SET(GLOBAL_COMPILER_FLAGS)
  SET(GLOBAL_COMPILER_FLAGS "${GLOBAL_COMPILER_FLAGS} -pipe")
  SET(GLOBAL_COMPILER_FLAGS "${GLOBAL_COMPILER_FLAGS} -Wall -Wextra")
  SET(GLOBAL_COMPILER_FLAGS "${GLOBAL_COMPILER_FLAGS} -Wpointer-arith")
  SET(GLOBAL_COMPILER_FLAGS "${GLOBAL_COMPILER_FLAGS} -fmessage-length=0")
  SET(GLOBAL_COMPILER_FLAGS "${GLOBAL_COMPILER_FLAGS} -fdiagnostics-show-option")
  SET(GLOBAL_COMPILER_FLAGS "${GLOBAL_COMPILER_FLAGS} -ferror-limit=5")

  IF(DEFORMATION_PROFILE)
    SET(GLOBAL_COMPILER_FLAGS "${GLOBAL_COMPILER_FLAGS} --coverage")
  ENDIF()
  
  IF(${CMAKE_CXX_COMPILER_VERSION} VERSION_GREATER "3.0")
    SET(GLOBAL_COMPILER_FLAGS "-std=c++11 ${GLOBAL_COMPILER_FLAGS}")
  ELSE()
    SET(GLOBAL_COMPILER_FLAGS "-std=c++0x ${GLOBAL_COMPILER_FLAGS}")
  ENDIF()

  IF("Release" STREQUAL "${CMAKE_BUILD_TYPE}")
  ELSE()
  ENDIF()

  IF(FALSE)
    IF(${CMAKE_CXX_COMPILER_VERSION} VERSION_GREATER "3.0")
      MESSAGE(STATUS "Enabling runtime address-sanitation support")
      SET(GLOBAL_COMPILER_FLAGS "${GLOBAL_COMPILER_FLAGS} -fsanitize=address")
      SET(GLOBAL_COMPILER_FLAGS "${GLOBAL_COMPILER_FLAGS} -fno-omit-frame-pointer")
    ENDIF()
  ENDIF()
  
  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${GLOBAL_COMPILER_FLAGS}")

ENDIF()

IF(${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU")
  SET(CMAKE_LIBRARY_TYPE "SHARED")

  SET(GLOBAL_COMPILER_FLAGS)
  SET(GLOBAL_COMPILER_FLAGS "${GLOBAL_COMPILER_FLAGS} -pipe")
  SET(GLOBAL_COMPILER_FLAGS "${GLOBAL_COMPILER_FLAGS} -Wall -Wextra")
  SET(GLOBAL_COMPILER_FLAGS "${GLOBAL_COMPILER_FLAGS} -Wpointer-arith")
  SET(GLOBAL_COMPILER_FLAGS "${GLOBAL_COMPILER_FLAGS} -fmessage-length=0")
  SET(GLOBAL_COMPILER_FLAGS "${GLOBAL_COMPILER_FLAGS} -fdiagnostics-show-location=once")
  SET(GLOBAL_COMPILER_FLAGS "${GLOBAL_COMPILER_FLAGS} -fdiagnostics-show-option")

  IF(DEFORMATION_PROFILE)
    SET(GLOBAL_COMPILER_FLAGS "${GLOBAL_COMPILER_FLAGS} --coverage")
  ENDIF()

  IF(${CMAKE_CXX_COMPILER_VERSION} VERSION_GREATER "4.6")
    SET(GLOBAL_COMPILER_FLAGS "-std=c++11 ${GLOBAL_COMPILER_FLAGS}")
  ELSE()
    SET(GLOBAL_COMPILER_FLAGS "-std=c++0x ${GLOBAL_COMPILER_FLAGS}")
  ENDIF()

  IF(${CMAKE_CXX_COMPILER_VERSION} VERSION_GREATER "4.8")
    SET(GLOBAL_COMPILER_FLAGS "${GLOBAL_COMPILER_FLAGS} -fdiagnostics-color=auto")
    SET(GLOBAL_COMPILER_FLAGS "${GLOBAL_COMPILER_FLAGS} -fmax-errors=5")
  ENDIF()

  IF("Release" STREQUAL "${CMAKE_BUILD_TYPE}")
  ELSE()
  ENDIF()

  IF(FALSE)
    IF(${CMAKE_CXX_COMPILER_VERSION} VERSION_GREATER "4.8")
      MESSAGE(STATUS "Enabling runtime address-sanitation support")
      SET(GLOBAL_COMPILER_FLAGS "${GLOBAL_COMPILER_FLAGS} -fsanitize=address")
      SET(GLOBAL_COMPILER_FLAGS "${GLOBAL_COMPILER_FLAGS} -fno-omit-frame-pointer")
    ENDIF()
  ENDIF()

  IF(DEFORMATION_GLIBCXX_PARALLEL)
    SET(GLOBAL_COMPILER_FLAGS "${GLOBAL_COMPILER_FLAGS} -fopenmp")
    ADD_DEFINITIONS("-D_GLIBCXX_PARALLEL")
  ENDIF()

  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${GLOBAL_COMPILER_FLAGS}")

ENDIF()

IF(${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU" OR ${CMAKE_CXX_COMPILER_ID} STREQUAL "Clang")
  IF(DEFORMATION_PROFILE)
    SET(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} --coverage")
  ENDIF()
  
  # linker flags
  IF("Release" STREQUAL "${CMAKE_BUILD_TYPE}")
    SET(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,-O1")
  ENDIF()
  
  SET(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,--demangle")
  SET(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,--fatal-warnings")
  
  # BOOST
  SET(Boost_DEBUG               FALSE)
  # SET(Boost_USE_STATIC_LIBS     ON)
  SET(Boost_USE_MULTITHREAD     ON)
  ADD_DEFINITIONS(${Boost_LIB_DIAGNOSTIC_DEFINITIONS})
  ADD_DEFINITIONS("-DBOOST_ALL_DYN_LINK")

ENDIF()

IF(${CMAKE_CXX_COMPILER_ID} STREQUAL "MSVC")
  SET(CMAKE_LIBRARY_TYPE "STATIC")

  SET(DISABLED_WARNINGS)
  LIST(APPEND DISABLED_WARNINGS " /wd4201") # nonstandard extension used : nameless struct/union
  LIST(APPEND DISABLED_WARNINGS " /wd4351") # new behavior: elements of array '*' will be default
                                            # initialized
  LIST(APPEND DISABLED_WARNINGS " /wd4512") # assignment operator could not be generated
  LIST(APPEND DISABLED_WARNINGS " /wd4519") # default template arguments are only allowed on a
                                            # class template
  LIST(APPEND DISABLED_WARNINGS " /wd4702") # unreachable code (somewhere in boost)

  SET(GLOBAL_COMPILER_FLAGS)
  SET(GLOBAL_COMPILER_FLAGS "${GLOBAL_COMPILER_FLAGS} /W4")  # warn almost everything
  SET(GLOBAL_COMPILER_FLAGS "${GLOBAL_COMPILER_FLAGS} ${DISABLED_WARNINGS}")
  SET(GLOBAL_COMPILER_FLAGS "${GLOBAL_COMPILER_FLAGS} /EHa") # exception-handling for asynchronous
                                                             # (structured) and synchronous (C++)
                                                             # exceptions
  SET(GLOBAL_COMPILER_FLAGS "${GLOBAL_COMPILER_FLAGS} /MP${NUM_CPUS}") # parallel compile

  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${GLOBAL_COMPILER_FLAGS}")

  # avoid pulling all of windows.h
  ADD_DEFINITIONS("-DWIN32_LEAN_AND_MEAN")
  ADD_DEFINITIONS("WIN32_EXTRA_LEAN")
  # http://stackoverflow.com/questions/5004858/stdmin-gives-error
  ADD_DEFINITIONS("-DNOMINMAX")
  # get rid of (stupid/obfuscated) security warnings
  ADD_DEFINITIONS("-D_CRT_SECURE_NO_DEPRECATE")
  ADD_DEFINITIONS("-D_CRT_SECURE_NO_WARNINGS")
  ADD_DEFINITIONS("-D_CRT_NONSTDC_NO_DEPRECATE")
  ADD_DEFINITIONS("-D_SCL_SECURE_NO_WARNINGS")
  ADD_DEFINITIONS("-D_SCL_SECURE_NO_DEPRECATE")
  ADD_DEFINITIONS("-D_SECURE_SCL=0")
  # doesn't work with default boost-library selection
  # ADD_DEFINITIONS("-D_HAS_ITERATOR_DEBUGGING=0")

  # D3D11
  ADD_DEFINITIONS("-DD3D11_NO_HELPERS") # see ${WIN8SDK_DIR}\Include\um\d3d11.idl

  # BOOST
  SET(Boost_DEBUG               FALSE)
  SET(Boost_USE_STATIC_LIBS     ON)
  SET(Boost_USE_MULTITHREAD     ON)

  ADD_DEFINITIONS(${Boost_LIB_DIAGNOSTIC_DEFINITIONS})
  # ADD_DEFINITIONS("-DBOOST_ALL_DYN_LINK")

ENDIF()
