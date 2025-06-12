# 수정된 CMakeLists.txt - DESC_LENGTH 문제 해결
cmake_minimum_required(VERSION 3.14)

project(Head_Unit_app VERSION 0.0.0 LANGUAGES CXX ASM)
string(TIMESTAMP BUILD_TIMESTAMP "%Y-%m-%d %H:%M:%S")
set(VERSION_STRING ${PROJECT_VERSION})
set(APP_NAME ${PROJECT_NAME})

# 실제 문자열 구성
set(VERSION_INFO_STRING "version=${VERSION_STRING};timestamp=${BUILD_TIMESTAMP}")

# 문자열 길이 동적 계산 (null terminator 포함)
string(LENGTH "${VERSION_INFO_STRING}" DESC_LENGTH_RAW)
math(EXPR DESC_LENGTH "${DESC_LENGTH_RAW} + 1")

# 디버깅 출력 (문제 해결 후 제거 가능)
message(STATUS "=== ELF Note Generation Debug ===")
message(STATUS "VERSION_STRING: '${VERSION_STRING}'")
message(STATUS "BUILD_TIMESTAMP: '${BUILD_TIMESTAMP}'")
message(STATUS "VERSION_INFO_STRING: '${VERSION_INFO_STRING}'")
message(STATUS "DESC_LENGTH_RAW: ${DESC_LENGTH_RAW}")
message(STATUS "DESC_LENGTH (with null): ${DESC_LENGTH}")
message(STATUS "================================")

# 캐시 변수로 설정하여 안전성 확보
set(DESC_LENGTH ${DESC_LENGTH} CACHE INTERNAL "Description length for ELF note")

set(VERSION_NOTE_FILE ${CMAKE_BINARY_DIR}/version_note.S)

# 중요: 변수 전달 순서와 따옴표 처리
add_custom_command(
    OUTPUT ${VERSION_NOTE_FILE}
    COMMAND ${CMAKE_COMMAND}
        -DOUTPUT_FILE=${VERSION_NOTE_FILE}
        -DVERSION=${VERSION_STRING}
        "-DTIMESTAMP=${BUILD_TIMESTAMP}"          # 공백 때문에 따옴표 필요
        -DDESC_LENGTH=${DESC_LENGTH}
        -P ${CMAKE_SOURCE_DIR}/generateNote.cmake
    DEPENDS ${CMAKE_SOURCE_DIR}/generateNote.cmake
    COMMENT "Generating version_note.S with desc_length=${DESC_LENGTH}"
    VERBATIM  # 명령행 인자를 안전하게 처리
)

add_custom_target(generate_version_note DEPENDS ${VERSION_NOTE_FILE})

# 어셈블리 파일 포함
add_library(version_note_obj OBJECT ${VERSION_NOTE_FILE})
add_dependencies(version_note_obj generate_version_note)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick WebEngine Network Multimedia REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick WebEngine Network Multimedia REQUIRED)
find_package(CommonAPI-SomeIP 3.2.0 REQUIRED)
find_package(vsomeip3 3.1.0 REQUIRED)

set(PRJ_SRC_GEN_PATH ../../../src-gen)
set(PRJ_SRC_GEN_COMMONAPI_PATH ${PRJ_SR_GEN_PATH}/core/v0/commonapi)
set(PRJ_SRC_GEN_COMMONAPI_SOMEIP_PATH ${PRJ_SRC_GEN_PATH}/someip/v0/commonapi)

# Application
FILE(GLOB PRJ_PROXY_GEN_SRCS ${PRJ_SRC_GEN_COMMONAPI_PATH}/*Proxy.cpp)
FILE(GLOB PRJ_STUB_GEN_SRCS ${PRJ_SRC_GEN_COMMONAPI_PATH}/*Stub*.cpp)
FILE(GLOB PRJ_STUB_IMPL_SRCS ${PRJ_SRC_COMMONAPI_PATH}/*Stub*.cpp)
 #Boost
find_package( Boost 1.66 COMPONENTS system thread log REQUIRED )
include_directories( ${Boost_INCLUDE_DIR} )

FILE(GLOB PRJ_SOMEIP_LIB_SRCS ${PRJ_SRC_GEN_COMMONAPI_SOMEIP_PATH}/*cpp)

set(PRJ_NAME IC_someip)
set(RESOURCE_FILES
    resource.qrc
)

set(PROJECT_SOURCES
        main.cpp
        qml.qrc
        current_clock.h
        weather.h
        weather.cpp
        mapController.h
        mapController.cpp
        gearController.h
        youtubeController.h
        youtubeController.cpp
        carInfoController.h
        carInfoController.cpp
        battery.cpp
        battery.h
        mp3player.cpp
        mp3player.h
        usbscanner.cpp
        usbscanner.h
        extract_cover.py
        otaUpdate.cpp
        otaUpdate.h
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(Head_Unit_app
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
        ${RESOURCE_FILES}
    )
else()
    if(ANDROID)
        add_library(Head_Unit_app SHARED
            ${PROJECT_SOURCES}
            ${RESOURCE_FILES}
        )
    else()
        add_executable(Head_Unit_app
          ${PROJECT_SOURCES}
          ${RESOURCE_FILES}
        )
    endif()
endif()

# version_note_obj를 Head_Unit_app에 링크
target_link_libraries(Head_Unit_app PRIVATE $<TARGET_OBJECTS:version_note_obj>)

# 링크 시 section을 유지하도록 설정
target_link_options(Head_Unit_app PRIVATE "-Wl,--no-gc-sections")

include_directories(
    ../../../src-gen/
    ../../../install_folder/include/CommonAPI-3.2
    ../../../install_folder/include
    ../../../install_folder/lib
    ../../../src-gen/core
    ../../../src-gen/someip
)

target_compile_definitions(Head_Unit_app
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)

link_directories(
    ../install_folder/lib)

# CommonAPI 라이브러리 찾기
find_library(COMMONAPI_LIB CommonAPI PATHS ../../../install_folder/lib)
find_library(COMMONAPI_SOMEIP_LIB CommonAPI-SomeIP PATHS ../../../install_folder/lib)
find_library(VSOMEIP_LIB vsomeip3 PATHS ../../../install_folder/lib)

target_link_libraries(Head_Unit_app
  PRIVATE Qt${QT_VERSION_MAJOR}::Core
  Qt${QT_VERSION_MAJOR}::Quick
  Qt${QT_VERSION_MAJOR}::WebEngine
  Qt${QT_VERSION_MAJOR}::Network
  Qt${QT_VERSION_MAJOR}::Multimedia
  ${COMMONAPI_LIB}
  ${COMMONAPI_SOMEIP_LIB}
  ${VSOMEIP_LIB}
  )

add_library(${PRJ_NAME}-someip SHARED ${PRJ_SOMEIP_LIB_SRCS})
target_link_libraries(${PRJ_NAME}-someip CommonAPI-SomeIP)

set_target_properties(Head_Unit_app PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

if(QT_VERSION_MAJOR EQUAL 6)
    qt_import_qml_plugins(Head_Unit_app)
    qt_finalize_executable(Head_Unit_app)
endif()
