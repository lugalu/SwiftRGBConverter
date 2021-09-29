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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.image != nil, let touch = touches.first {
            let pos = touch.location(in: self)
            let animatedView = UIView(frame: CGRect(x: pos.x - 15, y: pos.y - 15, width: 30, height: 30))
            animatedView.layer.cornerRadius = 17
            
            self.addSubview(animatedView)
            let color = self.getPixelColor(atPosition: pos)

            Color = color
            animatedView.backgroundColor = color
            
            ViewController.mainView?.updateColorViewer(color: color)
            
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
}
