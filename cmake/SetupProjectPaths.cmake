# -*- Mode:cmake -*-

####################################################################################################
#                                                                                                  #
# Copyright (C) 2014 University of Hull                                                            #
#                                                                                                  #
####################################################################################################

# sub directories, relative to CMAKE_BINARY_DIR or CMAKE_INSTALL_PREFIX
# depending on if they are used during build or install
SET(DEFORMATION_CPACK_DIRECTORY   cpack)
SET(DEFORMATION_RUNTIME_DIRECTORY bin)

IF(WIN32 OR WIN64)
  SET(DEFORMATION_LIBRARY_DIRECTORY bin)
ELSE()
  SET(DEFORMATION_LIBRARY_DIRECTORY lib)
ENDIF()

SET(DEFORMATION_HEADER_DIRECTORY  include)
SET(DEFORMATION_SHARE_DIRECTORY   share)
SET(DEFORMATION_DOC_DIRECTORY     ${DEFORMATION_SHARE_DIRECTORY}/doc)
SET(DEFORMATION_EXTRA_DIRECTORY   ${DEFORMATION_SHARE_DIRECTORY}/extra)
SET(DEFORMATION_SHADER_DIRECTORY  ${DEFORMATION_SHARE_DIRECTORY}/shader)

# output directories, overwrite
SET(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${DEFORMATION_LIBRARY_DIRECTORY})
SET(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${DEFORMATION_LIBRARY_DIRECTORY})
SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${DEFORMATION_RUNTIME_DIRECTORY})

# output directories, project specific
SET(CMAKE_DOC_OUTPUT_DIRECTORY     ${CMAKE_BINARY_DIR}/${DEFORMATION_DOC_DIRECTORY})
SET(CMAKE_EXTRA_OUTPUT_DIRECTORY   ${CMAKE_BINARY_DIR}/${DEFORMATION_EXTRA_DIRECTORY})
SET(CMAKE_SHADER_OUTPUT_DIRECTORY  ${CMAKE_BINARY_DIR}/${DEFORMATION_SHADER_DIRECTORY})
