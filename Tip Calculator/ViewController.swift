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
    
    
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var payButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        segOneLabel.layer.masksToBounds = true
        segTwoLabel.layer.masksToBounds = true
        segThreeLabel.layer.masksToBounds = true
        
        payButton.layer.cornerRadius = 10.0
        segOneLabel.layer.cornerRadius = 5.0
        segTwoLabel.layer.cornerRadius = 5.0
        segThreeLabel.layer.cornerRadius = 5.0
        print ("line 30")
    }
    

    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
        print ("line 36")
    }
    


    
    
    @IBAction func calculateTip(_ sender: Any) {
        let bill = Double(billField.text!) ?? 0
        let billPercentages = [0.1, 0.15, 0.2, (Double(customField.text!) ?? 0)]
        var tip = 0.0
        
        if (billPercentages[tipControl.selectedSegmentIndex]) == billPercentages[3]{
            
            print ("test")
            tip = billPercentages[3]
            
        } else {
            tip = bill * billPercentages[tipControl.selectedSegmentIndex]
        }
        
        let segOne = bill * billPercentages[0]
        let segTwo = bill * billPercentages[1]
        let segThree = bill * billPercentages[2]
        
        
        /*if (customField.text! != "0") || (customField.text! != " "){
            print ("58")
            print ("customFieldText", customField.text!)
            let tip = bill + amount
        }*/

        let total = bill + tip
        
        segOneLabel.text = String(format: "$%.2f", segOne)
        segTwoLabel.text = String(format: "$%.2f", segTwo)
        segThreeLabel.text = String(format: "$%.2f", segThree)
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    

    
}
