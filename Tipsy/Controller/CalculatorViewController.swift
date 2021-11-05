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
    
    var billValue: Double {
        guard let inputBillValue = billTextField.text,
              let billValue = Double(inputBillValue) else {
                  return 0
              }
        
        return billValue
    }
    
    func getTip() -> Tips? {
       return tipsButtons.first { (key: Tips, button: UIButton) in
            button.isSelected
        }?.key
    }
    
    func getSplitNumber() -> Double? {
        guard let splitNumber = splitNumberLabel.text else {
            return nil
        }
        return Double(splitNumber)
    }
    
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
        guard let tip = getTip(),
              let splitNumber = getSplitNumber()
             else {
                 print("Some of the fields are not filled.")
                 return
              }
        
        let calculatedBill = split(bill: billValue, tip: tip, splitNumber: splitNumber)
        result = Result(
            calculatedBill: String(format: "%.2f", calculatedBill),
            splitNumber: String(format: "%.0f", splitNumber),
            tip: tip.displayValue
        )
        print(calculatedBill)

        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    func split(bill billValue: Double, tip: Tips, splitNumber: Double) -> Double {
        return billValue * (1 + tip.rawValue) / splitNumber
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = result
        }
    }
}

