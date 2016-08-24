#include <hello_world.hpp>

#include <iostream>
#include <cassert>

using namespace hello_world;

int main() {
  std::string value = exclaim("hello");
  std::clog << value;
  return 0;
}