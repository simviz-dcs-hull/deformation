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

#include <GL/glut.h> // gl*
#include <cstdlib>   // EXIT_SUCCESS

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
  glutCreateWindow      ("Hello World!");
  glutDisplayFunc       (&display);

  glutMainLoop();

  return EXIT_SUCCESS;
}
