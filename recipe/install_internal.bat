cmake -DSRC_DIR="%SRC_DIR%" -DBUILD_DIR="%SRC_DIR%\build" ^
  -DDEST="%LIBRARY_INC%\spirv-tools-private" ^
  -P "%RECIPE_DIR%\install_internal_headers.cmake"
if %ERRORLEVEL% neq 0 exit 1
