//
//  TestImageView.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 19/09/21.
//

import UIKit

class ImageView: UIImageView {
    var Color: UIColor!
    var ViewController: ColorPickerViewController!
    var colorUpdater: ColorUpdaterDelegate? = nil
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.image != nil, let touch = touches.first {
            let pos = touch.location(in: self)
            let viewControlerPos = touch.location(in: ViewController.view)
           
            let animatedView = UIView(frame: CGRect(x: viewControlerPos.x - 15, y: viewControlerPos.y - 15, width: 30, height: 30))
            animatedView.layer.cornerRadius = 15
            
            ViewController.view.addSubview(animatedView)
            let color = self.getPixelColor(atPosition: pos)

            Color = color
            animatedView.backgroundColor = color
            
            colorUpdater?.updateColorViewer(color: color)
            guard let firstTab = ViewController.tabBarController?.tabBar.items?[0].value(forKey: "view") as? UIView else { return }
        
            // 3. get the firstTab's rect inside the window
            let firstTabRectInWindow = firstTab.convert(firstTab.frame, to: ViewController.view.window)
            
            let points = calculateAngles(viewControlerPos: viewControlerPos, firstTabRectInWindow: firstTabRectInWindow, animatedView: animatedView)
            animation(view: animatedView, points: points)
        }
    }
       
    /**
     Animates the view that moves on click, passing through each pre-defined points
     - Parameters:
        - view: the view to recieve the animation
        - points: each point to move the view.
     */
    func animation(view: UIView, points: [CGPoint]){
        let time = 1.0/Double(points.count)
        
        UIView.animateKeyframes(withDuration: 1, delay: .zero, options: [], animations: {
            for i in 0...points.count-1 {
                UIView.addKeyframe(withRelativeStartTime: Double(i) * time , relativeDuration: 1.0 / Double(points.count-1), animations: {
                    view.layer.position = CGPoint(x: points[i].x, y: points[i].y)
                })
            }
        }){ _ in
            view.removeFromSuperview()
        }
    }
    
    /**
     gets the pixel color in a specific position from the view, instead of taking it from the picture
     - Parameters:
        - atPosition: the position of the pixel to be extracted.
     */
    func getPixelColor(atPosition:CGPoint) -> UIColor{

        var pixel:[CUnsignedChar] = [0, 0, 0, 0];
        let colorSpace = CGColorSpaceCreateDeviceRGB();
        let bitmapInfo = CGBitmapInfo(rawValue:    CGImageAlphaInfo.premultipliedLast.rawValue);
        let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue);

        context!.translateBy(x: -atPosition.x, y: -atPosition.y);
        layer.render(in: context!);
        let color:UIColor = UIColor(red: CGFloat(pixel[0])/255.0,
                                    green: CGFloat(pixel[1])/255.0,
                                    blue: CGFloat(pixel[2])/255.0,
                                    alpha: CGFloat(pixel[3])/255.0);

        return color;

    }
    
    func calculateAngles(viewControlerPos:CGPoint, firstTabRectInWindow:CGRect,animatedView:UIView) -> [CGPoint]{
        let tabX =  firstTabRectInWindow.origin.x + firstTabRectInWindow.width/2
        let pi = Double.pi
        
        var points: [CGPoint] = []

        let angleStep = pi / 2 / Double(5 + 1)
        var angle = angleStep

        let a:CGFloat = viewControlerPos.x - tabX
        let b =  viewControlerPos.y - firstTabRectInWindow.origin.y - 17


        while angle < pi/2 {
            let x1 = tabX + a * CGFloat(cos(angle))
            let y2 = viewControlerPos.y - b * CGFloat(sin(angle))
            points.append(CGPoint(x:x1, y: y2))
            angle += angleStep
        }
        

        return points
    }
}
