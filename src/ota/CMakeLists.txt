add_library(sequoia_ota STATIC
    OtaClient.cc
)

target_include_directories(sequoia_ota PRIVATE
    ${CMAKE_SOURCE_DIR}/src
)

target_link_libraries(sequoia_ota PRIVATE
    sequoia_protos
    ${SEQUOIA_GRPC_LIBRARIES}
    spdlog::spdlog
)
