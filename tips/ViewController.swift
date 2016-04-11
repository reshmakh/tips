//
//  ViewController.swift
//  tips
//
//  Created by Reshma Khilnani on 3/26/16.
//  Copyright © 2016 Reshma Khilnani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var totalTextLabel: UILabel!
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up the base labels, and pull the settings from defaults
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        let selectedPercentage = defaults.integerForKey("tip_percentage")
        tipControl.selectedSegmentIndex = selectedPercentage
        
        // If there was a bill amount in the past 10 minutes, show it
        let billTime = defaults.objectForKey("bill_time") as! NSDate!
        let billAmount = defaults.objectForKey("bill_amount") as! Double!
        if (billTime != nil && billAmount != 0.0) {
            let distanceBetweenDates = minutesFrom(billTime)
            if 10 > distanceBetweenDates {
                billField.text = String(format: "%.2f", defaults.doubleForKey("bill_amount"))
                onEditingChanged(self)
            }
        } else {
            billField.text = ""
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        let tipPercentages = [0.18, 0.2, 0.22]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount = getBillAmount()
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        saveCurrentBillAmount()
    }

    @IBAction func onTap(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        billField.becomeFirstResponder()
        updateTheme()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let tipDefault = defaults.integerForKey("tip_percentage")
        tipControl.selectedSegmentIndex = tipDefault
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        saveCurrentBillAmount()
    }
    
    func saveCurrentBillAmount() {
        defaults.setObject(NSDate(), forKey: "bill_time")
        defaults.setDouble(getBillAmount(), forKey: "bill_amount")
        defaults.synchronize()
    }
    
    func getBillAmount() -> Double {
        let billString = billField.text!
        var billAmount = Double(billString)
        if billAmount == nil {
            billAmount = 0.0
        }
        return billAmount!
    }
    
    func minutesFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Minute, fromDate: date, toDate: NSDate(), options: []).minute
    }
    
    func updateTheme() {
        var textColor = UIColor.blackColor()
        var backgroundColor = UIColor.whiteColor()
        let activeTheme = defaults.integerForKey("theme")
        if activeTheme == 1 {
            textColor = UIColor.whiteColor()
            backgroundColor = UIColor.blackColor()
        }
        self.view.backgroundColor = backgroundColor
        tipControl.tintColor = textColor
        totalLabel.textColor = textColor
        tipLabel.textColor = textColor
        billField.textColor = textColor
        currencyLabel.textColor = textColor
        totalTextLabel.textColor = textColor
    }

}

