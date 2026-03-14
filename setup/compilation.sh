co() { g++ -std=c++20 -O2 -Wall -Wextra -Wshadow -Wconversion -o $1 $1.cpp; }

run() { co $1 && ./$1; }