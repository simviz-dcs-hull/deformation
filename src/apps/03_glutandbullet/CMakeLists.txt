# -*- Mode:cmake -*-

####################################################################################################
#                                                                                                  #
# Copyright (C) 2014 University of Hull                                                            #
#                                                                                                  #
####################################################################################################

MESSAGE(STATUS "Setting up: ${CMAKE_CURRENT_SOURCE_DIR}")

FIND_PACKAGE(Boost ${BOOST_MINIMUM_VERSION} REQUIRED COMPONENTS filesystem system)
FIND_PACKAGE(GLUT REQUIRED)
FIND_PACKAGE(OpenGL REQUIRED)

SET(APP "03_gluttest")

SET(SRC)

LIST(APPEND SRC "main.cpp")
LIST(APPEND SRC "world.cpp")
LIST(APPEND SRC "object.cpp")

LIST(APPEND SRC "GlutStuff.cpp")
LIST(APPEND SRC "DemoApplication.cpp")
LIST(APPEND SRC "GL_ShapeDrawer.cpp")
LIST(APPEND SRC "GLDebugFont.cpp")


INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR})
INCLUDE_DIRECTORIES(${GLUT_INCLUDE_DIR})
INCLUDE_DIRECTORIES(${OPENGL_INCLUDE_DIR})

SET(LIBS)

LIST(APPEND LIBS ${BULLET_COLLISION_LIBRARY})
LIST(APPEND LIBS ${BULLET_DYNAMICS_LIBRARY})
LIST(APPEND LIBS ${BULLET_MATH_LIBRARY})
LIST(APPEND LIBS ${GLUT_LIBRARIES})
LIST(APPEND LIBS ${OPENGL_gl_LIBRARY})
LIST(APPEND LIBS ${OPENGL_glu_LIBRARY})
LIST(APPEND LIBS ${Boost_LIBRARIES})

APPLICATION_SETUP(${APP} SOURCES ${SRC} DEPENDENCIES ${LIBS})
