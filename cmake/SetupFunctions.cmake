# -*- Mode:cmake -*-

####################################################################################################
#                                                                                                  #
# Copyright (C) 2014 University of Hull                                                            #
#                                                                                                  #
####################################################################################################

# LIBRARY_SETUP(NAME SOURCES .. [DEPENDENCIES ..] [DEBUG])

FUNCTION(LIBRARY_SETUP LIB_NAME)
  SET(OARGS DEBUG)
  SET(SARGS)
  SET(MARGS SOURCES DEPENDENCIES)
  CMAKE_PARSE_ARGUMENTS(LIB "${OARGS}" "${SARGS}" "${MARGS}" ${ARGN})
  
  IF(NOT LIB_SOURCES)
    MESSAGE(SEND_ERROR "Error: LIBRARY_SETUP() called without any source files")
    RETURN()
  ENDIF()

  FILE(GLOB_RECURSE PUBHDRS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/inc/${LIB_NAME}/*.hpp)
  LIST(APPEND LIB_SOURCES ${PUBHDRS})
  
  FILE(GLOB_RECURSE PUBINLS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/inc/${LIB_NAME}/*.inl)
  LIST(APPEND LIB_SOURCES ${PUBINLS})
  
  FILE(GLOB_RECURSE PRVHDRS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/*.hpp)
  
  LIST(APPEND LIB_SOURCES ${PRVHDRS})
  
  IF(LIB_DEBUG OR VERBOSE)
    MESSAGE(STATUS "LIBRARY_SETUP(${LIB_NAME}) variable setup:\n"
      "   LIB_NAME         = ${LIB_NAME}\n"
      "   LIB_SOURCES      = ${LIB_SOURCES}\n"
      "   LIB_DEPENDENCIES = ${LIB_DEPENDENCIES}")
  ENDIF()
  
  ADD_LIBRARY(${LIB_NAME} ${CMAKE_LIBRARY_TYPE} ${LIB_SOURCES})
  
  SET_PROPERTY(TARGET ${LIB} PROPERTY FOLDER "Libraries")
  SOURCE_GROUP(Source          REGULAR_EXPRESSION ".+\\.cpp")
  SOURCE_GROUP(Header\\Public  REGULAR_EXPRESSION ".+/inc/${LIB_NAME}/.+\\.(hpp|inl)")
  SOURCE_GROUP(Header\\Private REGULAR_EXPRESSION ".+\\.hpp")
  
  TARGET_LINK_LIBRARIES(${LIB_NAME} ${LIB_DEPENDENCIES})
  
  IF(${CMAKE_LIBRARY_TYPE} STREQUAL "SHARED")
    SET(INST_DST_TYPE "LIBRARY")
  ELSE()
    SET(INST_DST_TYPE "ARCHIVE")
  ENDIF()
  
  INSTALL(TARGETS ${LIB_NAME} ${INST_DST_TYPE} DESTINATION ${DEFORMATION_LIBRARY_DIRECTORY}
    COMPONENT lib)

  IF(EXISTS "${CMAKE_SOURCE_DIR}/inc/${LIB_NAME}" AND
      IS_DIRECTORY "${CMAKE_SOURCE_DIR}/inc/${LIB_NAME}")
    INSTALL(DIRECTORY ${CMAKE_SOURCE_DIR}/inc/${LIB_NAME} DESTINATION ${DEFORMATION_HEADER_DIRECTORY}
      COMPONENT hdr)
  ENDIF()
ENDFUNCTION()

# TEST_SETUP(PREFIX SOURCES .. [DEPENDENCIES ..] [DEBUG])

FUNCTION(TEST_SETUP TST_PREFIX)
  SET(OARGS DEBUG)
  SET(SARGS)
  SET(MARGS SOURCES DEPENDENCIES)
  CMAKE_PARSE_ARGUMENTS(TST "${OARGS}" "${SARGS}" "${MARGS}" ${ARGN})

  IF(NOT TST_SOURCES)
    MESSAGE(SEND_ERROR "Error: TEST_SETUP() called without any source files")
    RETURN()
  ENDIF()

  IF(TST_DEBUG OR VERBOSE)
    MESSAGE(STATUS "TEST_SETUP(${TST_PREFIX}) variable setup:\n"
      "   TST_PREFIX       = ${TST_PREFIX}\n"
      "   TST_SOURCES      = ${TST_SOURCES}\n"
      "   TST_DEPENDENCIES = ${TST_DEPENDENCIES}")
  ENDIF()

  SET(TST_EXES)
  SET(TST_TESTS)
  
  FOREACH(APP ${TST_SOURCES})
    GET_FILENAME_COMPONENT(EXE "test_${TST_PREFIX}_${APP}" NAME_WE)
    ADD_EXECUTABLE(${EXE} EXCLUDE_FROM_ALL ${APP})
    SET_PROPERTY(TARGET ${EXE} PROPERTY FOLDER "Tests/${TST_PREFIX}")
    TARGET_LINK_LIBRARIES(${EXE} ${TST_DEPENDENCIES})
    ADD_TEST(${EXE} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${EXE})
    LIST(APPEND TST_EXES ${EXE})
    
    GET_FILENAME_COMPONENT(TEST "unit_test_${TST_PREFIX}_${APP}" NAME_WE)
    ADD_CUSTOM_TARGET(${TEST} COMMAND ${EXE} DEPENDS ${EXE} SOURCES ${APP})
    LIST(APPEND TST_TESTS ${TEST})
  ENDFOREACH(APP)
  
  IF(TST_DEBUG OR VERBOSE)
    MESSAGE(STATUS "TEST_SETUP(${TST_PREFIX}) target setup:\n"
      "   TST_EXES         = ${TST_EXES}\n"
      "   TST_TESTS        = ${TST_TESTS}")
  ENDIF()
  
  IF(DEFORMATION_BLD_UTEST)
    IF(DEFORMATION_RUN_CTEST)
      ADD_CUSTOM_TARGET(test_${TST_PREFIX} COMMAND ${CMAKE_CTEST_COMMAND} DEPENDS ${TST_EXES})
    ELSEIF(DEFORMATION_RUN_UTEST)
      ADD_CUSTOM_TARGET(test_${TST_PREFIX} DEPENDS ${TST_TESTS})
    ELSE()
      ADD_CUSTOM_TARGET(test_${TST_PREFIX} DEPENDS ${TST_EXES})
    ENDIF()
    SET_PROPERTY(TARGET test_${TST_PREFIX} PROPERTY FOLDER "Tests/${TST_PREFIX}")
    ADD_DEPENDENCIES(test_libs test_${TST_PREFIX})
  ENDIF()
ENDFUNCTION()

# APPLICATION_SETUP(NAME SOURCES .. [DEPENDENCIES ..] [DEBUG])

FUNCTION(APPLICATION_SETUP APP_NAME)
  SET(OARGS DEBUG)
  SET(SARGS)
  SET(MARGS SOURCES DEPENDENCIES)
  CMAKE_PARSE_ARGUMENTS(APP "${OARGS}" "${SARGS}" "${MARGS}" ${ARGN})

  IF(NOT APP_SOURCES)
    MESSAGE(SEND_ERROR "Error: APPLICATION_SETUP() called without any source files")
    RETURN()
  ENDIF()

  FILE(GLOB_RECURSE PRVHDRS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/*.hpp)
  LIST(APPEND APP_SOURCES ${PRVHDRS})
  
  SET(APP_NAME "app_${APP_NAME}")

  IF(APP_DEBUG OR VERBOSE)
    MESSAGE(STATUS "APPLICATION_SETUP(${APP_NAME}) variable setup:\n"
      "   APP_NAME         = ${APP_NAME}\n"
      "   APP_SOURCES      = ${APP_SOURCES}\n"
      "   APP_DEPENDENCIES = ${APP_DEPENDENCIES}")
  ENDIF()
  
  ADD_EXECUTABLE(${APP_NAME} ${APP_SOURCES})

  SET_PROPERTY(TARGET ${APP_NAME} PROPERTY FOLDER "Applications")
  SOURCE_GROUP(Source          REGULAR_EXPRESSION ".+\\.cpp")
  SOURCE_GROUP(Header\\Private REGULAR_EXPRESSION ".+\\.hpp")
  
  TARGET_LINK_LIBRARIES(${APP_NAME} ${APP_DEPENDENCIES})

  INSTALL(TARGETS ${APP_NAME} RUNTIME DESTINATION ${DEFORMATION_RUNTIME_DIRECTORY} COMPONENT app)
ENDFUNCTION()
