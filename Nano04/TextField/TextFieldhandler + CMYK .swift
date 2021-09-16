//
//  TextFieldhandler + CMYK .swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 16/08/21.
//

import UIKit

extension TextFieldHandler{
    
    @IBAction func didEndCmyk(_ sender: UITextField) {
        
        
        
        let cmkyVal = (c: cmky[0].text?.replacingOccurrences(of: ",", with: "."),
                       m: cmky[1].text?.replacingOccurrences(of: ",", with: "."),
                       k: cmky[2].text?.replacingOccurrences(of: ",", with: "."),
                       y: cmky[3].text?.replacingOccurrences(of: ",", with: "."))
        let cmkyAsNum = stringToCmky(strings: cmkyVal)
        
        let r1 = (1 - cmkyAsNum.c) * (1 - cmkyAsNum.k)
        let g1 = (1 - cmkyAsNum.m) * (1 - cmkyAsNum.k)
        let b1 = (1 - cmkyAsNum.y) * (1 - cmkyAsNum.k)
        
        let r255: Int = Int(r1 * 255.0)
        let g255: Int = Int(g1 * 255.0)
        let b255: Int = Int(b1 * 255.0)
        
        let rHex = numberToHex(value: r255)
        let gHex = numberToHex(value: g255)
        let bHex = numberToHex(value: b255)
        
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
    
    func stringToCmky(strings: (c: String?, m: String?, k: String?, y: String?)) -> (c: Double, m: Double, y: Double, k: Double){
        let values = (c: (toDouble(strings.c ?? "0") / 100.0),
                      m: (toDouble(strings.m ?? "0") / 100.0),
                      y: (toDouble(strings.k ?? "0") / 100.0),
                      k: (toDouble(strings.y ?? "0") / 100.0))
        return values
    }
    
    func toDouble(_ convert: String) -> Double{
        return Double(convert) ?? 0.0
    }
    
    func rgb255ToCMKY(r: Int, g: Int, b: Int) -> (c:Double, m: Double, y: Double, k: Double){
        
        let r1 = rgb255to1(r)
        let g1 = rgb255to1(g)
        let b1 = rgb255to1(b)
        
        var black = 1.0 - max(r1, g1, b1)
       
        var cyan:Double
        var magenta:Double
        var yellow:Double
        
        cyan = 100 * ((1.0 - r1 - black) / (1.0 - black))
        magenta = 100 * ((1.0 - g1 - black) / (1.0 - black))
        yellow = 100 * ((1.0 - b1 - black) / (1.0 - black))
        
       
        black *= 100
        
        if r1 == 0 && g1 == 0 && b1 == 0 {
            cyan = 0
            magenta = 0
            yellow = 0
        }
        
        return (cyan, magenta, yellow, black)
        
    }
    
    func assignCMYK(_ values: (c: Double, m: Double, y: Double, k: Double)){
        cmky[0].text = String(values.c)
        cmky[1].text = String(values.m)
        cmky[2].text = String(values.y)
        cmky[3].text = String(values.k)
    }
    
    func assignCMYK(_ values: (c: Double, m: Double, y: Double, k: Double), _: Bool ){
        cmky[0].text = String(values.c * 100.0)
        cmky[1].text = String(values.m * 100.0)
        cmky[2].text = String(values.y * 100.0)
        cmky[3].text = String(values.k * 100.0)
    }
}
