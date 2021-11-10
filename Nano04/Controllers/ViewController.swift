//
//  ViewController.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 13/08/21.
//

import UIKit

class ViewController: UIViewController, ColorUpdaterDelegate {
    
    var textfieldHandler: TextfieldHandler!
    @IBOutlet weak var colorViewer: ColorUpdater!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        textfieldHandler = TextfieldHandler.instantiate()
        textfieldHandler.colorDelegate = self
        
        //textfieldHandler.backgroundColor = .red
       self.view.addSubview(textfieldHandler)
        //self.addChild(textfieldHandler)
        self.setupTextfieldConstraints()
        textfieldHandler.setupHexKeyboard()
    }
    

    
    func updateColorViewer(){
        colorViewer.updateColor(color:(r: textfieldHandler.rgb255[0].text,
                                       g: textfieldHandler.rgb255[1].text,
                                       b: textfieldHandler.rgb255[2].text,
                                       a: textfieldHandler.rgb255[3].text))
    }
    
    func updateColorViewer(color: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)) {
        colorViewer.updateColor(color:(r: color.r, g: color.g, b: color.b, a: color.a))
    }
    
    func updateColorViewer(color: UIColor) {
        colorViewer.updateColor(color: color)
    }
 
    func setupTextfieldConstraints(){
        textfieldHandler.translatesAutoresizingMaskIntoConstraints = false
        textfieldHandler.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100).isActive = true
        textfieldHandler.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor).isActive = true
        textfieldHandler.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        textfieldHandler.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        
    }
        
}







