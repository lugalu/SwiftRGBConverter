//
//  ColorConverter + Hex.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 24/11/21.
//

import UIKit

// - MARK: - HEX
extension ColorConverter{
    /**
        Converts from a String HEX to a Integer number. This was tested with only 2 Chars per HEX more than that the result can be unexpected
     
        - Parameters:
          - value: optional string representing the HEX
     
        - Returns: Int value returns 0 if couldn't transform.
     */
    static func hexToNumber(value: String?) -> Int{
        return Int(value ?? "0", radix: 16) ?? 0
    }
    
    /**
        Converts from an Integer value to a uppercased string
     
        - Parameters:
          - value: Integer value to be converted
     
        - Returns: Uppercased Hex value of the value.
     */
    static func numberToHex(value: Int) -> String{
        return String(value, radix: 16).uppercased()
    }
    
}
