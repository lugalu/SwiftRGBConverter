//
//  ColorPickerViewController.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 19/08/21.
//

import UIKit
import AVFoundation

class ColorPickerViewController: UIViewController {

    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var galeryButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    private var mainView: ViewController? = nil
    var preview: UIImage? = nil
    var shouldSelectColor: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.viewControllers?.forEach(){ vc in
            if let main = vc as? ViewController{
                main.updateColorViewer(color: (r: 0.0, g: 1.0, b: 0.0, a: 1.0))
                mainView = main
                return
            }
        }
    }
    
    @IBAction func onCameraTap() {
        guard askCameraAuthorization() else { return }
        presentView()
    }
    
    func askCameraAuthorization() -> Bool{
        var status:Bool = false
        if AVCaptureDevice.authorizationStatus(for: .video) ==  AVAuthorizationStatus.authorized {
            return true
        } else {
           AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
               if granted == true {
                  status = true
               } else {
                   status = false
               }
           })
        }
        return status
    }
    
    func presentView(){
        guard let vc = storyboard?.instantiateViewController(identifier: "CameraVC") as? CameraViewController else{ return }
        vc.modalPresentationStyle = .fullScreen
        vc.previousView = self
        self.present(vc, animated: true, completion: nil)
    }
        
    func updateImage(){
        if let currentImg = preview {
            imageView.image = currentImg
        }else{
            shouldSelectColor = false
        }
        
    }
    
    @IBAction func onGaleryTap() {
        
    }
    
    @IBAction func tap(_ recognizer: UITapGestureRecognizer){
        if let img = imageView.image {
            guard let pos = convertTapToPos(recognizer.location(in: imageView)) else{ return }
            guard let colorData = getPixelColor(pos: CGPoint(x: pos.x, y: pos.y)) else{ return }
            let testView = UIView(frame: CGRect(x: pos.x, y: pos.y, width: 50, height: 50))
            testView.backgroundColor = .black
            imageView.addSubview(testView)
            var r: CGFloat = 0.0
            var g: CGFloat = 0.0
            var b: CGFloat = 0.0
            var a: CGFloat = 0.0
            
           let colors = colorData.getRed(&r, green: &g, blue: &b, alpha: &a)
            print(r, g, b, a)
            if colors {
                mainView?.updateColorViewer(color: (r: r, g: g, b: b, a: a))
            }else{
                return
            }
            
        }
        
    }
    
    func convertTapToPos(_ pos: CGPoint) -> CGPoint?{
        var newPos = pos
        guard let imgSizeX = imageView.image?.size.width else{ return nil }
        guard let imgSizeY = imageView.image?.size.height else{ return nil }

        let xRatio = imageView.frame.width / imgSizeX
        let yRatio = imageView.frame.height / imgSizeY
        let ratio = min(xRatio, yRatio)

        let imgWidth = imgSizeX * ratio
        let imgHeight = imgSizeY * ratio
        
        var borderWidth: CGFloat = 0.0
        var borderHeight: CGFloat = 0.0

        if ratio == yRatio {
            borderWidth = (imageView.frame.size.width - imgWidth) / 2

            if newPos.x < borderWidth || newPos.x > borderWidth + imgWidth {
                return nil
            }
            newPos.x -= borderWidth
        }else{
            borderHeight = (imageView.frame.size.height - imgHeight) / 2

            if newPos.y < borderHeight || newPos.y > borderHeight + imgHeight {
                return nil
            }

            newPos.y -= borderHeight
        }

        
        let xScale = newPos.x / (imageView.frame.width - 2 * borderWidth)
        let yScale = newPos.y / (imageView.frame.height - 2 * borderHeight)
      
        
        let pixelX = imgSizeX * xScale
        let pixelY = imgSizeY * yScale
        
        
        return CGPoint(x: pixelX, y: pixelY)
        
    }
    
    func getPixelColor(pos: CGPoint) -> UIColor?{

//        guard let pixelData = imageView.image!.cgImage!.dataProvider!.data
//        else{
//            print("error pixelData")
//            return nil
//        }
//          let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
//        assert(imageView.image!.cgImage?.colorSpace?.model == .rgb)
//        let pixelInfo: Int = ((Int(imageView.frame.size.width) * Int(pos.y)) + Int(pos.x)) * 4
//
//          let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
//          let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
//          let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
//          let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
//
//        print(data[pixelInfo])
//        print(data[pixelInfo + 1])
//        print(data[pixelInfo + 2])
//        print(data[pixelInfo + 3])
        
        guard let cgImage = imageView.image?.cgImage,
            let data = cgImage.dataProvider?.data,
            let bytes = CFDataGetBytePtr(data) else {
            fatalError("Couldn't access image data")
        }
        assert(cgImage.colorSpace?.model == .rgb)

        var r:CGFloat = 0.0
        var g:CGFloat = 0.0
        var b:CGFloat = 0.0
        var a:CGFloat = 1.0
        
        let bytesPerPixel = cgImage.bitsPerPixel / cgImage.bitsPerComponent
        let x = Int(pos.x)
        let y = Int(pos.y)
        let offset = (y * cgImage.bytesPerRow) + (x * bytesPerPixel)
                let components = (r: bytes[offset], g: bytes[offset + 1], b: bytes[offset + 2])
                print(components)
                r = CGFloat(components.r) / 255.0
                g = CGFloat(components.g) / 255.0
                b = CGFloat(components.b) / 255.0
                a = 1.0
        
          return UIColor(red: r, green: g, blue: b, alpha: a)
      }
    
}

