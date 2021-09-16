//
//  TextFieldhandler + hexConversions.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 16/08/21.
//
import UIKit

extension TextFieldHandler{
    //This file has all the hex conversions or needs for the hexField to work properly
    
    /*
        handles all the inputs related to the EditEnd in the hex fields
     */
    @IBAction func editEndHex(_ sender: UITextField) {
        switch sender {
        case hex[0]:                                                                        //RED Channel
            let r255 = hexToNumber(value: hex[0].text)
            let r1 = rgb255to1(r255)
            let convertedCMYK = rgb255ToCMKY(r: r255,
                                             g: hexToNumber(value: hex[1].text ?? "0"),
                                             b: hexToNumber(value: hex[2].text ?? "0"))
            
            assignR255(index: 0, value: r255)
            assignR1(index: 0, value: r1)
            assignCMYK(convertedCMYK)
            
        case hex[1]:                                                                        //GREEN channel
            let g255 = hexToNumber(value: hex[1].text)
            let g1 = rgb255to1(g255)
            let convertedCMYK = rgb255ToCMKY(r: hexToNumber(value: hex[0].text ?? "0"),
                                             g: g255,
                                             b: hexToNumber(value: hex[2].text ?? "0"))
            
            assignR255(index: 1, value: g255)
            assignR1(index: 1, value: g1)
            assignCMYK(convertedCMYK)
            
        case hex[2]:                                                                        //BLUE channel
            let b255 = hexToNumber(value: hex[2].text)
            let b1 = rgb255to1(b255)
            let convertedCMYK = rgb255ToCMKY(r: hexToNumber(value: hex[0].text ?? "0"),
                                             g: hexToNumber(value: hex[1].text ?? "0"),
                                             b: b255)
            
            assignR255(index: 2, value: b255)
            assignR1(index: 2, value: b1)
            assignCMYK(convertedCMYK)
            
        case hex[3]:                                                                        //ALPHA channel
            let a255 = hexToNumber(value: hex[3].text)
            let a1 = rgb255to1(a255)
            
            assignR255(index: 3, value: a255) 
            assignR1(index: 3, value: a1)
        default:
           return
        }
        colorDelegate?.updateColorViewer()                                                                                   //tells the view controller to update the color.
    }
    
    func assignHex(index i: Int, value: String){
        hex[i].text = value
    }
    
    /*
        A hex value as String is transformed to a int if cannot transform it becomes 0
     */
    func hexToNumber(value: String?) -> Int{
        return Int(value ?? "0", radix: 16) ?? 0
    }
    
    /*
        A int value gets transformed to String this operation is non-optional.
     */
    func numberToHex(value: Int) -> String{
        return String(value, radix: 16).uppercased()
    }
}
