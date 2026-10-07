file(GLOB_RECURSE headers RELATIVE "${SRC_DIR}" "${SRC_DIR}/source/*.h")
foreach(header IN LISTS headers)
  get_filename_component(header_dir "${header}" DIRECTORY)
  file(COPY "${SRC_DIR}/${header}" DESTINATION "${DEST}/${header_dir}")
endforeach()
file(COPY
  "${BUILD_DIR}/DebugInfo.h"
  "${BUILD_DIR}/OpenCLDebugInfo100.h"
  "${BUILD_DIR}/core_tables_header.inc"
  DESTINATION "${DEST}")
