#pragma once

//! Umbrella header file, make sure it is the same name as the project name as our CMake script will create
//! a module.modulemap file that includes this head as the umbrella header

// include header files that we will use
#include <class/test_class.h>
#include <type/test_type.h>

#include <vector>
#include <array>
#include <string>
#include <memory>

void printString(const std::string& str);
void incrementValue(int& val);

std::vector<int> getRandomIntVec();
std::array<int, 10> getIntArray();

void incrementReference(TestClass& classImpl);
void incrementCopy(TestClass classImpl);

std::shared_ptr<TestClass> getClassPtr();
void callClassPtr(const std::shared_ptr<TestClass>& classPtr);

namespace random_namespace
{
    void callFromNamespace();

    namespace nested_namespace
    {
        void callFromNestedNamespace();
    }
}