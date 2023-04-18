mkdir build
cd build

cmake ${CMAKE_ARGS} \
  -DCMAKE_BUILD_TYPE=Release \
  -DSPIRV_TOOLS_BUILD_STATIC=OFF \
  ..

make -j${CPU_COUNT}
make install
