add_library(sequoia_stream STATIC StreamClient.cc
) target_include_directories(sequoia_stream PRIVATE ${CMAKE_SOURCE_DIR}/src
) target_link_libraries(sequoia_stream PRIVATE sequoia_protos ${SEQUOIA_GRPC_LIBRARIES} spdlog::spdlog
)
