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
        let indata: [Double] = [4,0,0,0]
        lblIndata.text = ("\(indata)")
      
        let myFTBox = Fourier()
        
        let utdata = myFTBox.Transform(data: indata)
        var utDataText = ""
        
        for index in 0..<utdata.count {
            utDataText += "\(utdata[index].amplitude):\(utdata[index].phase)"
            print("\(utdata[index].amplitude):\(utdata[index].phase)")
        }
        
        lblUtdata.text = ("\(utDataText)")
        
        
    }
    
    @IBOutlet weak var lblIndata: UILabel!
    
    @IBOutlet weak var lblUtdata: UILabel!
}

