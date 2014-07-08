// -*- Mode:C++ -*-

/**************************************************************************************************/
/*                                                                                                */
/* Copyright (C) 2014 University of Hull                                                          */
/*                                                                                                */
/**************************************************************************************************/
/*                                                                                                */
/*  module     :  apps/01_hello_world/object.hpp                                                  */
/*  project    :                                                                                  */
/*  description:                                                                                  */
/*                                                                                                */
/**************************************************************************************************/

#if !defined(UKACHULLDCS_DEFORMATION_APPS_HELLOWORLD_OBJECT_HPP)

#define UKACHULLDCS_DEFORMATION_APPS_HELLOWORLD_OBJECT_HPP

// includes, system

#include <btBulletDynamicsCommon.h> // bt*
#include <iosfwd>                   // std::ostream<> (fwd decl)

// includes, project

// #include <>

namespace bullet {

  class world;
  
  // types, exported (class, enum, struct, union, typedef)
  
  class object {

  public:
    
    explicit object(world&              /* world */,
                    btCollisionShape*   /* shape */,
                    float               /* mass  */ = 0.0f,
                    btTransform const&  /* xform */ = btTransform(btQuaternion(0, 0, 0, 1),
                                                                  btVector3   (0, 0, 0)));
            ~object();

    void update();
    
  private:

    friend std::ostream& operator<<(std::ostream&, object const&);
    
    world&            world_;
    btCollisionShape* shape_;
    float const       mass_;
    btRigidBody*      body_;
    btTransform       xform_;
    
  };
  
  // variables, exported (extern)

  // functions, inlined (inline)
  
  // functions, exported (extern)

  std::ostream& operator<<(std::ostream&, object const&);
  
} // namespace bullet {

#endif // #if !defined(UKACHULLDCS_DEFORMATION_APPS_HELLOWORLD_OBJECT_HPP)
