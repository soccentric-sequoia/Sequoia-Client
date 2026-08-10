# ---------------------------------------------------------------------------
# src/CMakeLists.txt
# Adds each module as a static library then defines the main executable.
# Subdirectories are ordered leaf-first so inter-target references resolve.
# ---------------------------------------------------------------------------

add_subdirectory(config)
add_subdirectory(diag)
add_subdirectory(spool)
add_subdirectory(stream)
add_subdirectory(hal_bridge)
add_subdirectory(registry)
add_subdirectory(ota)
add_subdirectory(log)
add_subdirectory(janitor)
add_subdirectory(run)
add_subdirectory(hal_service)

# ---------------------------------------------------------------------------
# Main executable
# ---------------------------------------------------------------------------

add_executable(sequoia-client
    main.cpp
    app.cpp
)

target_include_directories(sequoia-client PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/../Sequoia-HAL/src
)

target_link_libraries(sequoia-client PRIVATE
    sequoia_config
    sequoia_diag
    sequoia_hal_bridge
    sequoia_hal_service
    sequoia_janitor
    sequoia_log
    sequoia_ota
    sequoia_registry
    sequoia_run
    sequoia_spool
    sequoia_stream
    sequoia_protos
    spdlog::spdlog
    tomlplusplus::tomlplusplus
    yaml-cpp::yaml-cpp
    SQLite::SQLite3
    ${SEQUOIA_GRPC_LIBRARIES}
    protobuf::libprotobuf
)

target_compile_definitions(sequoia-client PRIVATE
    SEQUOIA_CLIENT_VERSION="${PROJECT_VERSION}"
)

set_compiler_warnings(sequoia-client)
