//
//  AppColors.swift
//  VideoStreamer
//
//  Created by Sidharth J Dev on 12/12/24.
//

import Foundation
import UIKit

class AppColors {
    

    // Method to create a UIColor from a hex code
    static func fromHex(_ hex: String, alpha: CGFloat = 1.0) -> UIColor? {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension UIColor {
  
}
