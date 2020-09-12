//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Javier Garcia on 9/10/20.
//  Copyright © 2020 codepath. All rights reserved.
//

import UIKit

//import QuartzCore

class ViewController: UIViewController {


    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var customField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var segOneLabel: UILabel!
    @IBOutlet weak var segTwoLabel: UILabel!
    @IBOutlet weak var segThreeLabel: UILabel!
    
    
    
    @IBOutlet weak var outletSwitch: UISwitch!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var payButton: UIButton!
    
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var splitField: UITextField!
    
    @IBOutlet weak var splitStepper: UIStepper!
    
    @IBAction func splitAction(_ sender: Any) {
        splitField.text = String(format: "%.0f", splitStepper.value)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        segOneLabel.layer.masksToBounds = true
        segTwoLabel.layer.masksToBounds = true
        segThreeLabel.layer.masksToBounds = true
        testLabel.layer.masksToBounds = true
        
        payButton.layer.cornerRadius = 10.0
        segOneLabel.layer.cornerRadius = 10.0
        segTwoLabel.layer.cornerRadius = 10.0
        segThreeLabel.layer.cornerRadius = 10.0
        testLabel.layer.cornerRadius = 10.0
        
    }
    


    
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
        print ("line 36")
    }
    
    

    @IBAction func darkAction(_ sender: Any) {
        switch traitCollection.userInterfaceStyle {
        case .light:
            if outletSwitch.isOn == true {
                overrideUserInterfaceStyle = .dark
                print ("overide to dark")
            }
        case .dark:
            if outletSwitch.isOn == false {
                overrideUserInterfaceStyle = .light
                print ("overide to light")
            }
        case .unspecified:
            print ("unspecififed")
        }
        
        
        
        
        
        
        /*
 else {
            overrideUserInterfaceStyle = .light
        }*/
    }
    

    
    
    @IBAction func calculateTip(_ sender: Any) {
        let bill = Double(billField.text!) ?? 0
        let billPercentages = [0.1, 0.15, 0.2, (Double(customField.text!) ?? 0)]
        var tip = 0.0
        
        
        if (billPercentages[tipControl.selectedSegmentIndex]) == billPercentages[3]{
            print ("test")
            tip = billPercentages[3]
            let test = tip
            testLabel.text = String(format: "$%.2f", test)
            
        } else {
            tip = bill * billPercentages[tipControl.selectedSegmentIndex]
        }
        
        let segOne = bill * billPercentages[0]
        let segTwo = bill * billPercentages[1]
        let segThree = bill * billPercentages[2]
        

        let total = bill + tip
        
        segOneLabel.text = String(format: "$%.2f", segOne)
        segTwoLabel.text = String(format: "$%.2f", segTwo)
        segThreeLabel.text = String(format: "$%.2f", segThree)
        
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    

    
}
