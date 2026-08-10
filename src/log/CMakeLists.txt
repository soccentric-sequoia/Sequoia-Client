add_library(sequoia_log STATIC LogCollector.cc
) target_include_directories(sequoia_log PRIVATE ${CMAKE_SOURCE_DIR}/src
) target_link_libraries(sequoia_log PRIVATE sequoia_protos spdlog::spdlog
)
