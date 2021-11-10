//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tipsButtons: [Tips: UIButton]!
    var result: Result!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTipButtons()
        splitNumberLabel.text = "2"
    }
    
    fileprivate func setupTipButtons() {
        tenPctButton.isSelected = true
        tipsButtons = [Tips.zero: zeroPctButton, Tips.ten: tenPctButton, Tips.twenty: twentyPctButton]
        tipsButtons.forEach { (key: Tips, button: UIButton) in
            button.setTitle(key.displayValue, for: .normal)
        }
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        tipsButtons.forEach { (key: Tips, button: UIButton) in
            button.isSelected = false
        }
        
        guard let currentTip = tipsButtons.first(where: {(key: Tips, button: UIButton) in
            button == sender
        }) else {
           return
       }
        
        currentTip.value.isSelected = true
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        billTextField.endEditing(true)
        splitNumberLabel.text = String(format: "%.0f", sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        result = Calculator(billTextField: billTextField, splitNumberLabel: splitNumberLabel, tipsButtons: tipsButtons).split()
      
        print(result!)

        self.performSegue(withIdentifier: "goToResults", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = result
        }
    }
}

