//
//  ViewController.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 13/08/21.
//

import UIKit

class ViewController: UIViewController, ColorUpdaterDelegate {
    
    var textfieldHandler: TextfieldHandler!
    var mainColor: ColorView!
    var rightSide: [ColorView] = []
    var leftSide: [ColorView] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureViews()
    
        self.setupTextfieldConstraints()
        textfieldHandler.setupHexKeyboard()
        self.startColor()
    }
    
    
    func configureViews(){
        // -MARK: Textfield handler
        textfieldHandler = TextfieldHandler.instantiate()
        textfieldHandler.colorDelegate = self
        

        
        configureColorViews()

        // -MARK: Small detail
        let holder = UIView(frame: CGRect(x: self.view.frame.width/2, y: 300, width: 30, height: 30))
        holder.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        holder.layer.position = CGPoint(x: self.view.frame.width/2, y: 300)
        holder.layer.cornerRadius = 15
        holder.backgroundColor = .black
        
        self.view.addSubview(textfieldHandler)
        self.view.addSubview(mainColor)

        
        for Right in rightSide{
            self.view.addSubview(Right)
        }
        
        for Left in leftSide{
            self.view.addSubview(Left)
        }
        self.view.addSubview(holder)

    }
    
    
    func setupTextfieldConstraints(){
        textfieldHandler.translatesAutoresizingMaskIntoConstraints = false
        textfieldHandler.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100).isActive = true
        textfieldHandler.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor).isActive = true
        textfieldHandler.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        textfieldHandler.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    }
    

    func configureColorViews(){
        
        let points: [CGPoint] = [CGPoint(x: 10, y: 15),
                                CGPoint(x: 30, y: 7),
                                CGPoint(x: 50, y: 3),
                                CGPoint(x: 72, y: 7),
                                CGPoint(x: 90, y: 15),
                                CGPoint(x: 50, y: 135)]
        
        
        //-MARK: main side
        mainColor = ColorView.instantiate(points: points)
        
        mainColor.layer.anchorPoint = CGPoint(x: 0.5, y: 1)

        mainColor.layer.position = CGPoint(x: (self.view.frame.width/2), y: 300)
        
        
        //-MARK: Initialization of the shapes
        rightSide.append(ColorView.instantiate(points: points))
        
        rightSide.append(ColorView.instantiate(points: points))
        
        leftSide.append(ColorView.instantiate(points: points))
        
        leftSide.append(ColorView.instantiate(points: points))

        
        //-MARK: rightSide configuration

        rightSide[0].transform = rightSide[0].transform.rotated(by: .pi / 4.9)
        rightSide[0].layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        rightSide[0].layer.position = CGPoint(x: (self.view.frame.width/2)+1, y: 300)
        rightSide[0].setNewColor(newColor: .secondaryLabel)
        
        rightSide[1].transform = rightSide[1].transform.rotated(by: .pi/2.45)
        rightSide[1].layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        rightSide[1].layer.position = CGPoint(x: (self.view.frame.width/2)+1, y: 301)
        rightSide[1].setNewColor(newColor: .tertiaryLabel)
        
        
        //-MARK: left side configuration

        leftSide[0].transform = leftSide[0].transform.rotated(by: -( .pi / 4.9))
        leftSide[0].layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        leftSide[0].layer.position = CGPoint(x: (self.view.frame.width/2)-1, y: 300)
        leftSide[0].setNewColor(newColor: .quaternaryLabel)
        
        leftSide[1].transform = leftSide[1].transform.rotated(by: -( .pi / 2.45))
        leftSide[1].layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        leftSide[1].layer.position = CGPoint(x: (self.view.frame.width/2)-1, y: 301)
        leftSide[1].setNewColor(newColor: .quaternaryLabel)
    }
    
    
    /**
        This method is to conform with the ColorUpdaterDelegate, it updates the colors based on the current RGBA 1.0
     */
    func updateColorViewer(){
        let Red: Double = Double(textfieldHandler.rgb1[0].text ?? "") ?? 0
        let Green: Double = Double(textfieldHandler.rgb1[1].text ?? "") ?? 0
        let Blue: Double = Double(textfieldHandler.rgb1[2].text ?? "") ?? 0
        
        let (alpha, rightOne, rightTwo, leftOne, leftTwo) = ColorConverter.calculateAnalogous(red: Red, green: Green, blue: Blue)
        
        assingColors(main: (Red,Green,Blue,alpha),
                     rightOne: (rightOne.r, rightOne.g, rightOne.b, alpha),
                     rightTwo: (rightTwo.r, rightTwo.g, rightTwo.b, alpha),
                     leftOne: (leftOne.r, leftOne.g, leftOne.b, alpha),
                     leftTwo: (leftTwo.r, leftTwo.g, leftTwo.b, alpha))
        
    }
    
    func updateColorViewer(color: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)) {
     
    }
    
    func updateColorViewer(color: UIColor) {
    }
 
    func startColor() {
        mainColor.setNewColor(newColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1))
        rightSide[0].setNewColor(newColor: UIColor(red: 0.909, green: 0.81, blue: 0.86, alpha: 1))
        leftSide[0].setNewColor(newColor: UIColor(red: 0.909, green: 0.83, blue: 0.81, alpha: 1))
        rightSide[1].setNewColor(newColor: UIColor(red: 1, green: 0.90, blue: 1, alpha: 1))
        leftSide[1].setNewColor(newColor: UIColor(red: 1, green: 0.92, blue: 0.9, alpha: 1))
    }
    
    
    func assingColors(main:(r: Double, g: Double, b: Double, a: Double),
                      rightOne: (r: Double, g: Double, b: Double, a: Double),
                      rightTwo: (r: Double, g: Double, b: Double, a: Double),
                      leftOne: (r: Double, g: Double, b: Double, a: Double),
                      leftTwo: (r: Double, g: Double, b: Double, a: Double)){
        
        mainColor.setNewColor(newColor: UIColor(red: main.r, green: main.g, blue: main.b, alpha: main.a))
        
        rightSide[0].setNewColor(newColor: UIColor(red: rightOne.r, green: rightOne.g, blue: rightOne.b, alpha: rightOne.a))
        rightSide[1].setNewColor(newColor: UIColor(red: rightTwo.r, green: rightTwo.g, blue: rightTwo.b, alpha: rightTwo.a))
        
        leftSide[0].setNewColor(newColor: UIColor(red: leftOne.r, green: leftOne.g, blue: leftOne.b, alpha: leftOne.a))
        leftSide[1].setNewColor(newColor:UIColor(red: leftTwo.r, green: leftTwo.g, blue: leftTwo.b, alpha: leftTwo.a))
        
    }

        
}







