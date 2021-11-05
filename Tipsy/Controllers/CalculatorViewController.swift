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
    
    var selectedTip: String?
    var splitNumber: String?
    var calculatedBill: String?
    let tipValues: [String: Float] = [
        "0%": 0.0,
        "10%": 0.1,
        "20%": 0.2
    ]
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true
        selectedTip = sender.currentTitle!
        
    }
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        billTextField.endEditing(true)
        splitNumber = String(format: "%.0f", sender.value)
        splitNumberLabel.text = splitNumber
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
//        guard let tip = selectedTip else {let tip = "10%"}
        let tip = selectedTip ?? "10%"
        let tipValue = tipValues[tip] ?? 0.1
        
//        let tip = selectedTip ?? "10%"
//        tipValue = tipValues[tip]
//        guard let billText = billTextField.text else {let billText = ""}
        let billText = billTextField.text ?? "0"
        
        let nr = Float(splitNumber ?? "2") ?? 2.0
//        guard let nr = splitNumber else {return}

        let billValue = Float(billText) ?? 0
        let bill = (billValue + billValue*tipValue)/nr
        calculatedBill = String(format: "%0.2f", bill)
        
        print(calculatedBill)
        
        self.performSegue(withIdentifier: "goToResults", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goToResults" {
//            let destinationVC = segue.destination as! ResultsViewController
//            destinationVC.splitNumber = splitNumber
//            destinationVC.tip = selectedTip
//            destinationVC.calculatedBill = calculatedBill
//        }
    }
}

