//
//  Tips.swift
//  Tipsy
//
//  Created by Ungurean Valentina on 05.11.2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

enum Tips: Double, RawRepresentable, CaseIterable {
    case zero = 0
    case ten = 0.1
    case twenty = 0.2
    
    var displayValue: String {
        switch self {
        case .zero:
            return "0%"
        case .ten:
            return "10%"
        case .twenty:
            return "20%"
        }
    }
}
