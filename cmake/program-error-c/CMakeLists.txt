cmake_minimum_required(VERSION 2.8)

project(dummy)

add_executable(dummy-binary main.c)

install(TARGETS dummy-binary RUNTIME DESTINATION "bin")
