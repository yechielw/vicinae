# cmake/ExtensionApi.cmake

set(EXT_API_SRC_DIR "${CMAKE_SOURCE_DIR}/api")
set(EXT_API_OUT_DIR "${CMAKE_SOURCE_DIR}/api/dist")
set(API_DIST_DIR "${CMAKE_SOURCE_DIR}/api/dist")

file(GLOB_RECURSE API_OUT
    "${API_DIST_DIR}/**/*.js"
    "${API_DIST_DIR}/*.d.ts"
)

file(GLOB_RECURSE EXT_API_TS_FILES
    "${EXT_API_SRC_DIR}/src/*.ts"
)

list(APPEND EXT_API_TS_FILES
    "${EXT_API_SRC_DIR}/tsconfig.json"
    "${EXT_API_SRC_DIR}/package.json"
)

add_custom_command(
	OUTPUT ${API_OUT}
    COMMAND npm install
    COMMAND npm run build
    WORKING_DIRECTORY ${EXT_API_SRC_DIR}
	DEPENDS ${EXT_API_TS_FILES}
	COMMENT "Building extension API package"
)

add_custom_target(api DEPENDS ${API_OUT})
