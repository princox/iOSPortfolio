//
//  ViewController.swift
//  PhotoKit
//
//  Created by JeongHoonRhee on 2017. 7. 27..
//  Copyright © 2017년 H-Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var image: UIImage = UIImage()
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.image = image
    }

    

}

