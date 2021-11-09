//
//  TextFieldhandler + CMYK .swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 16/08/21.
//

import UIKit

extension TextfieldHandler{
    
    @IBAction func didEndCmyk(_ sender: UITextField) {
        
        let cmkyVal = (c: cmky[0].text?.replacingOccurrences(of: ",", with: "."),
                       m: cmky[1].text?.replacingOccurrences(of: ",", with: "."),
                       k: cmky[2].text?.replacingOccurrences(of: ",", with: "."),
                       y: cmky[3].text?.replacingOccurrences(of: ",", with: "."))
        let cmkyAsNum = ColorConverter.stringToCMYK(strings: cmkyVal)
        
        let r1 = (1 - cmkyAsNum.c) * (1 - cmkyAsNum.k)
        let g1 = (1 - cmkyAsNum.m) * (1 - cmkyAsNum.k)
        let b1 = (1 - cmkyAsNum.y) * (1 - cmkyAsNum.k)
        
        let r255: Int = Int(r1 * 255.0)
        let g255: Int = Int(g1 * 255.0)
        let b255: Int = Int(b1 * 255.0)
        
        let rHex = ColorConverter.numberToHex(value: r255)
        let gHex = ColorConverter.numberToHex(value: g255)
        let bHex = ColorConverter.numberToHex(value: b255)
        
        assignR1(index: 0, value: r1)
        assignR1(index: 1, value: g1)
        assignR1(index: 2, value: b1)
        
        assignR255(index: 0, value: r255)
        assignR255(index: 1, value: g255)
        assignR255(index: 2, value: b255)
        
        assignHex(index: 0, value: rHex)
        assignHex(index: 1, value: gHex)
        assignHex(index: 2, value: bHex)
        assignHex(index: 3, value: "FF")
        
        assignCMYK(cmkyAsNum, true)
        
        colorDelegate?.updateColorViewer()
    }
        
    func assignCMYK(_ values: (c: Double, m: Double, y: Double, k: Double)){
        cmky[0].text = String(values.c)
        cmky[1].text = String(values.m)
        cmky[2].text = String(values.y)
        cmky[3].text = String(values.k)
    }
    
    func assignCMYK(_ values: (c: Double, m: Double, y: Double, k: Double), _: Bool ){
        cmky[0].text = String(format: "%.4f", values.c * 100.0)
        cmky[1].text = String(format: "%.4f", values.m * 100.0)
        cmky[2].text = String(format: "%.4f", values.y * 100.0)
        cmky[3].text = String(format: "%.4f", values.k * 100.0)
    }
}
