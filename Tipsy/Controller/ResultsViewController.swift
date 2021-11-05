//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Ungurean Valentina on 02.11.2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    var result: Result!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalLabel.text = result.calculatedBill
        settingsLabel.text = "Split between \(result.splitNumber) people, with \(result.tip) tip."
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
