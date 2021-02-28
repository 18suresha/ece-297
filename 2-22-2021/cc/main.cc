#include <iostream>
#include <string>

class A {
  public:
    int i;
};

int main(int argc, char** argv) {
  A* a = new A();
  a->i = 3;
  std::cout << a->i << std::endl;
  delete a;
  std::cout << a->i << std::endl;
  return 0;
}