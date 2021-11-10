//
//  TextFieldhandler + hexConversions.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 16/08/21.
//
import UIKit

extension TextfieldHandler{
    //This file has all the hex conversions or needs for the hexField to work properly
    
    /*
        handles all the inputs related to the EditEnd in the hex fields
     */
    @IBAction func editEndHex(_ sender: UITextField) {
        switch sender {
        case hex[0]:                                                                        //RED Channel
            let r255 = ColorConverter.hexToNumber(value: hex[0].text)
            let r1 = ColorConverter.rgb255to1(r255)
            let convertedCMYK = ColorConverter.rgb255ToCMYK(r: r255,
                                             g: ColorConverter.hexToNumber(value: hex[1].text ?? "0"),
                                             b: ColorConverter.hexToNumber(value: hex[2].text ?? "0"))
            
            assignR255(index: 0, value: r255)
            assignR1(index: 0, value: r1)
            assignCMYK(convertedCMYK)
            print("0")
        case hex[1]:                                                                        //GREEN channel
            let g255 = ColorConverter.hexToNumber(value: hex[1].text)
            let g1 = ColorConverter.rgb255to1(g255)
            let convertedCMYK = ColorConverter.rgb255ToCMYK(r: ColorConverter.hexToNumber(value: hex[0].text ?? "0"),
                                             g: g255,
                                             b: ColorConverter.hexToNumber(value: hex[2].text ?? "0"))
            
            assignR255(index: 1, value: g255)
            assignR1(index: 1, value: g1)
            assignCMYK(convertedCMYK)
            print("1")
        case hex[2]:                                                                        //BLUE channel
            let b255 = ColorConverter.hexToNumber(value: hex[2].text)
            let b1 = ColorConverter.rgb255to1(b255)
            let convertedCMYK = ColorConverter.rgb255ToCMYK(r: ColorConverter.hexToNumber(value: hex[0].text ?? "0"),
                                             g: ColorConverter.hexToNumber(value: hex[1].text ?? "0"),
                                             b: b255)
            
            assignR255(index: 2, value: b255)
            assignR1(index: 2, value: b1)
            assignCMYK(convertedCMYK)
            print("2")
        case hex[3]:                                                                        //ALPHA channel
            let a255 = ColorConverter.hexToNumber(value: hex[3].text)
            let a1 = ColorConverter.rgb255to1(a255)
            
            assignR255(index: 3, value: a255) 
            assignR1(index: 3, value: a1)
            print("3")
        default:
           return
        }
        colorDelegate?.updateColorViewer()                                                                                   //tells the view controller to update the color.
    }
    
    func assignHex(index i: Int, value: String){
        hex[i].text = value
    }
    
}
