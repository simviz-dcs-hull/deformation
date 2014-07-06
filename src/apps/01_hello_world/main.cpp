// -*- Mode:C++ -*-

/**************************************************************************************************/
/*                                                                                                */
/* Copyright (C) 2014 University of Hull                                                          */
/*                                                                                                */
/**************************************************************************************************/
/*                                                                                                */
/*  module     :  src/apps/01_hello_world/main.cpp                                                */
/*  project    :                                                                                  */
/*  description:                                                                                  */
/*                                                                                                */
/**************************************************************************************************/

// includes, system

#include <array>    // std::array
#include <cstdlib>  // EXIT_SUCCESS
#include <iomanip>  // std::setfill, std::setw
#include <iostream> // std::*

// includes, project

#include <object.hpp>
#include <world.hpp>

// internal unnamed namespace

namespace {
  
  // types, internal (class, enum, struct, union, typedef)
  
  // variables, internal
  
  // functions, internal

} // namespace {

int
main()
{
  bullet::world world;

  std::array<bullet::object, 4> object_list = {
    {
      bullet::object(world,
                     new btStaticPlaneShape(btVector3(0, 1, 0), 1),
                     0.0f,
                     btTransform(btQuaternion(0, 0, 0, 1), btVector3(0, -1, 0))),
      bullet::object(world,
                     new btSphereShape(1),
                     1.0f,
                     btTransform(btQuaternion(0, 0, 0, 1), btVector3(0, 50, 0))),
      bullet::object(world,
                     new btSphereShape(1),
                     2.0f,
                     btTransform(btQuaternion(0, 1, 0, 1), btVector3(10, 30, 0))),
      bullet::object(world,
                     nullptr),
    }
  };
  
  for (unsigned i(0); i < 100; ++i) {
    world.simulate(1/100.f, 11, 1/1000.f);

    for (auto& o : object_list) {
      o.update();

      std::cout << std::setfill(' ') << std::setw(3) << i << '@' << &o << ": " << o << std::endl;
    }
  }
    
  return EXIT_SUCCESS;
}

