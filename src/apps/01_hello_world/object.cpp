// -*- Mode:C++ -*-

/**************************************************************************************************/
/*                                                                                                */
/* Copyright (C) 2014 University of Hull                                                          */
/*                                                                                                */
/**************************************************************************************************/
/*                                                                                                */
/*  module     :  apps/01_hello_world/object.cpp                                                  */
/*  project    :                                                                                  */
/*  description:                                                                                  */
/*                                                                                                */
/**************************************************************************************************/

// include i/f header

#include "object.hpp"

// includes, system

#include <ostream> // std::ostream<>

// includes, project

#include <world.hpp>

// internal unnamed namespace

namespace {
  
  // types, internal (class, enum, struct, union, typedef)

  // variables, internal
  
  // functions, internal

} // namespace {

namespace bullet {
  
  // variables, exported
  
  // functions, exported

  /* explicit */
  object::object(world& a, btCollisionShape* b, float c, btTransform const& d)
    : world_(a),
      shape_(b),
      mass_ (c),
      body_ (nullptr),
      xform_(d)
  {
    if (shape_) {
      btDefaultMotionState* const motion_state(new btDefaultMotionState(xform_));
      btVector3                   inertia     (0, 0, 0);

      if (0.0f < mass_) {
        shape_->calculateLocalInertia(mass_, inertia);
      }
      
      btRigidBody::btRigidBodyConstructionInfo construction_info(mass_,
                                                                 motion_state,
                                                                 shape_,
                                                                 inertia);
      
      body_ = new btRigidBody(construction_info);

      world_.add(body_);
    }
  }
  
  object::~object()
  {
    if (body_) {
      world_.sub(body_);
      
      delete body_->getMotionState();
      delete body_;
    }

    delete shape_;
  }

  void
  object::update()
  {
    if (body_) {
      body_->getMotionState()->getWorldTransform(xform_);
    }
  }
  
  std::ostream&
  operator<<(std::ostream& os, object const& a)
  {
    typename std::ostream::sentry const cerberus(os);

    if (cerberus) {
      os << '['
         << "pos:"
         << '('
         << a.xform_.getOrigin().getX() << ','
         << a.xform_.getOrigin().getY() << ','
         << a.xform_.getOrigin().getZ()
         << ')'
         << ']';
    }
    
    return os;
  }
  
} // namespace bullet {
