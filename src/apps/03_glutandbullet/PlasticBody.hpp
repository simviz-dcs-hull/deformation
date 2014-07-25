// -*- Mode:C++ -*-

/**************************************************************************************************/
/*                                                                                                */
/* Copyright (C) 2014 University of Hull                                                          */
/*                                                                                                */
/**************************************************************************************************/
/*                                                                                                */
/*  module     :  PlasticBody.hpp                                                                 */
/*  project    :                                                                                  */
/*  description:                                                                                  */
/*                                                                                                */
/**************************************************************************************************/

#if !defined(UKACHULLDCS_DEFORMATION_PLASTICBODY_HPP)

#define UKACHULLDCS_DEFORMATION_PLASTICBODY_HPP

#include <btConvexTriangleMeshShape.h>
#include "btBulletDynamicsCommon.h"

class PlasticBody {
  public:
    enum BODYSTATE { rigid, soft };
    enum BODYTYPE { convex, concave };
    const BODYSTATE& getState();
    btRigidBody* rigidBody;
    

  private:
    BODYSTATE bodyState;
    void toggleState();
    btSoftBody* softBody;
    btSoftBody getSoftFromRigid(btRigidBody);
  protected:

}

#endif // #if !defined(UKACHULLDCS_DEFORMATION_PROTO_HPP)
