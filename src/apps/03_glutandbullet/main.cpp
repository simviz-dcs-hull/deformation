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
  keyboard(unsigned char key, int x, int y) 
  {
    if (key == 'q') 
    {
      exit(EXIT_SUCCESS);
    }
  }
  void 
  reshape(int w, int h) 
  {
    float ratio = 1.0 * w/h;
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glViewport(0,0,w,h);
    gluPerspective(45,ratio,1,1000);
    glMatrixMode(GL_MODELVIEW);
  }
  void
  idle()
  {
    //something
    glutPostRedisplay();
  }
  void
  display()
  {
    glClearColor(0.0, 0.0, 0.0, 1.0);
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
  glutIdleFunc          (&idle);
  glutReshapeFunc       (&reshape);
  glutKeyboardFunc      (&keyboard);

  glutMainLoop();

  return EXIT_SUCCESS;
}
