mkdir build
cd build
cmake -GNinja ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
  -DSPIRV_TOOLS_LIBRARY_TYPE=SHARED ^
  -DSPIRV_TOOLS_BUILD_STATIC=OFF ^
  ..

ninja -j%CPU_COUNT%
ninja install
