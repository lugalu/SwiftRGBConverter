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
            //animatedView.frame = CGRect(x: points[1].x, y: points[1].y, width: 30, height: 30)
            animation(currentIndex: 0, maxIndex: points.count, view: animatedView, points: points)
            
//            UIView.animate(withDuration: 0.5, delay: .zero, options: .curveLinear ,animations: {
//
//
//                animatedView.frame = CGRect(x: points[1].x, y: points[1].y, width: 30, height: 30)
//
//
//            }){ _ in
//
//                UIView.animate(withDuration: 0.5, animations: {
//                    animatedView.frame = CGRect(x: points[2].x, y: points[2].y, width: 30, height: 30)
//                }){ _ in
//                    animatedView.removeFromSuperview()
//                }
//
//            }
        }
    }
       
    
    func animation(currentIndex i: Int, maxIndex: Int, view: UIView, points: [CGPoint]){
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
        
//        UIView.animate(withDuration: 0.03, delay: .zero, options: .beginFromCurrentState, animations: {
//            view.frame = CGRect(x: points[i].x, y: points[i].y, width: 30, height: 30)
//        }){ _ in
//            self.animation(currentIndex: i + 1, maxIndex: maxIndex, view: view, points: points)
//        }
//
    }
    
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

        let angleStep = pi/2 / Double(5 + 1)
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
