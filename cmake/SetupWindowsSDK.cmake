# -*- Mode:cmake -*-

####################################################################################################
#                                                                                                  #
# Copyright (C) 2014 University of Hull                                                            #
#                                                                                                  #
####################################################################################################

# 'What's up with D3DCompiler_xx.DLL?'
# see [http://blogs.msdn.com/b/chuckw/archive/2010/04/22/what-s-up-with-d3dcompiler-xx-dll.aspx]

# 'Where is the DirectX SDK?'
# see [http://blogs.msdn.com/b/chuckw/archive/2012/03/22/where-is-the-directx-sdk.aspx]

# 'HLSL, FXC, and D3DCompile'
# see [http://blogs.msdn.com/b/chuckw/archive/2012/05/07/hlsl-fxc-and-d3dcompile.aspx]

# windows sdk install root
# % reg query "HKLM\SOFTWARE\Microsoft\Windows Kits\Installed Roots" /v "KitsRoot"
# % reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SDKs\Windows\v8.0A" /v "InstallationFolder"

IF(MSVC)
  # 1. DirectX SDK (June 2010) specifics; note: this sdk is deprecated in favour of the Windows SDK
  # actually, it seems that the Windows (8) SDK does install over previously installed DirectX SDKs
  # without deinstalling/removing them!
  IF(NOT "" STREQUAL "$ENV{DXSDK_DIR}")
    IF(NOT VERBOSE)
      MESSAGE(STATUS "Found DirectX SDK environment variable DXSDK_DIR!")
    ELSE()
      IF(EXISTS $ENV{DXSDK_DIR})
	MESSAGE(AUTHOR_WARNING "Found DirectX SDK in '$ENV{DXSDK_DIR}'! (not used)")
	# INCLUDE_DIRECTORIES($ENV{DXSDK_DIR}/Samples/C++/Effects11/Inc)
      ELSE()
	MESSAGE(AUTHOR_WARNING "DXSDK_DIR set to '$ENV{DXSDK_DIR}', but path non-existent")
      ENDIF()
    ENDIF()
  ENDIF()

  # 2. NVIDIA Graphics SDK 11
  IF(NOT "" STREQUAL "$ENV{NVSDK11D3D_ROOT}")
    IF(NOT VERBOSE)
      MESSAGE(STATUS "Found NVIDIA D3D11 SDK environment variable NVSDK11D3D_ROOT!")
    ELSE()
      IF(EXISTS $ENV{NVSDK11D3D_ROOT})
	MESSAGE(AUTHOR_WARNING "Found NVIDIA D3D11 SDK in '$ENV{NVSDK11D3D_ROOT}'! (not used)")
	# INCLUDE_DIRECTORIES($ENV{NVSDK11D3D_ROOT}/Include)
      ELSE()
	MESSAGE(AUTHOR_WARNING "NVSDK11D3D_ROOT set to '$ENV{NVSDK11D3D_ROOT}', but path non-existent")
      ENDIF()
    ENDIF()
  ENDIF()

  IF(NOT REG)
    FIND_PROGRAM(REG reg HINTS "C:/Windows/system32/reg.exe" DOC "Registry console tool")
    IF(NOT REG)
      MESSAGE(SEND_ERROR "Error: unable to find registry console tool (reg)")
    ELSE()
      MESSAGE(STATUS "Found registry console tool: ${REG}")
    ENDIF(NOT REG)
  ENDIF()

  EXECUTE_PROCESS(
    COMMAND ${REG} query "HKLM\\SOFTWARE\\Microsoft\\Windows Kits\\Installed Roots" /v KitsRoot
    RESULT_VARIABLE REG_QUERY_RESULT
    OUTPUT_VARIABLE REG_QUERY_OUTPUT
    ERROR_VARIABLE  REG_QUERY_ERROR)
  
  IF(NOT $REG_QUERY_RESULT AND NOT "" STREQUAL "${REG_QUERY_OUTPUT}")
    STRING(REGEX REPLACE "\n"     ""  REG_QUERY_OUTPUT "${REG_QUERY_OUTPUT}")
    STRING(REGEX REPLACE "REG_SZ" ";" REG_QUERY_OUTPUT "${REG_QUERY_OUTPUT}")
    LIST(REMOVE_AT REG_QUERY_OUTPUT 0)
    STRING(STRIP ${REG_QUERY_OUTPUT} REG_QUERY_OUTPUT)
    STRING(REGEX REPLACE "\\\\"   "/" REG_QUERY_OUTPUT "${REG_QUERY_OUTPUT}")
  ENDIF()

  SET(WINDOWS8SDK_DIR "C:/Program Files (x86)/Windows Kits/8.0/")
  
  IF(EXISTS ${REG_QUERY_OUTPUT})
    SET(WINDOWS8SDK_DIR ${REG_QUERY_OUTPUT})
  ENDIF()

  STRING(REGEX REPLACE "/+$" "" WINDOWS8SDK_DIR "${WINDOWS8SDK_DIR}") 

  IF(NOT EXISTS ${WINDOWS8SDK_DIR})
    MESSAGE(WARNING "Unable to find Windows8 SDK!")
  ELSE()
    MESSAGE(STATUS "Found Windows8 SDK at '${WINDOWS8SDK_DIR}'")
  ENDIF()
ENDIF()
