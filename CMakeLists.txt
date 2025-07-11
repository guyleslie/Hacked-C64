# Minimum CMake version and project name
cmake_minimum_required(VERSION 3.10)
project(HackedC64_Oscar64)

# Oscar64 root directory is set by the workflow (OSCAR64_PATH). Fallback only if not set.
if(NOT OSCAR64_PATH)
  set(OSCAR64_PATH "E:/Apps/oscar64")
endif()

# Oscar64 binary and include paths (always use these variables below)
set(OSCAR64_BIN "${OSCAR64_PATH}/bin/oscar64.exe")
set(OSCAR64_INCLUDE "${OSCAR64_PATH}/include")
set(OSCAR64_INCLUDE_C64 "${OSCAR64_PATH}/include/c64")
set(OSCAR64_INCLUDE_C128 "${OSCAR64_PATH}/include/c128")
set(OSCAR64_INCLUDE_AUDIO "${OSCAR64_PATH}/include/audio")
set(OSCAR64_INCLUDE_GFX "${OSCAR64_PATH}/include/gfx")

# Source files (explicit list, as in build.bat)
set(SRC_FILES
    ${CMAKE_SOURCE_DIR}/main/src/main.c
    ${CMAKE_SOURCE_DIR}/main/src/mapgen/map_export.c
    ${CMAKE_SOURCE_DIR}/main/src/mapgen/map_generation.c
    ${CMAKE_SOURCE_DIR}/main/src/mapgen/public.c
    ${CMAKE_SOURCE_DIR}/main/src/mapgen/room_management.c
    ${CMAKE_SOURCE_DIR}/main/src/mapgen/rule_based_connection_system.c
    ${CMAKE_SOURCE_DIR}/main/src/mapgen/testdisplay.c
    ${CMAKE_SOURCE_DIR}/main/src/mapgen/utility.c
)

# Output directory and file
set(BUILD_DIR ${CMAKE_SOURCE_DIR}/build)
file(MAKE_DIRECTORY ${BUILD_DIR})
set(PROJECT_NAME_OUT "Hacked C64")
set(OUTPUT_PRG "${BUILD_DIR}/${PROJECT_NAME_OUT}.prg")

# Include directories (as in build.bat)
set(OSCAR64_INCLUDES
    -i=${OSCAR64_INCLUDE}
    -i=${OSCAR64_INCLUDE_C64}
    -i=${OSCAR64_INCLUDE_C128}
    -i=${OSCAR64_INCLUDE_AUDIO}
    -i=${OSCAR64_INCLUDE_GFX}
    -i=${CMAKE_SOURCE_DIR}
    -i=${CMAKE_SOURCE_DIR}/src
    -i=${CMAKE_SOURCE_DIR}/main/src/mapgen
    -i=${BUILD_DIR}
)

# Add custom command to build with Oscar64
add_custom_command(
    OUTPUT ${OUTPUT_PRG}
    COMMAND ${OSCAR64_BIN} -o="${OUTPUT_PRG}" -n -g -tf=prg -O0 -tm=c64 -dDEBUG -d__oscar64__ ${OSCAR64_INCLUDES} ${SRC_FILES}
    DEPENDS ${SRC_FILES}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMENT "Building with Oscar64 cross-assembler"
)

add_custom_target(oscar64_build ALL DEPENDS ${OUTPUT_PRG})

# Clean target for build directory
add_custom_target(oscar64_clean
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${BUILD_DIR}
    COMMENT "Cleaning build directory"
)
