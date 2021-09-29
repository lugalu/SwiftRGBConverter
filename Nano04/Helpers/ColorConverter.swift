//
//  ColorConverter.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 15/09/21.
//

import UIKit

class ColorConverter{
    private init(){}
}

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

// MARK: - HEX
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


// MARK: - CMYK
extension ColorConverter{
    
    
    /**
        Converts from integer RGB 255 to CMYK
     
        - Parameters:
          - r: Integer value of the Red channel
          - b: Integer value of the blue channel
          - g: Integer value of the green channel
     
        - Returns: Tuple with the CMYK values as doubles and named.
     */
    static func rgb255ToCMYK(r: Int, g: Int, b: Int) -> (c:Double, m: Double, y: Double, k: Double){
        
        let r1 = ColorConverter.rgb255to1(r)
        let g1 = ColorConverter.rgb255to1(g)
        let b1 = ColorConverter.rgb255to1(b)
        
        var black = 1.0 - max(r1, g1, b1)
       
        var cyan:Double
        var magenta:Double
        var yellow:Double
        
        cyan = 100 * ((1.0 - r1 - black) / (1.0 - black))
        magenta = 100 * ((1.0 - g1 - black) / (1.0 - black))
        yellow = 100 * ((1.0 - b1 - black) / (1.0 - black))
        
       
        black *= 100
        
        if r1 == 0 && g1 == 0 && b1 == 0 {
            cyan = 0
            magenta = 0
            yellow = 0
        }
        
        return (cyan, magenta, yellow, black)
        
    }
    
    /**
        Converts from a tuple string to CMYK
     
        - Parameters:
          - strings: Tuple in the follorwing order (c,m,k,y)
     
        - Returns: Tuple with the CMYK values as doubles and named.
     */
    static func stringToCMYK(strings: (c: String?, m: String?, k: String?, y: String?)) -> (c: Double, m: Double, y: Double, k: Double){
        let values = (c: (ColorConverter.stringToDouble(strings.c ?? "0") / 100.0),
                      m: (ColorConverter.stringToDouble(strings.m ?? "0") / 100.0),
                      y: (ColorConverter.stringToDouble(strings.k ?? "0") / 100.0),
                      k: (ColorConverter.stringToDouble(strings.y ?? "0") / 100.0))
        return values
    }
}

