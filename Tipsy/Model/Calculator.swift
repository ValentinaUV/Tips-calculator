//
//  Calculator.swift
//  Tipsy
//
//  Created by Ungurean Valentina on 05.11.2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import UIKit

struct Calculator {
    let billTextField: UITextField!
    let splitNumberLabel: UILabel!
    var tipsButtons: [Tips: UIButton]!
    
    func getBillValue() -> Double {
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

    func split() -> Result? {
        guard let tip = getTip(),
              let splitNumber = getSplitNumber()
        else {
             print("Some of the fields are not filled.")
             return nil
        }
        
        let calculatedBill = getBillValue() * (1 + tip.rawValue) / splitNumber
        
        return Result(
            calculatedBill: String(format: "%.2f", calculatedBill),
            splitNumber: String(format: "%.0f", splitNumber),
            tip: tip.displayValue
        )
    }
}
