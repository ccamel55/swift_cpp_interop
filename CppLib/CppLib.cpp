#include <CppLib.h>

void printString(const std::string& str)
{
    std::cout << str << std::endl;
}

void incrementValue(int& val)
{
    val += 1;
}

std::vector<int> getRandomIntVec()
{
    const auto randNum = (rand() % 10) + 1;

    std::vector<int> vec = {};
    vec.resize(randNum);

    for (int i = 0; i < randNum; i++) {
        vec.push_back(i);
    }

    return vec;
}

std::array<int, 10> getIntArray()
{
    std::array<int, 10> arr = {};

    for (uint8_t i = 0; i < 10; i++) {
        arr.at(i) = i + 1;
    }

    return arr;
}

void incrementReference(TestClass& classImpl)
{
    classImpl.incrementCounter(10);
}

void incrementCopy(TestClass classImpl)
{
    classImpl.incrementCounter(10);
}

std::shared_ptr<TestClass> getClassPtr()
{
    return std::make_shared<TestClass>();
}

void callClassPtr(const std::shared_ptr<TestClass>& classPtr)
{
    classPtr->printCounter();
}

void random_namespace::callFromNamespace()
{
    std::cout << "Function In Namespace" << std::endl;
}

void random_namespace::nested_namespace::callFromNestedNamespace()
{
    std::cout << "Function In Nested Namespace" << std::endl;
}