// author: Javier Garcia Ramirez
// create date: 9/10/20
// last modified: 9/13/20
// filename: ViewController.swift
// description: View of Tip Calculator.
// runtime: N/A
// creation time: 12 hours

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
        billField.becomeFirstResponder() // Keyboard visible at initial launch of app.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setBackground() // Sets dark/light mode at initial launch or when app opens from standby mode.
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
                // If iPhone light mode is active but the switch is on, turn off the switch and animate/display off switch onto view.
                outletSwitch.setOn(false, animated:true)
            }
        case .dark:
            if outletSwitch.isOn == false {
                // If iPhone dark mode is active and the switch is off, turn on the switch and animate/display on switch onto view.
                outletSwitch.setOn(true, animated:true)
            }
        case .unspecified:
            print ("unspecified")
        @unknown default:
            print ("unkown default")
        }
    }
    
    // Enables the switch on view to function properly when value is switched.
    @IBAction func darkAction(_ sender: Any) {
        if outletSwitch.isOn == true {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
    }
    
    // If user taps custom field then the segment travels to Custom so the user does not have to click twice.
    @IBAction func customTap(_ sender: Any) {
        tipControl.selectedSegmentIndex = 3
    }
    
    
    @IBAction func segmentAction(_ sender: Any) {
        // When user switches segment, hide keyboard but enable it if segment is on Custom.
        view.endEditing(true)
        let billPercentages = [0.1, 0.15, 0.2, Double(customField.text!) ?? 0]
        if (billPercentages[tipControl.selectedSegmentIndex]) == billPercentages[3]{
            customField.becomeFirstResponder()
        }
    }
    
    @IBAction func splitAction(_ sender: Any) {
        resignFirstResponder()
        view.endEditing(true)
        // Displays double value with no decimals
        splitField.text = String(format: "%.0f", splitStepper.value)
    }
    
    // Tap anywhere to hide keyboard and firstResponder
    @IBAction func onTap(_ sender: Any) {
        resignFirstResponder()
        view.endEditing(true)
    }
    

    @IBAction func currencyButton(_ sender: UIButton) {
        resignFirstResponder()
        view.endEditing(true)
        let arraySize = 4
        if counter < arraySize {
            // When button is pressed, currencyCountry is sorted through by 1 index.
            counter = counter + 1
        } else {
            // User button title goes bacleto default (US) currency after sorting through entire list.
            counter = 0
        }
        self.sortCurrency()
    }
    

    
    // Make sure labels are updated with appropriate currency.
    func sortCurrency(){
        let labelArray = [segOneLabel, segTwoLabel, segThreeLabel, customLabel, billLabel, tipLabel, totalLabel]
        let testArray = [segOne, segTwo, segThree, custom, bill, tip, total]
        let currencyLocale = ["en_US", "fr_FR", "de_DE", "pt_BR", "en_UK"] // String for currency based on country/
        let currencyCountries = ["US", "FRA", "GER", "BRIT", "UK"] // Country name index corresponding to currency based on country.
        let currency = currencyLocale[counter]
        
        currencyButton.setTitle(currencyCountries[counter], for: .normal)
        
        var z = 0
        // Less than 7 because the both arrays at the top of this function contain 7 elements each.
        // Will use [z] to help sort through each element in both arrays.
        while z < 7 {
            let currencyFormatter = NumberFormatter()
            currencyFormatter.usesGroupingSeparator = true
            currencyFormatter.numberStyle = .currency // Turns 9000 into 9,000 or 9.000, depending on currency choice.
            //currencyFormatter.locale = Locale.current // Use this code if want to disable choice of currency and enable currency based on location.
            currencyFormatter.locale = Locale(identifier: currency) // currency is a string vale from currencyLocale.
            let priceString = currencyFormatter.string(from: NSNumber(value: testArray[z]))!
            labelArray[z]?.text = priceString // Same thing as segOneLabel.text = "9,000"
            z = z+1
        }
    }
    

    
    @IBAction func calculateTip(_ sender: Any) {
        // Element 4 is the value entered at customField and reads it as a Double.
        let billPercentages = [0.1, 0.15, 0.2, Double(customField.text!) ?? 0]
        // Get bill amount
        bill = Double(billField.text!) ?? 0
        split = splitStepper.value

        if (billPercentages[tipControl.selectedSegmentIndex]) == billPercentages[3]{
            tip = billPercentages[3] // Tip becomes equal to the value entered in custom field if the segment is placed on third segment (Custom).
            custom = tip
        } else {
            tip = bill * billPercentages[tipControl.selectedSegmentIndex] //
        }
        // letculate tips for each segment, except Custom.
        segOne = bill * billPercentages[0]
        segTwo = bill * billPercentages[1]
        segThree = bill * billPercentages[2]
        
        // Displays tip % based on bill.
        let tipPercent = 100*(tip/bill)
        let tipString = "% Tip"
        var testString = String(format: "%.0f", tipPercent)
        // Useful if user types number in bill field and then deletes bill amount.
        if testString == "inf" || testString == "nan"{
            testString = "0"
        }
        tipPercentLabel.text = testString + tipString
        total = (bill + tip)/split
        sortCurrency() // Make sure labels are updated with appropriate currency.
    }
}
