add_library(sequoia_run STATIC RunOrchestrator.cc
) target_include_directories(sequoia_run PRIVATE ${CMAKE_SOURCE_DIR}/src ${CMAKE_SOURCE_DIR}/../Sequoia-HAL/src
) target_link_libraries(sequoia_run PRIVATE sequoia_hal_bridge sequoia_protos spdlog::spdlog
)
