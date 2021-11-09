//
//  TextFieldHandler + rgb255Conversion.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 16/08/21.
//

import UIKit

extension TextfieldHandler{
    
    @IBAction func rgb255DidEnd(_ sender: UITextField) {
        
        switch sender {
        case rgb255[0]:                                                         //RED channel
            let number = ColorConverter.stringToNumber(rgb255[0].text)
            let r1 = ColorConverter.rgb255to1(number)
            let hex = ColorConverter.numberToHex(value: number)
            let cmky = ColorConverter.rgb255ToCMYK(r: number,
                                    g: ColorConverter.stringToNumber(rgb255[1].text),
                                    b: ColorConverter.stringToNumber(rgb255[2].text))
            
            assignR1(index: 0, value: r1)
            assignHex(index: 0, value: hex)
            assignCMYK(cmky)
            
        case rgb255[1]:                                                         //GREEN channel
            let number = ColorConverter.stringToNumber(rgb255[1].text)
            let g1 = ColorConverter.rgb255to1(number)
            let hex = ColorConverter.numberToHex(value: number)
            let cmky = ColorConverter.rgb255ToCMYK(r: ColorConverter.stringToNumber(rgb255[0].text),
                                    g: number,
                                    b: ColorConverter.stringToNumber(rgb255[2].text))
            
            assignR1(index: 1, value: g1)
            assignHex(index: 1, value: hex)
            assignCMYK(cmky)
            
        case rgb255[2]:                                                         //BLUE channel
            let number = ColorConverter.stringToNumber(rgb255[2].text)
            let b1 = ColorConverter.rgb255to1(number)
            let hex = ColorConverter.numberToHex(value: number)
            let cmky = ColorConverter.rgb255ToCMYK(r: ColorConverter.stringToNumber(rgb255[0].text),
                                    g: ColorConverter.stringToNumber(rgb255[1].text),
                                    b: number)
            
            assignR1(index: 2, value: b1)
            assignHex(index: 2, value: hex)
            assignCMYK(cmky)
            
        case rgb255[3]:                                                         //ALPHA channel
            let number = ColorConverter.stringToNumber(rgb255[3].text)
            let a1 = ColorConverter.rgb255to1(number)
            let hex = ColorConverter.numberToHex(value: number)
            
            assignR1(index: 3, value: a1)
            assignHex(index: 3, value: hex)
        default:
            return
        }
        colorDelegate?.updateColorViewer()
    }
    
    func assignR255(index i: Int, value: Int){
        rgb255[i].text = String(value)
    }
    
}
