cmake_minimum_required(VERSION 3.20)

project(abledecoder)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)

find_package(OpenSSL REQUIRED)

add_executable(abledecoder
  FileChunk.cpp
  CommonChunk.cpp
  AbleChunk.cpp
  FormChunk.cpp
  SoundDataChunk.cpp
  FormatVersionChunk.cpp
  main.cpp)

target_link_libraries(abledecoder PRIVATE
  OpenSSL::SSL
  OpenSSL::Crypto)
