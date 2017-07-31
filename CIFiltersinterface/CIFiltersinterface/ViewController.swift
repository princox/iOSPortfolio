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
    var listOfFilterNames = ["CIBoxBlur", "CIZoomBlur", "CIColorMatrix", "CIHueAdjust", "CIToneCurve"]
    var chosenFilter = CIFilter()
    var chosenFilterName = ""
    // 비어있기 때문에 강제 언랩핑하면 문제가 생길 수 있음.
    
    
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
        
        //        listOfFilterNames = ["first", "second", "third"]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func applyFilterAction(_ sender: UIButton) {
        
        
        /*      옛날코드 지우고 싶으면 지울 것
         chosenFilter = CIFilter(name: "CISepiaTone")! // (CISepiaTone은 CIfilter가 가지고 있음) 필터를 만들고
         chosenFilter.setValue(displayImage, forKey: "inputImage")
         
         let params : [String:Any] = [kCIInputImageKey: displayImage, kCIInputIntensityKey: 0.5]
         
         chosenFilter = CIFilter(name: "CISepiaTone", withInputParameters: params)!
         
         if let outputImage = chosenFilter.outputImage {
         imgView.image = UIImage(ciImage: outputImage)
         }
         
         chosenFilter = CIFilter(name: "CISepiaTone")!
         chosenFilter.setValue(displayImage, forKey: "inputImage")
         
         
         
         if let outputImage = chosenFilter.outputImage {
         imgView.image = UIImage(ciImage: outputImage)
         }
         */
        guard let filter = CIFilter(name: chosenFilterName) else {
            return
        }
        
        chosenFilter = filter
        
        var input1: CGFloat = 0.0
        var input2: CGFloat = 0.0
        var input3: CGFloat = 0.0
        var input4: CGFloat = 0.0
        
        if let input = Double(textField1.text!) {
            input1 = CGFloat(input)
        }
        if let input = Double(textField2.text!) {
            input2 = CGFloat(input)
        }
        if let input = Double(textField3.text!) {
            input3 = CGFloat(input)
        }
        if let input = Double(textField4.text!) {
            input4 = CGFloat(input)
        }
        processFilter(input1: input1, input2: input2, input3: input3, input4: input4)
        
        if let outputImage = chosenFilter.outputImage {
            let result = outputImage.cropping(to: displayImage.extent)
            imgView.image = UIImage(ciImage: outputImage)
        }
    }
    
    func processFilter(input1: CGFloat, input2: CGFloat, input3: CGFloat, input4: CGFloat) {
        chosenFilter.setValue(displayImage, forKey: "inputImage")
        switch chosenFilterName {
        case "CIBoxBlur":
            chosenFilter.setValue(input1, forKey: "inputRadius")
        case "CIZoomBlur":
            let centerVector = CIVector(x: self.displayImage.extent.midX, y: self.displayImage.extent.midY)
            chosenFilter.setValue(centerVector, forKey: "inputCenter")
            chosenFilter.setValue(input1, forKey: "inputAmount")
        case "CIColorMatrix":
            let rVector = CIVector(x: input1, y: 0, z: 0, w: 0)
            let gVector = CIVector(x: 0, y: input2, z: 0, w: 0)
            let bVector = CIVector(x: 0, y: 0, z: input3, w: 0)
            let aVector = CIVector(x: 0, y: 0, z: 0, w: input4)
            chosenFilter.setValue(rVector, forKey: "inputRVector")
            chosenFilter.setValue(gVector, forKey: "inputGVector")
            chosenFilter.setValue(bVector, forKey: "inputBVector")
            chosenFilter.setValue(aVector, forKey: "inputAVector")
        case "CIHueAdjust":
            chosenFilter.setValue(input1, forKey: "inputAngle")
        case "CIToneCurve":
            let point0 = CIVector(x: input1, y:input1)
            let point1 = CIVector(x: input2, y:input2)
            let point2 = CIVector(x: input3, y:input3)
            let point3 = CIVector(x: input4, y:input4)
            chosenFilter.setValue(point0, forKey: "inputPoint0")
            chosenFilter.setValue(point1, forKey: "inputPoint1")
            chosenFilter.setValue(point2, forKey: "inputPoint2")
            chosenFilter.setValue(point3, forKey: "inputPoint3")
        default:
            break
        }
    }
    
    
    
    // 아래 4개의 메소드를 써서 에러를 없애자.
    
    //    func displayFilterNames() {
    //        let filterNameArray = CIFilter.filterNames(inCategories: ["CICategoryBlur"])
    //        print(filterNameArray)
    //        let blurFilter = CIFilter(name: "CIBoxBlur")
    //    }
    
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






























