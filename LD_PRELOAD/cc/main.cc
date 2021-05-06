#include <iostream>
#include <string>

int main() {
  std::string* a = new std::string("ECE 297");
  std::cout << *a << std::endl;
  delete a;
  std::cout << *a << std::endl;
  return 0;
}
