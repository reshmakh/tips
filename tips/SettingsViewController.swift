//
//  SettingsViewController.swift
//  tips
//
//  Created by Reshma Khilnani on 3/27/16.
//  Copyright © 2016 Reshma Khilnani. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var themeControl: UISegmentedControl!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    var defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tipDefault = defaults.integerForKey("tip_percentage")
        tipControl.selectedSegmentIndex = tipDefault
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateTheme()
    }

    @IBAction func onPercentageEdit(sender: AnyObject) {
        defaults.setObject(tipControl.selectedSegmentIndex, forKey: "tip_percentage")
        print(tipControl.selectedSegmentIndex)
        defaults.synchronize()
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        defaults.setObject(themeControl.selectedSegmentIndex, forKey: "theme")
        updateTheme()
    }
    
    func updateTheme() {
        var textColor = UIColor.blackColor()
        var backgroundColor = UIColor.whiteColor()
        
        let activeTheme = defaults.integerForKey("theme")
        if activeTheme == 1 {
            textColor = UIColor.whiteColor()
            backgroundColor = UIColor.blackColor()
        }
        themeControl.selectedSegmentIndex = activeTheme
        self.view.backgroundColor = backgroundColor
        themeLabel.textColor = textColor
        themeControl.tintColor = textColor
        percentageLabel.textColor = textColor
        tipControl.tintColor = textColor
    }

}
