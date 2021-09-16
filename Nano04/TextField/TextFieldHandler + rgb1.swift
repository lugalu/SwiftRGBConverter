//
//  TextFieldHandler + rgb1.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 16/08/21.
//

import UIKit

extension TextFieldHandler{
    
    @IBAction func didEndRgb1(_ sender: UITextField) {
        let rText = rgb1[0].text?.replacingOccurrences(of: ",", with: ".") ?? "0.0"
        let gText = rgb1[1].text?.replacingOccurrences(of: ",", with: ".") ?? "0.0"
        let bText = rgb1[2].text?.replacingOccurrences(of: ",", with: ".") ?? "0.0"
        let aText = rgb1[3].text?.replacingOccurrences(of: ",", with: ".") ?? "0.0"
        
        switch sender {
        case rgb1[0]:
            let r = stringToDouble(value: rText)
            let g = stringToDouble(value: gText)
            let b = stringToDouble(value: bText)
            
            let r255 = rgb1to255(r)
            let g255 = rgb1to255(g)
            let b255 = rgb1to255(b)
            
            let rHex = numberToHex(value: r255)
            
            let cmykValue = rgb255ToCMKY(r: r255, g: g255, b: b255)
            
            assignR255(index: 0, value: r255)
            assignHex(index: 0, value: rHex)
            assignCMYK(cmykValue)
            
        case rgb1[1]:
            let r = stringToDouble(value: rText)
            let g = stringToDouble(value: gText)
            let b = stringToDouble(value: bText)
            
            let r255 = rgb1to255(r)
            let g255 = rgb1to255(g)
            let b255 = rgb1to255(b)
            
            let gHex = numberToHex(value: g255)
            
            let cmykValue = rgb255ToCMKY(r: r255, g: g255, b: b255)
            
            assignR255(index: 1, value: g255)
            assignHex(index: 1, value: gHex)
            assignCMYK(cmykValue)
            
        case rgb1[2]:
            let r = stringToDouble(value: rText)
            let g = stringToDouble(value: gText)
            let b = stringToDouble(value: bText)
            
            let r255 = rgb1to255(r)
            let g255 = rgb1to255(g)
            let b255 = rgb1to255(b)
            
            let bHex = numberToHex(value: r255)
            
            let cmykValue = rgb255ToCMKY(r: r255, g: g255, b: b255)
            
            assignR255(index: 2, value: b255)
            assignHex(index: 0, value: bHex)
            assignCMYK(cmykValue)
            
        case rgb1[3]:
            let r = stringToDouble(value: rText)
            let g = stringToDouble(value: gText)
            let b = stringToDouble(value: bText)
            let a = stringToDouble(value: aText)
            
            let r255 = rgb1to255(r)
            let g255 = rgb1to255(g)
            let b255 = rgb1to255(b)
            let a255 = rgb1to255(a)
            
            let aHex = numberToHex(value: a255)
            
            let cmykValue = rgb255ToCMKY(r: r255, g: g255, b: b255)
            
            assignR255(index: 3, value: a255)
            assignHex(index: 3, value: aHex)
            assignCMYK(cmykValue)
        default:
            return
        }
        colorDelegate?.updateColorViewer()
    }
    
    func stringToDouble(value: String) -> Double{
        let result = Double(value) ?? 0.0
        return result
    }
    
    func assignR1(index i: Int, value: Double){
        rgb1[i].text = String(value)

    }
    
    func rgb1to255(_ value: Double) -> Int{
        return Int(value * 255)
    }
}
