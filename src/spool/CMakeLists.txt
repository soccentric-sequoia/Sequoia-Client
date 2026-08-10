add_library(sequoia_spool STATIC
    Spool.cc
)

target_include_directories(sequoia_spool PRIVATE
    ${CMAKE_SOURCE_DIR}/src
)

target_link_libraries(sequoia_spool PRIVATE
    sequoia_protos
    SQLite::SQLite3
    spdlog::spdlog
)
