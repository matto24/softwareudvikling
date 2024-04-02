cmake_minimum_required(VERSION 3.8)
project(pa2)

# Default to C++14
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
endif()

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

list(APPEND CMAKE_PREFIX_PATH "/home/mads/wxWidgets-3.2.2.1")	 
find_package(wxWidgets REQUIRED COMPONENTS net core base)
include(${wxWidgets_USE_FILE})

include_directories(include ${wxWidgets_INCLUDE_DIRS})
file(GLOB SRC_FILES
include/*.h
src/*.cpp
)

add_executable(pa2 ${SRC_FILES})
target_link_libraries(pa2 mysqlcppconn)
target_link_libraries(pa2 ${wxWidgets_LIBRARIES})

install(TARGETS
  pa2
  DESTINATION lib/${PROJECT_NAME})



