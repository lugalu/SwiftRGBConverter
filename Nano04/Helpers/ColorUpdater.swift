//
//  ColorUpdater.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 19/08/21.
//

import UIKit



class ColorUpdater: UIView{
    
    
    func updateColor(color: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)){
        self.backgroundColor = UIColor(red: color.r, green: color.g, blue: color.b, alpha: color.a)
    }
    
    func updateColor(color: (r:String?,g: String?, b: String?, a: String?)) {
        self.backgroundColor = UIColor(red: textToCG(color.r),
                                       green: textToCG(color.g),
                                       blue: textToCG(color.b),
                                       alpha: textToCG(color.a))
    }
    
    func updateColor(color: UIColor){
        self.backgroundColor = color
    }
    
    private func textToCG(_ value: String?) -> CGFloat{
        return CGFloat(Float(Int(value ?? "0") ?? 0) / 255)
    }
}
