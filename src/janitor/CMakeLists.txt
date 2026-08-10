add_library(sequoia_janitor STATIC
    Janitor.cc
)

target_include_directories(sequoia_janitor PRIVATE
    ${CMAKE_SOURCE_DIR}/src
)

target_link_libraries(sequoia_janitor PRIVATE
    sequoia_protos
    spdlog::spdlog
)
