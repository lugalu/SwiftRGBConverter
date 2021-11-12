//
//  UIViewExtensions.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 10/11/21.
//

import UIKit

extension UIView{
    class func initFromNib<T: UIView>() -> T{
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.first as! T
    }
}
