//
//  ColorConverter + Analogous.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 24/11/21.
//

import UIKit

extension ColorConverter{
    
    static func calculateAnalogous(red: Double, green: Double, blue: Double) -> (alpha: Double,
                                                                                 rightOne: (r:Double, g:Double, b:Double),
                                                                                 rightTwo: (r:Double, g:Double, b:Double),
                                                                                 leftOne: (r:Double, g:Double, b:Double),
                                                                                 leftTwo: (r:Double, g:Double, b:Double)){
        let (h,s,l) = ColorConverter.rgbToHSV(r: red, g: green, b: blue)
        
        let closeDegree: Double = 20
        let biggerDegree: Double = 35
        
        let hRightOne = h - closeDegree                                  //Getting the adjacent Hue
        let hRightTwo = h - biggerDegree
        
        let hLeftOne = h + closeDegree
        let hLeftTwo = h + biggerDegree
        
        let rightOne = ColorConverter.hsvTorgb(h: hRightOne, s: s, l: l)
        let rightTwo = ColorConverter.hsvTorgb(h: hRightTwo, s: s, l: l)
        
        let leftOne = ColorConverter.hsvTorgb(h: hLeftOne, s: s, l: l)
        let leftTwo = ColorConverter.hsvTorgb(h: hLeftTwo, s: s, l: l)
                
        return (l, rightOne, rightTwo, leftOne, leftTwo)
    }
    
}
