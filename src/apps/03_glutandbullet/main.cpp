// -*- Mode:C++ -*-

/**************************************************************************************************/
/*                                                                                                */
/* Copyright (C) 2014 University of Hull                                                          */
/*                                                                                                */
/**************************************************************************************************/
/*                                                                                                */
/*  module     :  src/apps/03_glutandbullet.cpp                                                   */
/*  project    :                                                                                  */
/*  description:                                                                                  */
/*                                                                                                */
/**************************************************************************************************/

// includes, system

#include <GL/glut.h>            // gl*
#include <boost/filesystem.hpp> // boost::filesystem::path
#include <cstdlib>              // EXIT_SUCCESS

// includes, project

// #include <>

// internal unnamed namespace

namespace {
  
  // types, internal (class, enum, struct, union, typedef)

  // variables, internal
  
  // functions, internal

  void
  display()
  {
    glClearColor(0.8, 0.8, 0.8, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    glutSwapBuffers();
  }

} // namespace {

int
main(int argc, char* argv[])
{
  glutInit(&argc, argv);

  glutInitDisplayMode   (GLUT_RGB | GLUT_DOUBLE | GLUT_DEPTH);
  glutInitWindowSize    (500, 500);
  glutInitWindowPosition(300, 200);
  glutCreateWindow      (boost::filesystem::path(argv[0]).filename().string().c_str());
  glutDisplayFunc       (&display);

  glutMainLoop();

  return EXIT_SUCCESS;
}
