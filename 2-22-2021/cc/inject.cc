#include <iostream>
#include <string>
void operator delete  ( void* ptr ) noexcept {
  int i = 5;
  ptr = &i;
  std::cout << "asdfasewraw" << std::endl;
}