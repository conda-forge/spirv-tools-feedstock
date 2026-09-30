set -ex
mkdir build
cd build

if [[ "${target_platform}" == osx-64 ]]; then
  CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

cmake ${CMAKE_ARGS} \
  -DCMAKE_BUILD_TYPE=Release \
  -DSPIRV_TOOLS_LIBRARY_TYPE=SHARED \
  -DSPIRV_TOOLS_BUILD_STATIC=OFF \
  -DSPIRV-Headers_SOURCE_DIR="${PREFIX}" \
  ..

make -j${CPU_COUNT}
make install

# Install the private (internal) headers for consumers such as Tint (Dawn's
# shader compiler) that use the spvtools::opt C++ API directly. Headers include
# each other as "source/..." and include generated headers by bare name, so
# both live under a single include root. The internal API is not stable.
PRIVATE_INCLUDE_DIR="${PREFIX}/include/spirv-tools-private"
(cd "${SRC_DIR}" && find source -name '*.h' -exec install -Dm644 {} "${PRIVATE_INCLUDE_DIR}/{}" \;)
install -m644 DebugInfo.h OpenCLDebugInfo100.h core_tables_header.inc "${PRIVATE_INCLUDE_DIR}/"
