mkdir build
if %ERRORLEVEL% neq 0 exit 1
cd build

cmake %CMAKE_ARGS% ^
  -GNinja ^
  -DSPIRV-Headers_SOURCE_DIR:PATH=%LIBRARY_PREFIX% ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
  -DSPIRV_TOOLS_LIBRARY_TYPE=SHARED ^
  -DSPIRV_TOOLS_BUILD_STATIC=OFF ^
  -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON ^
  ..
if %ERRORLEVEL% neq 0 exit 1

ninja -j%CPU_COUNT%
if %ERRORLEVEL% neq 0 exit 1
ninja install
if %ERRORLEVEL% neq 0 exit 1

:: Install the private (internal) headers for consumers such as Tint (Dawn's
:: shader compiler) that use the spvtools::opt C++ API directly. Headers include
:: each other as "source/..." and include generated headers by bare name, so
:: both live under a single include root. The internal API is not stable.
set "PRIVATE_INCLUDE_DIR=%LIBRARY_INC%\spirv-tools-private"
robocopy "%SRC_DIR%\source" "%PRIVATE_INCLUDE_DIR%\source" *.h /S /NFL /NDL /NJH /NJS
if %ERRORLEVEL% geq 8 exit 1
for %%f in (DebugInfo.h OpenCLDebugInfo100.h core_tables_header.inc) do (
  copy /Y %%f "%PRIVATE_INCLUDE_DIR%\" || exit 1
)
exit 0
