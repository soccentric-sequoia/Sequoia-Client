add_library(sequoia_hal_service STATIC HalServiceImpl.cc
) target_include_directories(sequoia_hal_service PRIVATE ${CMAKE_SOURCE_DIR}/src ${CMAKE_SOURCE_DIR}/../Sequoia-HAL/src
) target_link_libraries(sequoia_hal_service PRIVATE sequoia_registry sequoia_hal_bridge sequoia_protos ${SEQUOIA_GRPC_LIBRARIES} protobuf::libprotobuf spdlog::spdlog
)
