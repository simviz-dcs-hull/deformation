// -*- Mode:C++ -*-

/**************************************************************************************************/
/*                                                                                                */
/* Copyright (C) 2014 University of Hull                                                          */
/*                                                                                                */
/**************************************************************************************************/
/*                                                                                                */
/*  module     :  apps/03_glutandbullet/world.hpp                                                 */
/*  project    :                                                                                  */
/*  description:                                                                                  */
/*                                                                                                */
/**************************************************************************************************/

// include i/f header

#include "world.hpp"

// includes, system

#include <iostream> // std::cout

// includes, project

// #include <>

// internal unnamed namespace

namespace {
  
  // types, internal (class, enum, struct, union, typedef)

  // variables, internal
  
  // functions, internal

  void
  tick_cb(btDynamicsWorld* world, btScalar delta_t)
  {
    std::cout << "world @" << world->getWorldUserInfo() << " ticked by " << delta_t << "s\n";
  }
  
} // namespace {

namespace bullet {
  
  // variables, exported
  
  // functions, exported

  /* explicit */
  world::world()
    : broadphase_          (new btDbvtBroadphase),
      collision_config_    (new btDefaultCollisionConfiguration),
      collision_dispatcher_(new btCollisionDispatcher(collision_config_.get())),
      solver_              (new btSequentialImpulseConstraintSolver),
      world_               (new btDiscreteDynamicsWorld(collision_dispatcher_.get(),
                                                        broadphase_.get(),
                                                        solver_.get(),
                                                        collision_config_.get()))
  {
    world_->setInternalTickCallback(&tick_cb, static_cast<void*>(this));
    world_->setGravity             (btVector3(0, -9.81, 0));
  }

  void
  world::simulate(float a, unsigned b, float c)
  {
    while (a >= (b * c)) {
      ++b;
    }
    
    world_->stepSimulation(a, b, c);
  }
  
  void
  world::add(btRigidBody* a)
  {
    world_->addRigidBody(a);
  }
  
  void
  world::sub(btRigidBody* a)
  {
    world_->removeRigidBody(a);
  }
  
} // namespace bullet {
