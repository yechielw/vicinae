# cmake/ExtensionManager.cmake
include(ExtensionApi)

set(EXT_MGR_SRC_DIR "${CMAKE_SOURCE_DIR}/extension-manager")
set(EXT_MGR_OUT "${CMAKE_SOURCE_DIR}/vicinae/assets/extension-runtime.js")

file(GLOB_RECURSE EXT_MGR_TS_FILES
    "${EXT_MGR_SRC_DIR}/src/*.ts"
)

list(APPEND EXT_MGR_TS_FILES
    "${EXT_MGR_SRC_DIR}/tsconfig.json"
    "${EXT_MGR_SRC_DIR}/package.json"
)

add_custom_command(
    OUTPUT ${EXT_MGR_OUT}
    COMMAND npm install
    COMMAND npm run build
    COMMAND ${CMAKE_COMMAND} -E copy
            ${EXT_MGR_SRC_DIR}/dist/runtime.js
            ${EXT_MGR_OUT}
    WORKING_DIRECTORY ${EXT_MGR_SRC_DIR}
	DEPENDS ${EXT_MGR_TS_FILES} ${API_OUT}
    COMMENT "Building extension manager JavaScript bundle"
)

add_custom_target(extension-manager ALL
    DEPENDS api ${EXT_MGR_OUT}
)

