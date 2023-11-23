#pragma once
#include <iostream>

class TestClass {
public:
    TestClass() {
        std::cout << "Construct TestClass" << std::endl;
    }

    ~TestClass() {
        std::cout << "Destroy TestClass" << std::endl;
    }

    void incrementCounter(int count) {
        _counter += count;
    }

    void printCounter() {
        std::cout << "Counter: " << _counter << std::endl;
    }

public:
    int _counter = 0;

};