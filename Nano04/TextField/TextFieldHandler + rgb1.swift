//
//  TextFieldHandler + rgb1.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 16/08/21.
//

import UIKit

extension TextfieldHandler{
    
    @IBAction func didEndRgb1(_ sender: UITextField) {
        let rText = rgb1[0].text?.replacingOccurrences(of: ",", with: ".") ?? "0.0"
        let gText = rgb1[1].text?.replacingOccurrences(of: ",", with: ".") ?? "0.0"
        let bText = rgb1[2].text?.replacingOccurrences(of: ",", with: ".") ?? "0.0"
        let aText = rgb1[3].text?.replacingOccurrences(of: ",", with: ".") ?? "0.0"
        
        switch sender {
        case rgb1[0]:
            let r = ColorConverter.stringToDouble(rText)
            let g = ColorConverter.stringToDouble(gText)
            let b = ColorConverter.stringToDouble(bText)
            
            let r255 = ColorConverter.rgb1to255(r)
            let g255 = ColorConverter.rgb1to255(g)
            let b255 = ColorConverter.rgb1to255(b)
            
            let rHex = ColorConverter.numberToHex(value: r255)
            
            let cmykValue = ColorConverter.rgb255ToCMYK(r: r255, g: g255, b: b255)
            
            assignR255(index: 0, value: r255)
            assignHex(index: 0, value: rHex)
            assignCMYK(cmykValue)
            
        case rgb1[1]:
            let r = ColorConverter.stringToDouble(rText)
            let g = ColorConverter.stringToDouble(gText)
            let b = ColorConverter.stringToDouble(bText)
            
            let r255 = ColorConverter.rgb1to255(r)
            let g255 = ColorConverter.rgb1to255(g)
            let b255 = ColorConverter.rgb1to255(b)
            
            let gHex = ColorConverter.numberToHex(value: g255)
            
            let cmykValue = ColorConverter.rgb255ToCMYK(r: r255, g: g255, b: b255)
            
            assignR255(index: 1, value: g255)
            assignHex(index: 1, value: gHex)
            assignCMYK(cmykValue)
            
        case rgb1[2]:
            let r = ColorConverter.stringToDouble(rText)
            let g = ColorConverter.stringToDouble(gText)
            let b = ColorConverter.stringToDouble(bText)
            
            let r255 = ColorConverter.rgb1to255(r)
            let g255 = ColorConverter.rgb1to255(g)
            let b255 = ColorConverter.rgb1to255(b)
            
            let bHex = ColorConverter.numberToHex(value: r255)
            
            let cmykValue = ColorConverter.rgb255ToCMYK(r: r255, g: g255, b: b255)
            
            assignR255(index: 2, value: b255)
            assignHex(index: 0, value: bHex)
            assignCMYK(cmykValue)
            
        case rgb1[3]:
            let r = ColorConverter.stringToDouble(rText)
            let g = ColorConverter.stringToDouble(gText)
            let b = ColorConverter.stringToDouble(bText)
            let a = ColorConverter.stringToDouble(aText)
            
            let r255 = ColorConverter.rgb1to255(r)
            let g255 = ColorConverter.rgb1to255(g)
            let b255 = ColorConverter.rgb1to255(b)
            let a255 = ColorConverter.rgb1to255(a)
            
            let aHex = ColorConverter.numberToHex(value: a255)
            
            let cmykValue = ColorConverter.rgb255ToCMYK(r: r255, g: g255, b: b255)
            
            assignR255(index: 3, value: a255)
            assignHex(index: 3, value: aHex)
            assignCMYK(cmykValue)
        default:
            return
        }
        colorDelegate?.updateColorViewer()
    }
    
    func assignR1(index i: Int, value: Double){
        rgb1[i].text = String(format: "%.4f", value)

    }
 
}
