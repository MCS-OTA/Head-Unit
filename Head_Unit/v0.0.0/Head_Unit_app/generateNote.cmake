# 수정된 generateNote.cmake - 디버깅 및 안전성 강화

# 변수 수신 확인 및 디버깅
message(STATUS "=== generateNote.cmake 실행 시작 ===")
message(STATUS "Received OUTPUT_FILE: '${OUTPUT_FILE}'")
message(STATUS "Received VERSION: '${VERSION}'")
message(STATUS "Received TIMESTAMP: '${TIMESTAMP}'")
message(STATUS "Received DESC_LENGTH: '${DESC_LENGTH}'")

# 변수 유효성 검사
if(NOT OUTPUT_FILE)
    message(FATAL_ERROR "OUTPUT_FILE이 설정되지 않았습니다")
endif()

if(NOT VERSION)
    message(FATAL_ERROR "VERSION이 설정되지 않았습니다")
endif()

if(NOT TIMESTAMP)
    message(FATAL_ERROR "TIMESTAMP가 설정되지 않았습니다")
endif()

if(NOT DESC_LENGTH)
    message(FATAL_ERROR "DESC_LENGTH가 설정되지 않았습니다")
endif()

# 실제 문자열 재구성 및 길이 검증
set(RECONSTRUCTED_STRING "version=${VERSION};timestamp=${TIMESTAMP}")
string(LENGTH "${RECONSTRUCTED_STRING}" ACTUAL_LENGTH)
math(EXPR ACTUAL_LENGTH_WITH_NULL "${ACTUAL_LENGTH} + 1")

message(STATUS "Reconstructed string: '${RECONSTRUCTED_STRING}'")
message(STATUS "Actual string length: ${ACTUAL_LENGTH}")
message(STATUS "With null terminator: ${ACTUAL_LENGTH_WITH_NULL}")
message(STATUS "Provided DESC_LENGTH: ${DESC_LENGTH}")

# 길이 불일치 경고
if(NOT DESC_LENGTH EQUAL ACTUAL_LENGTH_WITH_NULL)
    message(WARNING "DESC_LENGTH(${DESC_LENGTH})와 실제 길이(${ACTUAL_LENGTH_WITH_NULL})가 일치하지 않습니다!")
    message(STATUS "실제 계산된 길이로 교체합니다: ${ACTUAL_LENGTH_WITH_NULL}")
    set(DESC_LENGTH ${ACTUAL_LENGTH_WITH_NULL})
endif()

# ELF note 섹션 생성
message(STATUS "ELF note 섹션 파일 생성: ${OUTPUT_FILE}")
file(WRITE ${OUTPUT_FILE} "
.section .note.versioninfo, \"a\", @note

.align 4

.long 4

.long ${DESC_LENGTH}

.long 1

.ascii \"VERS\"

.align 4

.asciz \"version=${VERSION};timestamp=${TIMESTAMP}\"

.align 4

")

message(STATUS "=== generateNote.cmake 실행 완료 ===")
