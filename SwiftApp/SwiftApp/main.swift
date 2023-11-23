//
//  main.swift
//  SwiftApp
//
//  Created by Allan Ma on 23/11/23.
//

import Foundation
import CppLib

class EntryPoint {
    
    private var testColor = Color()
    private var testClass = TestClass()
    
    func main() {
        print("Swift CLI Test App")
        
        // call basic functions
        printString("Printing string from Cpp function")
        
        var someInt: Int32 = 0;
        print(someInt)
        
        incrementValue(&someInt);
        
        print(someInt)
        
        print(getRandomIntVec())
        print(getIntArray())
        
        testClass.printCounter()
        incrementReference(&testClass)
        testClass.printCounter()
        incrementCopy(testClass)
        testClass.printCounter()
        
        random_namespace.callFromNamespace()
        random_namespace.nested_namespace.callFromNestedNamespace()
        
        let classPtr = getClassPtr()
        callClassPtr(classPtr)
    }
}

EntryPoint().main()

