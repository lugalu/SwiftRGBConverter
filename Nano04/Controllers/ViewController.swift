//
//  ViewController.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 13/08/21.
//

import UIKit

class ViewController: UIViewController, ColorUpdaterDelegate {
    
    var textfieldHandler = TextFieldHandler()
    @IBOutlet weak var colorViewer: ColorUpdater!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.subviews.forEach(){ subv in
            if let sub = subv as? TextFieldHandler{
                textfieldHandler = sub
                textfieldHandler.colorDelegate = self
                colorViewer.layer.cornerRadius = 20
                return
            }
        }
       
        
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
    
}




