//
//  ColorUpdaterDelegate.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 19/08/21.
//

import UIKit

protocol ColorUpdaterDelegate {
    func updateColorViewer()
    func updateColorViewer(color: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat))
}
