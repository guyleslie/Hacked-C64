# Minimum CMake version and project name
cmake_minimum_required(VERSION 3.10)
project(HackedC64_Oscar64)

# Oscar64 root directory is set by the workflow (OSCAR64_PATH or GITHUB_WORKSPACE/oscar64_temp). Fallback only if not set.
if(DEFINED ENV{OSCAR64_PATH})
  set(OSCAR64_PATH $ENV{OSCAR64_PATH})
elseif(DEFINED ENV{GITHUB_WORKSPACE})
  set(OSCAR64_PATH "$ENV{GITHUB_WORKSPACE}/oscar64_temp")
else()
  set(OSCAR64_PATH "${CMAKE_SOURCE_DIR}")
endif()

# Oscar64 binary and include paths (always use these variables below)
# The binary is in oscar64/bin/oscar64.exe after extraction
set(OSCAR64_BIN "${OSCAR64_PATH}/oscar64/bin/oscar64.exe")
set(OSCAR64_INCLUDE "${OSCAR64_PATH}/oscar64/include")
set(OSCAR64_INCLUDE_C64 "${OSCAR64_PATH}/oscar64/include/c64")
set(OSCAR64_INCLUDE_C128 "${OSCAR64_PATH}/oscar64/include/c128")
set(OSCAR64_INCLUDE_AUDIO "${OSCAR64_PATH}/oscar64/include/audio")
set(OSCAR64_INCLUDE_GFX "${OSCAR64_PATH}/oscar64/include/gfx")

# Source files (main.c includes all modules, just like build.bat)
set(SRC_FILES
    ${CMAKE_SOURCE_DIR}/main/src/main.c
)

# Output directory and files
set(BUILD_DIR ${CMAKE_SOURCE_DIR}/build)
file(MAKE_DIRECTORY ${BUILD_DIR})
set(OUTPUT_PRG_DEV "${BUILD_DIR}/Hacked C64-dev.prg")
set(OUTPUT_PRG_RELEASE "${BUILD_DIR}/Hacked C64.prg")

# Include directories (matching build scripts exactly)
set(OSCAR64_INCLUDES
    -i=${OSCAR64_INCLUDE}
    -i=${OSCAR64_INCLUDE_C64}
    -i=${CMAKE_SOURCE_DIR}/main/src/mapgen
)

# Development build command (matching build-dev.bat exactly)
add_custom_command(
    OUTPUT ${OUTPUT_PRG_DEV}
    COMMAND ${OSCAR64_BIN} -o="${OUTPUT_PRG_DEV}" -O0 -g -n -dDEBUG -d__oscar64__ -tf=prg -tm=c64 -dNOLONG -dNOFLOAT -psci ${OSCAR64_INCLUDES} ${SRC_FILES}
    DEPENDS ${SRC_FILES}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMENT "Building development version with Oscar64 (matching build-dev.bat)"
)

# Release build command (matching build-release.bat exactly) 
add_custom_command(
    OUTPUT ${OUTPUT_PRG_RELEASE}
    COMMAND ${OSCAR64_BIN} -o="${OUTPUT_PRG_RELEASE}" -Os -Oo -tf=prg -tm=c64 -dNOLONG -dNOFLOAT -psci ${OSCAR64_INCLUDES} ${SRC_FILES}
    DEPENDS ${SRC_FILES}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMENT "Building release version with Oscar64 (matching build-release.bat)"
)

# Development build target (default for GitHub Actions)
add_custom_target(oscar64_build ALL DEPENDS ${OUTPUT_PRG_DEV})

# Release build target 
add_custom_target(oscar64_build_release DEPENDS ${OUTPUT_PRG_RELEASE})

# Combined build target (builds both)
add_custom_target(oscar64_build_all DEPENDS ${OUTPUT_PRG_DEV} ${OUTPUT_PRG_RELEASE})

# Clean target for build directory
add_custom_target(oscar64_clean
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${BUILD_DIR}
    COMMENT "Cleaning build directory"
)
