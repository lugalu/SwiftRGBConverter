//
//  ColorConverter + HSV.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 24/11/21.
//

import UIKit

// - MARK: - HSV
extension ColorConverter{
    static func rgbToHSV(r: Double, g: Double, b: Double) -> (h: Double, s: Double, v: Double){
        let cMax = max(r, g, b)
        let cMin = min(r, g, b)
        let delta = cMax - cMin
        
        var h: Double
        var s: Double
        let l: Double = cMax
        
        if delta == 0 {
            h = 0
            s = 0
        }else{
                    
            switch cMax{
                case r:
                h = 60 * ((g - b) / delta).truncatingRemainder(dividingBy: 6)
                case g:
                h = 60 * (((b - r) / delta) + 2)
                case b:
                h = 60 * (((r - g) / delta) + 4)
                default:
                h = 0
            }
            
            if cMax == 0{
                s = 0
            }else{
                s = delta / cMax
            }
            
            if h < 0{
                h += 1
            }else if h > 1{
                h -= 1
            }
            

        }
        
        
        return (h,s,l)
    }
        
    /**
        Converts hsv to rgb
     
        - Parameters:
         - h: Double meaning the hue value
         - s: Double meaning the saturation value
         - l: Double meaning the lightness value
     
        - Returns: the normalized tuple
     */
    static func hsvTorgb(h:Double,s:Double,l:Double) -> (r:Double,g:Double,b:Double){
        var (tempH, tempS, tempV) = normalizeHsv(hsv: (h,s,l))
        
        let color = tempV * tempS
        let x = color * (1 - abs( 1 - ((tempH/60).truncatingRemainder(dividingBy: 2))))
        let m = tempV - color
        
        var tempR: Double = 1
        var tempG: Double = 1
        var tempB: Double = 1
        
        switch tempH{
            case _ where tempH >= 0 && tempH < 60:
                tempR = color
                tempG = x
                tempB = 0
            case _ where tempH >= 60 && tempH < 120:
                tempR = x
                tempG = color
                tempB = 0
            case _ where tempH >= 120 && tempH < 180:
                tempR = 0
                tempG = color
                tempB = x
            case _ where tempH >= 180 && tempH < 240:
                tempR = 0
                tempG = x
                tempB = color
            case _ where tempH >= 240 && tempH < 300:
                tempR = x
                tempG = 0
                tempB = color
            case _ where tempH >= 300 && tempH < 360:
                tempR = color
                tempG = 0
                tempB = x
            default:
                print("error",tempH)
        }
        
        tempR += m
        tempG += m
        tempB += m
        
        return (tempR,tempG,tempB)
    }
    
    
    /**
        Normalizes the hsv value to guarantee that is in 0-360 circle degree/angle
     
        - Parameters:
         - hsv: tuple containing each individual value(h,s,v) as Doubles
     
        - Returns: the normalized tuple
     */
    static func normalizeHsv(hsv:(h: Double, s: Double, v: Double)) -> (h: Double, s: Double, v: Double){
        var (normH,normS,normV) = hsv
        
        if normH < 0{
            normH = 360 - abs(normH)
        }else if normH > 360{
            normH = normH - 360
        }
        
        if normS < 0{
            normS = 360 - abs(normS)
        }else if normS > 360{
            normS = normS - 360
        }
        
        
        if normV < 0{
            normV = 360 - abs(normV)
        }else if normV > 360{
            normV = normV - 360
        }
        
       
        return (normH,normS,normV)
        
    }
    
}
