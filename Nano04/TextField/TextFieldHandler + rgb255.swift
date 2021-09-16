//
//  TextFieldHandler + rgb255Conversion.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 16/08/21.
//

import UIKit

extension TextFieldHandler{
    
    @IBAction func rgb255DidEnd(_ sender: UITextField) {
        
        switch sender {
        case rgb255[0]:                                                         //RED channel
            let number = stringToNumber(rgb255[0].text)
            let r1 = rgb255to1(number)
            let hex = numberToHex(value: number)
            let cmky = rgb255ToCMKY(r: number,
                                    g: stringToNumber(rgb255[1].text),
                                    b: stringToNumber(rgb255[2].text))
            
            assignR1(index: 0, value: r1)
            assignHex(index: 0, value: hex)
            assignCMYK(cmky)
            
        case rgb255[1]:                                                         //GREEN channel
            let number = stringToNumber(rgb255[1].text)
            let g1 = rgb255to1(number)
            let hex = numberToHex(value: number)
            let cmky = rgb255ToCMKY(r: stringToNumber(rgb255[0].text),
                                    g: number,
                                    b: stringToNumber(rgb255[2].text))
            
            assignR1(index: 1, value: g1)
            assignHex(index: 1, value: hex)
            assignCMYK(cmky)
            
        case rgb255[2]:                                                         //BLUE channel
            let number = stringToNumber(rgb255[2].text)
            let b1 = rgb255to1(number)
            let hex = numberToHex(value: number)
            let cmky = rgb255ToCMKY(r: stringToNumber(rgb255[0].text),
                                    g: stringToNumber(rgb255[1].text),
                                    b: number)
            
            assignR1(index: 2, value: b1)
            assignHex(index: 2, value: hex)
            assignCMYK(cmky)
            
        case rgb255[3]:                                                         //ALPHA channel
            let number = stringToNumber(rgb255[3].text)
            let a1 = rgb255to1(number)
            let hex = numberToHex(value: number)
            
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
    
    func rgb255to1(_ value: Int) -> Double{
        return Double(value)/255.0
    }
    
    func stringToNumber(_ value: String?) -> Int{
        return Int(value ?? "") ?? 0;
    }
    
}
