set -ex

cmake -DSRC_DIR="${SRC_DIR}" -DBUILD_DIR="${SRC_DIR}/build" \
  -DDEST="${PREFIX}/include/spirv-tools-private" \
  -P "${RECIPE_DIR}/install_internal_headers.cmake"
