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
            //print("firstTabRectInWindow: \(firstTabRectInWindow)")
            
            let points = calculateAngles(viewControlerPos: viewControlerPos, firstTabRectInWindow: firstTabRectInWindow, animatedView: animatedView)
            for point in points{
                UIView.animate(withDuration: 1.0, animations: {
    //              animatedView.frame = CGRect(x: (firstTabRectInWindow.origin.x + firstTabRectInWindow.width / 2) - 17 , y: firstTabRectInWindow.origin.y , width: 30, height: 30)
                    
                    animatedView.frame = CGRect(x: point.x, y: point.y, width: 30, height: 30)
                   
                }){_ in
                   animatedView.removeFromSuperview()
                }
            }
        }
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
        let tabX =  firstTabRectInWindow.origin.x + firstTabRectInWindow.width/2 - 17
    
        let a:CGFloat = viewControlerPos.x - tabX
        let b =  viewControlerPos.y - firstTabRectInWindow.origin.y
        let pi = Double.pi
        
        let angleStep = pi/2 / Double(5 + 1)
        var angle = angleStep
        var points: [CGPoint] = []
        
        while angle < pi/2 {
            let x = tabX + a * CGFloat(cos(angle))
            let y = viewControlerPos.y - b * CGFloat(sin(angle))
            points.append(CGPoint(x:x, y: y))
            angle += angleStep
        }
        
        return points
    }
}
