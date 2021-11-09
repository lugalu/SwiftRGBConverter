//
//  KeyboardVIew.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 03/11/21.
//

import UIKit

class KeyboardView: UIView {

    weak var target: UIKeyInput?
    
    static func instantiate(target: UIKeyInput)-> KeyboardView? {
        //autoresizingMask = [.flexibleWidth, .flexibleHeight]
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
        print("älp")
    }
    
    @IBAction func didPressDelete(_ sender: UIButton){
        target?.deleteBackward()
    }
    
    @IBAction func didPressButton(_ sender: UIButton){
        guard let text = sender.titleLabel?.text else {
            return
        }
        print(self.target)
        self.target?.insertText(text)
    }
  
}
