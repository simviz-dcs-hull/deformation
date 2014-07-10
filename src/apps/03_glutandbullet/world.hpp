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

#if !defined(UKACHULLDCS_DEFORMATION_APPS_GLUTANDBULLET_WORLD_HPP)

#define UKACHULLDCS_DEFORMATION_APPS_GLUTANDBULLET_WORLD_HPP

// includes, system

#include <btBulletDynamicsCommon.h> // bt*
#include <memory>                   // std::unique_ptr<>

// includes, project

// #include <>

namespace bullet {
  
  // types, exported (class, enum, struct, union, typedef)

  class world {

  public:

    typedef std::unique_ptr<btBroadphaseInterface>               broadphase_type;
    typedef std::unique_ptr<btDefaultCollisionConfiguration>     collision_config_type;
    typedef std::unique_ptr<btCollisionDispatcher>               collision_dispatcher_type;
    typedef std::unique_ptr<btSequentialImpulseConstraintSolver> constraint_solver_type;
    typedef std::unique_ptr<btDynamicsWorld>                     world_type;
    
    explicit world();

    /**
     * delta_t < sub-steps * fixed delta_t (all in seconds!)
     */
    void simulate(float    /* delta_t       */,
                  unsigned /* sub-steps     */ = 1,
                  float    /* fixed delta_t */ = 1/60.0f);
    
    void add(btRigidBody*);
    void sub(btRigidBody*);
    
  private:

    broadphase_type           broadphase_;
    collision_config_type     collision_config_;
    collision_dispatcher_type collision_dispatcher_;
    constraint_solver_type    solver_;
    world_type                world_;
    
  };
  
  // variables, exported (extern)

  // functions, inlined (inline)
  
  // functions, exported (extern)
  
} // namespace bullet {

#endif // #if !defined(UKACHULLDCS_DEFORMATION_APPS_GLUTANDBULLET_WORLD_HPP)
