//
//  UnitTestTests.swift
//  UnitTestTests
//
//  Created by JeongHoonRhee on 2017. 7. 15..
//  Copyright © 2017년 H-Lab. All rights reserved.
//

import XCTest
@testable import UnitTest

class UnitTestTests: XCTestCase {
    
    let a:Int = 21
    let b:Int = 6
    var c:Int = 0;
    
    var calTest = Calculator(preNum: 0, NextNum: 0);
    
    
    override func setUp() {
        super.setUp()
        // given
        // 위에서 변수들을 옵셔널로 해놓고 nil로 세팅한 후에 여기서 Calculator를 할당하는 방식으로 진행한다.
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // 끝나고나서 종료하는 코드
        // 끝나고 나면 다 nil로 바꾸어서 메모리 할당을 해제한다.
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let result = 2 + 2
        XCTAssert(result == 4, "something gone wrong here")
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testAdd() {
        c = calTest.add(PreNum: a, NextNum: b)
        XCTAssert(c == (a + b), "add failed")
    }
    
    func testSubtract(){
        let subtest = Calculator(preNum: 0, NextNum: 0)
        c = subtest.subtract(PreNum: a, NextNum: b)
        XCTAssert(c == (a-b), "subtract failed")
        
    }
    
    func testMulti(){
        c = calTest.multiply(PreNum: a, NextNum: b)
        XCTAssert(c == (a*b), "mulitply failed")
    }
    
    func testDivide(){
        c = calTest.divide(a, b)
        XCTAssert(c == (a/b), "divide failed")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
