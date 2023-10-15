set -ex
mkdir build
cd build

cmake ${CMAKE_ARGS} \
  -DCMAKE_BUILD_TYPE=Release \
  -DSPIRV_TOOLS_LIBRARY_TYPE=SHARED \
  -DSPIRV_TOOLS_BUILD_STATIC=OFF \
  -DSPIRV_HEADER_INCLUDE_DIR="${PREFIX}/include" \
  ..

make -j${CPU_COUNT}
make install
