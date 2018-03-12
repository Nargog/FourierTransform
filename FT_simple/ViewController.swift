//
//  ViewController.swift
//  FT_simple
//
//  Created by Mats Hammarqvist on 2018-03-03.
//  Copyright © 2018 Mats Hammarqvist. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func btnStart(_ sender: Any) {
        let myFTBox = Fourier()
        
        let timeSignal:[Double] = [0, 1, 1, 1,2,3,4,5,6,0]
        
        for test in timeSignal {
            var addValue = timePoint()
            addValue.realValue = test
            myFTBox.timeSignal.append(addValue)
        }
        
        print(myFTBox.timeSignal)
        
        
        lblIndata.text = ("\(myFTBox.timeSignal)")
      
        
        var utdata = myFTBox.transform
        var utDataText = ""
        
        for index in 0..<utdata.count {
            utDataText += "\(String(format: "%.1f", utdata[index].amplitude)):\(String(format: "%.0f", utdata[index].phase)) / "
            print("\(String(format: "%.2f", utdata[index].amplitude))  :  \(String(format: "%.0f", utdata[index].phase)) / ")
            
        }
        
        lblUtdata.text = ("\(utDataText)")
        
        myFTBox.invTransform()
        
    }
    
    @IBOutlet weak var lblIndata: UILabel!
    
    @IBOutlet weak var lblUtdata: UILabel!
}

