//
//  ViewController.swift
//  CIFiltersinterface
//
//  Created by JeongHoonRhee on 2017. 7. 24..
//  Copyright © 2017년 H-Lab. All rights reserved.
//

import UIKit
import CoreImage

// 델리게이트 메소드를 쓰기 위해서 델리게이트를 준수한다. (UIPickerViewDelegate, UIPickerViewDataSource)
// 그 후 구현해야 하는 메소드를 구현한다.

class ViewController: UIViewController,  UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var filterPicker: UIPickerView!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    
    let myProfileImage = #imageLiteral(resourceName: "profile")
    var displayImage = CIImage()
    var listOfFilterNames = [String]()
    var chosenFilter = CIFilter()
    var chosenFilterName = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 내 사진 이미지를 imgView의 이미지에 넣음.
        
        // 이 viewcontroller class에 있는 델리게이트와 데이터소스에 여기 있는 변수들을 넣어준다.
        self.filterPicker.delegate = self
        self.filterPicker.dataSource = self
        imgView.image = myProfileImage
        
        //if let으로 해도 되지만 확실히 있다는 것을 알기 때문에 강제 언랩핑
        displayImage = CIImage(image: myProfileImage)!
        
        
        listOfFilterNames = ["first", "second", "third"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func applyFilterAction(_ sender: UIButton) {
        
    }
    
    
    // 아래 4개의 메소드를 써서 에러를 없애자.
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // 1개의 줄만 리턴
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // 전체 줄의 개수
        return listOfFilterNames.count
        /*해당 배열의 갯수를 리턴하자*/
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // 각각의 인덱스에 해당하는 줄
        // 매개변수에 해당하는 row가 선택되면 그 row에 해당하는 인덱스를 리턴한다.
        return listOfFilterNames[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 사용자가 새로운 줄(row)를 선택할 때마다 호출된다.
        chosenFilterName = listOfFilterNames[row]
        // 어떤 아이템을 선택하면 해당하는 아이템을 선택된 필터 이름으로 설정한다.
        
        print(chosenFilterName)
    }
    
    
}






























