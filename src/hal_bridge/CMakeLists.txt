add_library(sequoia_hal_bridge STATIC
    ResultSerializer.cc
)

target_include_directories(sequoia_hal_bridge PRIVATE
    ${CMAKE_SOURCE_DIR}/src
    ${CMAKE_SOURCE_DIR}/../Sequoia-HAL/src
)

target_link_libraries(sequoia_hal_bridge PRIVATE
    sequoia_protos
    spdlog::spdlog
)
