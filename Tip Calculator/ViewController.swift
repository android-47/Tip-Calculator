//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Javier Garcia on 9/10/20.
//  Copyright © 2020 codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var customField: UITextField!
    @IBOutlet weak var splitField: UITextField!

    @IBOutlet weak var segOneLabel: UILabel!
    @IBOutlet weak var segTwoLabel: UILabel!
    @IBOutlet weak var segThreeLabel: UILabel!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var customLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var currencyButton: UIButton!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var outletSwitch: UISwitch!
    @IBOutlet weak var splitStepper: UIStepper!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    
    var counter = 0
    
    
    @IBAction func splitAction(_ sender: Any) {
        splitField.text = String(format: "%.0f", splitStepper.value)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        roundCorners()
        billField.becomeFirstResponder()

        
        
    }
    
    func roundCorners () {
        segOneLabel.layer.masksToBounds = true
        segTwoLabel.layer.masksToBounds = true
        segThreeLabel.layer.masksToBounds = true
        customLabel.layer.masksToBounds = true
        
        currencyButton.layer.cornerRadius = 15.0
        payButton.layer.cornerRadius = 15.0
        segOneLabel.layer.cornerRadius = 15.0
        segTwoLabel.layer.cornerRadius = 15.0
        segThreeLabel.layer.cornerRadius = 15.0
        customLabel.layer.cornerRadius = 15.0
    }


    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setBackground()
    }

    @IBAction func currencyButton(_ sender: UIButton) {
        self.sortCurrency()

    }
    

    func sortCurrency(){
        let arraySize = 4
        
        if counter < arraySize {
            counter = counter + 1
        } else {
            counter = 0
        }
        
    }
        //let currencyLocale = [Locale.current, Locale(identifier: "fr_FR"), Locale(identifier: "de_DE")]
    
    @IBAction func darkAction(_ sender: Any) {
        if outletSwitch.isOn == true {
            overrideUserInterfaceStyle = .dark
            print ("overide to dark")
        } else {
            overrideUserInterfaceStyle = .light
            print ("override to light")
        }
    }
    

    
    
    func setBackground () {
        switch traitCollection.userInterfaceStyle {
        case .light:
            if outletSwitch.isOn == true {
                outletSwitch.setOn(false, animated:true)
            }
        case .dark:
            if outletSwitch.isOn == false {
                outletSwitch.setOn(true, animated:true)
            }
        case .unspecified:
            print ("unspecififed")
        }
    }
    

    
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)

    }
    
    

    
    @IBAction func calculateTip(_ sender: Any) {
        let bill = Double(billField.text!) ?? 0
        let split = splitStepper.value
        var tip = 0.0
        var custom = 0.0
        
        
        let billPercentages = [0.1, 0.15, 0.2, Double(customField.text!) ?? 0]

        
        
        
        
        if (billPercentages[tipControl.selectedSegmentIndex]) == billPercentages[3]{
            tip = billPercentages[3]
            custom = tip
            //customLabel.text = String(format: "$%.2f", custom)
        } else {
            tip = bill * billPercentages[tipControl.selectedSegmentIndex]
        }
        
        let segOne = bill * billPercentages[0]
        let segTwo = bill * billPercentages[1]
        let segThree = bill * billPercentages[2]
        
        var tipPercent = 100*(tip/bill)
        let tipString = "% Tip"
        var testString = String(format: "%.0f", tipPercent)
        
        if testString == "inf" || testString == "nan"{
            testString = "0"
            print ("test")
        }
        tipPercentLabel.text = testString + tipString
        
        
        let total = (bill + tip)/split
        
        
        
        var index = 1
        
        
        
        
        let testArray = [segOne, segTwo, segThree, custom, bill, tip, total]
        var labelArray = [segOneLabel, segTwoLabel, segThreeLabel, customLabel, billLabel, tipLabel, totalLabel]
        
        
        let currencyLocale = ["en_US", "fr_FR", "de_DE", "pt_BR", "en_UK"]
        let currencyCountries = ["US", "FRA", "GER", "BRIT", "UK"]
        let currency = currencyLocale[counter]
        currencyButton.setTitle(currencyCountries[counter], for: .normal)
        
        var z = 0
        while z < 7 {
            let currencyFormatter = NumberFormatter()
            currencyFormatter.usesGroupingSeparator = true
            currencyFormatter.numberStyle = .currency
            
            //currencyFormatter.locale = Locale.current
            
            currencyFormatter.locale = Locale(identifier: currency)
            //print ("CURRENCY", currency, counter)
            
                
            let priceString = currencyFormatter.string(from: NSNumber(value: testArray[z]))!
            //print("price", priceString) // Displays $9,999.99 in the US locale
            
            labelArray[z]?.text = priceString
            z = z+1
        }
        

        
        //segOneLabel.text = String(format: "$%.2f", segOne)
        //                                                          add those comments
        //segTwoLabel.text = String(format: "$%.2f", segTwo)
        //segThreeLabel.text = String(format: "$%.2f", segThree)
        //billLabel.text = priceString
        //tipLabel.text = String(format: "$%.2f", tip)
        //totalLabel.text = String(format: "$%.2f", total)
        

    }
    

    
}
