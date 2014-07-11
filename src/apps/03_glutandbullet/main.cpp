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

//#include <GL/glut.h>            // gl*
//#include <boost/filesystem.hpp> // boost::filesystem::path
//#include <cstdlib>              // EXIT_SUCCESS
#include "BasicDemo.h"
#include "GlutStuff.h"
#include "btBulletDynamicsCommon.h"
#include "LinearMath/btHashMap.h"

// includes, project

// #include <>

// internal unnamed namespace

namespace {
  
  // types, internal (class, enum, struct, union, typedef)

  // variables, internal
  
  // functions, internal
  
 

} // namespace {

int
main(int argc, char* argv[])
{
  BasicDemo ccdDemo;
  ccdDemo.initPhysics();
  
  return glutmain(argc, argv, 1024, 600, "Bullet physics demo", &ccdDemo);
}
