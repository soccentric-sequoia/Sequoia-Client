# ---------------------------------------------------------------------------
# tests/CMakeLists.txt
# ---------------------------------------------------------------------------

# GTest
find_package(GTest REQUIRED)

# ---------------------------------------------------------------------------
# test_result_serializer — unit tests for hal_bridge serialization
# ---------------------------------------------------------------------------

add_executable(test_result_serializer
    test_result_serializer.cc
)

target_include_directories(test_result_serializer PRIVATE
    ${CMAKE_SOURCE_DIR}/src
    ${CMAKE_SOURCE_DIR}/../Sequoia-HAL/src
)

target_link_libraries(test_result_serializer PRIVATE
    sequoia_hal_bridge
    sequoia_protos
    spdlog::spdlog
    GTest::gtest_main
)

add_test(NAME serializer_tests COMMAND test_result_serializer)

# ---------------------------------------------------------------------------
# test_run_orchestrator — integration tests for RunOrchestrator
# ---------------------------------------------------------------------------

add_executable(test_run_orchestrator
    test_run_orchestrator.cc
)

target_include_directories(test_run_orchestrator PRIVATE
    ${CMAKE_SOURCE_DIR}/src
    ${CMAKE_SOURCE_DIR}/../Sequoia-HAL/src
)

target_link_libraries(test_run_orchestrator PRIVATE
    sequoia_hal_bridge
    sequoia_registry
    sequoia_spool
    sequoia_stream
    sequoia_run
    sequoia_protos
    spdlog::spdlog
    SQLite::SQLite3
    yaml-cpp::yaml-cpp
    ${SEQUOIA_GRPC_LIBRARIES}
    protobuf::libprotobuf
    GTest::gtest_main
)

add_test(NAME runner_tests COMMAND test_run_orchestrator)
