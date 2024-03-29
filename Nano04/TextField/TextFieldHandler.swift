//
//  TextFieldHandler.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 13/08/21.
//

import UIKit

class TextFieldHandler: UIView, UITextFieldDelegate{
    
    @IBOutlet var hex: [UITextField]!
    @IBOutlet var rgb1: [UITextField]!
    @IBOutlet var rgb255: [UITextField]!
    @IBOutlet var cmky: [UITextField]!
    var colorDelegate: ColorUpdaterDelegate? = nil
  
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxChars:Int
        var allowedChars:String? = nil
        let maxValue: Double
      
        let text = textField.text ?? ""
        
        guard let stringRange = Range(range, in: text) else{ return false}
        
        var newText = text.replacingCharacters(in: stringRange, with: string)
        newText = newText.replacingOccurrences(of: ",", with: ".")
        switch textField {
            case textField where hex.contains(textField):
               
                maxChars = 2
                allowedChars = "ABCDEF0123456789,."
                maxValue = 0
                
                return newText.count <= maxChars && newText == newText.filter(allowedChars?.contains ?? "".contains)
                
            case textField where rgb1.contains(textField):
               
                maxChars = 3
                maxValue = 1.0
                guard let value = Double(newText) else { return false }
                
                if Double(value) > maxValue { return false}
                
            case textField where rgb255.contains(textField):
               
                maxChars = 3
                maxValue = 255.0
                guard let value = Int(newText) else { return false }
                if Double(value) > maxValue { return false}
                
            case textField where cmky.contains(textField):
                
                maxChars = 3
                maxValue = 100.0
                guard let value = Double(newText) else { return false }
                if Double(value) > maxValue { return false}
            default:
                return false
        }
        
        
        return newText.count <= maxChars
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

