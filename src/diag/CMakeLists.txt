add_library(sequoia_diag STATIC
    DiagSocket.cc
)

target_include_directories(sequoia_diag PRIVATE
    ${CMAKE_SOURCE_DIR}/src
)

target_link_libraries(sequoia_diag PRIVATE
    spdlog::spdlog
)
