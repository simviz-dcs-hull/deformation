// -*- Mode:C++ -*-

/**************************************************************************************************/
/*                                                                                                */
/* Copyright (C) 2014 University of Hull                                                          */
/*                                                                                                */
/**************************************************************************************************/
/*                                                                                                */
/*  module     :  src/apps/02_gluttest.cpp                                                        */
/*  project    :                                                                                  */
/*  description:                                                                                  */
/*                                                                                                */
/**************************************************************************************************/

// includes, system

#include <GL/glut.h>            // gl*
#include <array>                // std::array<>
#include <algorithm>            // std::m[ax|in]<>
#include <boost/filesystem.hpp> // boost::filesystem::path
#include <cmath>                // std::cos<>, std::sin<>
#include <cstdlib>              // EXIT_SUCCESS, std::exit

// includes, project

// #include <>

// internal unnamed namespace

namespace {
  
  // types, internal (class, enum, struct, union, typedef)

  typedef std::array<float, 2> vec2f_t;
  typedef std::array<float, 3> vec3f_t;
  typedef std::array<float, 4> vec4f_t;
  
  // variables, internal

  vec3f_t cam_pos   = { { 0.0, 1.0,  5.0 } };
  vec3f_t cam_dir   = { { 0.0, 0.0, -1.0 } };
  vec3f_t cam_up    = { { 0.0, 1.0,  0.0 } };
  vec4f_t clr_color = { { 0.2, 0.2,  0.2, 1.0 } };
  
  // functions, internal

  void
  draw_ground()
  {
    glColor3f(0.9f, 0.9f, 0.9f);
    glBegin(GL_QUADS);
    {
      glVertex3f(-100.0f, 0.0f, -100.0f);
      glVertex3f(-100.0f, 0.0f,  100.0f);
      glVertex3f( 100.0f, 0.0f,  100.0f);
      glVertex3f( 100.0f, 0.0f, -100.0f);
    }
    glEnd();
  }
  
  void
  draw_snow_man()
  {
    glColor3f(1.0f, 1.0f, 1.0f);

    // Draw Body
    glTranslatef(0.0f ,0.75f, 0.0f);
    glutSolidSphere(0.75f,20,20);

    // Draw Head
    glTranslatef(0.0f, 1.0f, 0.0f);
    glutSolidSphere(0.25f,20,20);

    // Draw Eyes
    glPushMatrix();
    {
      glColor3f(0.0f,0.0f,0.0f);
      glTranslatef(0.05f, 0.10f, 0.18f);
      glutSolidSphere(0.05f,10,10);
      glTranslatef(-0.1f, 0.0f, 0.0f);
      glutSolidSphere(0.05f,10,10);
    }
    glPopMatrix();

    // Draw Nose
    glColor3f(1.0f, 0.5f , 0.5f);
    glutSolidCone(0.08f,0.5f,10,2);
  }
  
  void
  display()
  {
    glClearColor(clr_color[0], clr_color[2], clr_color[2], clr_color[3]);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    glLoadIdentity();
    gluLookAt(	cam_pos[0],              cam_pos[1],              cam_pos[2],
                cam_pos[0] + cam_dir[0], cam_pos[1] + cam_dir[1], cam_pos[2] + cam_dir[2],
                cam_up[0],               cam_up[1],               cam_up[2]);
    
    draw_ground();
    
    for (signed i(-3); i < 3; ++i) {
      for (signed j(-3); j < 3; ++j) {
        glPushMatrix();
        {
          glTranslatef(i * 10.0, 0.0, j * 10.0);
          draw_snow_man();
        }
        glPopMatrix();
      }
    }
    
    glutSwapBuffers();
  }

  void
  reshape(signed w, signed h)
  {
    float ratio(float(w) / float((h == 0) ? 1 : h));
    
    glMatrixMode(GL_PROJECTION);
    {
      glLoadIdentity();
      glViewport    (0, 0, w, h);
      gluPerspective(45, ratio, 0.1, 1000);
    }
    glMatrixMode(GL_MODELVIEW);
  }
  
  void
  kbd_keyboard(unsigned char key, int /* x */, int /* y */)
  {
    static float fraction(0.1);
    
    switch (key) {
    case 27: /* ESC */
    case 'Q':
    case 'q':
      std::exit(EXIT_SUCCESS);
      break;

    case 'u':
      {
        cam_pos[1] += cam_up[1] * fraction;
      }
      break;

    case 'd':
      {
        cam_pos[1] -= cam_up[1] * fraction;
      }
      break;
      
    default:
      break;
    };

    glutPostRedisplay();
  }

  void
  kbd_special(signed key, signed /* x */, signed /* y */)
  {
    static float angle   (0.0);
    static float fraction(0.1);
    
    switch (key) {
    case GLUT_KEY_LEFT:
      {
        angle -= 0.01f;
        
        cam_dir[0] =  std::sin(angle);
        cam_dir[2] = -std::cos(angle);
      }
      break;

    case GLUT_KEY_RIGHT:
      {
        angle += 0.01f;
        
        cam_dir[0] =  std::sin(angle);
        cam_dir[2] = -std::cos(angle);
      }
      break;

    case GLUT_KEY_UP:
      {
        cam_pos[0] += cam_dir[0] * fraction;
        cam_pos[2] += cam_dir[2] * fraction;
      }
      break;

    case GLUT_KEY_DOWN:
      {
        cam_pos[0] -= cam_dir[0] * fraction;
        cam_pos[2] -= cam_dir[2] * fraction;
      }
      break;
      
    default:
      break;
    }

    glutPostRedisplay();
  }
  
} // namespace {

int
main(int argc, char* argv[])
{
  glutInit(&argc, argv);

  glutInitDisplayMode   (GLUT_RGBA | GLUT_DOUBLE | GLUT_DEPTH);
  glutInitWindowSize    (800, 600);
  glutInitWindowPosition(300, 200);
  glutCreateWindow      (boost::filesystem::path(argv[0]).filename().string().c_str());
  glutDisplayFunc       (&display);
  glutReshapeFunc       (&reshape);
  glutKeyboardFunc      (&kbd_keyboard);
  glutSpecialFunc       (&kbd_special);

  glEnable(GL_DEPTH_TEST);
  
  glutMainLoop();

  return EXIT_SUCCESS;
}
