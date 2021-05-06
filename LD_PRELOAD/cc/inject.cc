#include <iostream>
#include <string>
void operator delete  ( void* ptr ) noexcept {
  std::cout << "memory has been freed ;)" << std::endl;
}
