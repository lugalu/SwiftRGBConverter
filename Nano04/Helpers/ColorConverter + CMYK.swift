//
//  ColorConverter + CMYK.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 24/11/21.
//

import UIKit

// - MARK: - CMYK
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
                      y: (ColorConverter.stringToDouble(strings.y ?? "0") / 100.0),
                      k: (ColorConverter.stringToDouble(strings.k ?? "0") / 100.0))
        return values
    }
}
