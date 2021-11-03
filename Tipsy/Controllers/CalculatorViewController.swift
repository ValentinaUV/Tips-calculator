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
    
    var selectedTip = "10%"
    var splitNumber = "2"
    var bill: Float = 0
    var calculatedBill = "0.00"
    
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
        let tipValue = (selectedTip as NSString).floatValue/100
        print(splitNumber)
        let billValue = Float(billTextField.text!) ?? 0
        
        bill = (billValue + billValue*tipValue)/Float(splitNumber)!
        calculatedBill = String(format: "%0.2f", bill)
        
        print(calculatedBill)
        
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.splitNumber = splitNumber
            destinationVC.tip = selectedTip
            destinationVC.calculatedBill = calculatedBill
        }
    }
}

