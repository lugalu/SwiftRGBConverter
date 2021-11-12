//
//  KeyboardVIew.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 03/11/21.
//

import UIKit

class KeyboardView: UIView {

    weak var target: UITextField?
    
    
    /**
        Instantiate a keyboard and configure some stuff.
     
        - Parameters:
         - target: the target textfield that will recive the keyboard commands
     
        - Returns: a optional keyboard it's nil if casting or xib load failed.
     */
    static func instantiate(target: UITextField)-> KeyboardView? {
        guard let xibArr = Bundle.main.loadNibNamed("HexKeyboard", owner: self, options: nil) else{
            return nil
        }
        guard let xib = xibArr[0] as? KeyboardView else{
            return nil
        }
        xib.target = target
        return xib
    }
    
    @IBAction func didPressEnter(_ sender: UIButton){
        self.target?.resignFirstResponder()
    }
    
    @IBAction func didPressDelete(_ sender: UIButton){
        target?.deleteBackward()
    }
    
    @IBAction func didPressButton(_ sender: UIButton){
        guard let text = sender.titleLabel?.text else {
            return
        }
        if shouldInsert(){
            self.target?.insertText(text)
        }
    }
    
    /**
        Checks if the conditions are met to insert into the hex textfield.
     
        - Returns: Boolean value that represents if should or not insert.
     */
    func shouldInsert() -> Bool{
        let maxChars:Int = 2
        let text = target?.text ?? ""
        
        return text.count < maxChars
    }
}
