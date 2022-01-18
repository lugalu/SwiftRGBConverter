//
//  ColorView.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 13/11/21.
//

import Foundation
import UIKit

class ColorView: UIView{
    
    var path: UIBezierPath!
    var color: UIColor? = .label
    
    static func instantiate(points: [CGPoint]) -> ColorView{
        let view = ColorView(frame: CGRect(x: 200, y: 200, width: 100, height: 140))
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.createPath(shapePoints: points)
        //view.layer.compositingFilter = "normal"
        return view
    }
    
    
    override func draw(_ rect: CGRect) {
        self.color?.setFill()
        self.color?.setStroke()
        self.path.fill()
        self.path.stroke()
    }
    
    private func createPath(shapePoints: [CGPoint]){
        let trianglePath = UIBezierPath()
        trianglePath.lineJoinStyle = .round
        trianglePath.lineWidth = 2
        
                
        trianglePath.move(to: shapePoints[0])
        
        if shapePoints.count > 1{
            for point in shapePoints {
                trianglePath.addLine(to: point)
            }
        }
        trianglePath.close()
        self.path = trianglePath
    }
    

    func setNewColor(newColor: UIColor){
        self.color = newColor
        //self.backgroundColor = newColor
        self.setNeedsDisplay()
    }
}
