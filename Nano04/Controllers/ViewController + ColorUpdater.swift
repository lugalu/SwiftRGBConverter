//
//  ViewController + ColorUpdater.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 24/11/21.
//

import UIKit

extension ViewController: ColorUpdaterDelegate{
    
    
    /**
        Sets the default color when starting the app.
     */
   func startColor() {
       mainColor.setNewColor(newColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1))
       rightSide[0].setNewColor(newColor: UIColor(red: 0.909, green: 0.81, blue: 0.86, alpha: 1))
       leftSide[0].setNewColor(newColor: UIColor(red: 0.909, green: 0.83, blue: 0.81, alpha: 1))
       rightSide[1].setNewColor(newColor: UIColor(red: 1, green: 0.90, blue: 1, alpha: 1))
       leftSide[1].setNewColor(newColor: UIColor(red: 1, green: 0.92, blue: 0.9, alpha: 1))
   }
    
    /**
        This method updates the colors based on the current RGBA 1.0
     */
    func updateColorViewer(){
        let Red: Double = ColorConverter.rgb255to1(Int(textfieldHandler.rgb255[0].text ?? "0") ?? 0)
        let Green: Double = ColorConverter.rgb255to1(Int(textfieldHandler.rgb255[1].text ?? "0") ?? 0)
        let Blue: Double = ColorConverter.rgb255to1(Int(textfieldHandler.rgb255[2].text ?? "0") ?? 0)
        let Alpha: Double = ColorConverter.rgb255to1(Int(textfieldHandler.rgb255[3].text ?? "0") ?? 0)
        
        let (_, rightOne, rightTwo, leftOne, leftTwo) = ColorConverter.calculateAnalogous(red: Red, green: Green, blue: Blue)
        
        assingColors(main: (Red,Green,Blue,Alpha),
                     rightOne: (rightOne.r, rightOne.g, rightOne.b, Alpha),
                     rightTwo: (rightTwo.r, rightTwo.g, rightTwo.b, Alpha),
                     leftOne: (leftOne.r, leftOne.g, leftOne.b, Alpha),
                     leftTwo: (leftTwo.r, leftTwo.g, leftTwo.b, Alpha))
        
    }
    
    
    /**
        This method updates the color based on the color tuple
        - Parameters:
         - color: the tuple
         - r: red channel as CGFloat must be between 0 and 1.0
         - g: green channel as CGFloat must be between 0 and 1.0
         - b: blue channel as CGFloat must be between 0 and 1.0
     */
    func updateColorViewer(color: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)) {
        let (_, rightOne, rightTwo, leftOne, leftTwo) = ColorConverter.calculateAnalogous(red: color.r, green: color.g, blue: color.b)
        
        assingColors(main: (color.r,color.g,color.b,color.a),
                     rightOne: (rightOne.r, rightOne.g, rightOne.b, color.a),
                     rightTwo: (rightTwo.r, rightTwo.g, rightTwo.b, color.a),
                     leftOne: (leftOne.r, leftOne.g, leftOne.b, color.a),
                     leftTwo: (leftTwo.r, leftTwo.g, leftTwo.b, color.a))
		
		assignToTextfield(r: color.r, g: color.g, b: color.b, a: color.a)
    }
    
    /**
        This method updates the color based on the supplied UIColor
        - Parameters:
         - color: UIColor that represents the new color it doesnt contain CIColor so need to utilize the cgColor
     */
    func updateColorViewer(color: UIColor) {
        let r = color.cgColor.components?[0] ?? 0
        let g = color.cgColor.components?[1] ?? 0
        let b = color.cgColor.components?[2] ?? 0
        let a = color.cgColor.components?[3] ?? 0
        
        let (_, rightOne, rightTwo, leftOne, leftTwo) = ColorConverter.calculateAnalogous(red: r, green: g, blue: b)
        
        assingColors(main: (r, g, b, a),
                     rightOne: (rightOne.r, rightOne.g, rightOne.b, a),
                     rightTwo: (rightTwo.r, rightTwo.g, rightTwo.b, a),
                     leftOne: (leftOne.r, leftOne.g, leftOne.b, a),
                     leftTwo: (leftTwo.r, leftTwo.g, leftTwo.b, a))
		
		assignToTextfield(r: r, g: g, b: b, a: a)
    }
    
	
	private func assignToTextfield(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat ){
		textfieldHandler.assignR1(index: 0, value: r)
		textfieldHandler.assignR1(index: 1, value: g)
		textfieldHandler.assignR1(index: 2, value: b)
		textfieldHandler.assignR1(index: 3, value: a)
		
		let r255 = ColorConverter.rgb1to255(r)
		let g255 = ColorConverter.rgb1to255(g)
		let b255 = ColorConverter.rgb1to255(b)
		let a255 = ColorConverter.rgb1to255(a)
		
		let cmyk = ColorConverter.rgb255ToCMYK(r: r255, g: g255, b: b255)
		
		textfieldHandler.assignR255(index: 0, value: r255)
		textfieldHandler.assignR255(index: 1, value: g255)
		textfieldHandler.assignR255(index: 2, value: b255)
		textfieldHandler.assignR255(index: 3, value: a255)
		
		textfieldHandler.assignHex(index: 0, value: ColorConverter.numberToHex(value: r255))
		textfieldHandler.assignHex(index: 1, value: ColorConverter.numberToHex(value: g255))
		textfieldHandler.assignHex(index: 2, value: ColorConverter.numberToHex(value: b255))
		textfieldHandler.assignHex(index: 3, value: ColorConverter.numberToHex(value: a255))
		
		textfieldHandler.assignCMYK(cmyk)
	}
}
