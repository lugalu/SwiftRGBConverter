//
//  ColorConverter + RGB.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 24/11/21.
//

import UIKit

// MARK: - RGB
extension ColorConverter{
  
    /**
        Expects a RGB 255 number to Converts to normalized RGB 1.0 double
     
        - Parameters:
          - value: Int value interval must be 0-255
     
        - Returns: Normalized value as double
     */
    static func rgb255to1(_ value: Int) -> Double{
        return Double(value)/255.0
    }
    
    /**
        Expects a RGB 1.0 number to Converts to normalized RGB 255 double
     
        - Parameters:
          - value: Int value interval must be 0-255
     
        - Returns: Normalized value as double
     */
    static func rgb1to255(_ value: Double) -> Int{
        return Int(value * 255)
    }
    
    /**
        Converts a String value to a Integer
     
        - Parameters:
          - value: Optional String to be converted.
     
        - Returns: the converted Integer value or 0 if failed
     */
    static func stringToNumber(_ value: String?) -> Int{
        return Int(value ?? "") ?? 0;
    }
    
    
    /**
        Converts a String value to a Double
     
        - Parameters:
          - value: Optional String to be converted.
     
        - Returns: the converted Double value or 0 if failed
     */
    static func stringToDouble(_ value: String) -> Double{
        return Double(value) ?? 0.0
    }
 
}
