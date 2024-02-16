cmake_minimum_required(VERSION 3.8)
project(restaurant)

# Default to C++14
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
endif()

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

include_directories(include)
file(GLOB SRC_FILES
include/*.h
src/*.cpp
)

add_executable(restaurant ${SRC_FILES})
target_link_libraries(restaurant mysqlcppconn)

install(TARGETS
  restaurant
  DESTINATION lib/${PROJECT_NAME})



