//
//  ViewController.swift
//  UnitTest
//
//  Created by JeongHoonRhee on 2017. 7. 15..
//  Copyright © 2017년 H-Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var resultField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

class Calculator {
    var preNum: Int
    var NextNum: Int
    
    init(preNum:Int, NextNum:Int) {
        self.preNum = preNum
        self.NextNum = NextNum
    }
    
    func add(PreNum:Int, NextNum:Int) -> Int {
        return PreNum + NextNum
    }
    
    func subtract(PreNum:Int, NextNum:Int)  -> Int{
        return PreNum - NextNum
    }
    
    func multiply(PreNum:Int, NextNum: Int) -> Int {
        return PreNum * NextNum
    }
    
    func divide(_ a: Int, _ b:Int) -> Int{
        return (a/b)
    }
}

