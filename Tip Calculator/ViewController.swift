//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Javier Garcia on 9/10/20.
//  Copyright © 2020 codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Text fields
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var customField: UITextField!
    @IBOutlet weak var splitField: UITextField!
    // Labels
    @IBOutlet weak var segOneLabel: UILabel!
    @IBOutlet weak var segTwoLabel: UILabel!
    @IBOutlet weak var segThreeLabel: UILabel!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var customLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    // Other controls
    @IBOutlet weak var currencyButton: UIButton!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var outletSwitch: UISwitch!
    @IBOutlet weak var splitStepper: UIStepper!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    var counter = 0
    var segOne = 0.0
    var segTwo = 0.0
    var segThree = 0.0
    var custom = 0.0
    var bill = 0.0
    var split = 0.0
    var tip = 0.0
    var total = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        roundCorners()
        billField.becomeFirstResponder()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setBackground()
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
            print ("unspecified")
        }
    }
    
    @IBAction func darkAction(_ sender: Any) {
        if outletSwitch.isOn == true {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
    }
    
    
    @IBAction func segmentAction(_ sender: Any) {
        view.endEditing(true)
        let billPercentages = [0.1, 0.15, 0.2, Double(customField.text!) ?? 0]
        if (billPercentages[tipControl.selectedSegmentIndex]) == billPercentages[3]{
            customField.becomeFirstResponder()
        }
    }
    
    
    @IBAction func splitAction(_ sender: Any) {
        resignFirstResponder()
        view.endEditing(true)
        splitField.text = String(format: "%.0f", splitStepper.value)
    }
    
    @IBAction func onTap(_ sender: Any) {
        resignFirstResponder()
        view.endEditing(true)
    }
    
    
    @IBAction func currencyButton(_ sender: UIButton) {
        resignFirstResponder()
        view.endEditing(true)
        let arraySize = 4
        if counter < arraySize{
            counter = counter + 1
        } else {
            counter = 0
        }
        self.sortCurrency()
    }
    

    

    func sortCurrency(){
        var labelArray = [segOneLabel, segTwoLabel, segThreeLabel, customLabel, billLabel, tipLabel, totalLabel]
        let testArray = [segOne, segTwo, segThree, custom, bill, tip, total]
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
            let priceString = currencyFormatter.string(from: NSNumber(value: testArray[z]))!
            labelArray[z]?.text = priceString
            z = z+1
        }
    }
    

    
    @IBAction func calculateTip(_ sender: Any) {
        let billPercentages = [0.1, 0.15, 0.2, Double(customField.text!) ?? 0]
        bill = Double(billField.text!) ?? 0
        split = splitStepper.value

        if (billPercentages[tipControl.selectedSegmentIndex]) == billPercentages[3]{
            tip = billPercentages[3]
            custom = tip
        } else {
            tip = bill * billPercentages[tipControl.selectedSegmentIndex]
        }
        
        segOne = bill * billPercentages[0]
        segTwo = bill * billPercentages[1]
        segThree = bill * billPercentages[2]
        
        var tipPercent = 100*(tip/bill)
        let tipString = "% Tip"
        var testString = String(format: "%.0f", tipPercent)
        if testString == "inf" || testString == "nan"{
            testString = "0"
            print ("test")
        }
        tipPercentLabel.text = testString + tipString
        total = (bill + tip)/split
        sortCurrency()
    }
}
