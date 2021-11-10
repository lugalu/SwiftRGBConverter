//
//  KeyboardVIew.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 03/11/21.
//

import UIKit

class KeyboardView: UIView {

    weak var target: UITextField?
    weak var colorDelegate: ColorUpdaterDelegate?
    
    static func instantiate(target: UITextField, delegate: ColorUpdaterDelegate?)-> KeyboardView? {
        //autoresizingMask = [.flexibleWidth, .flexibleHeight]
        guard let xibArr = Bundle.main.loadNibNamed("HexKeyboard", owner: self, options: nil) else{
            return nil
        }
        guard let xib = xibArr[0] as? KeyboardView else{
            return nil
        }
        xib.target = target
        xib.colorDelegate = delegate
        return xib
    }
    
    @IBAction func didPressEnter(_ sender: UIButton){
        self.target?.resignFirstResponder()
        colorDelegate?.updateColorViewer()
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
    
    func shouldInsert() -> Bool{
        let maxChars:Int = 2
        
        let text = target?.text ?? ""
        
        return text.count < maxChars
    }
}
