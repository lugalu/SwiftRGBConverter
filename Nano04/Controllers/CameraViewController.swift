//
//  CameraViewController.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 19/08/21.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    @IBOutlet weak var photoBtn: UIButton!
    
    let captureSession = AVCaptureSession()
    var previewLayer:CALayer!
    
    var captureDevice:AVCaptureDevice!
    var tookPhoto = false
    var previousView: ColorPickerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSession()
    }
    
    func configureSession(){
        captureSession.beginConfiguration()
        captureSession.sessionPreset = .photo
        
        captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera,for: .video, position: .unspecified)
        
        guard let captureDeviceInput = try? AVCaptureDeviceInput(device: captureDevice),
              captureSession.canAddInput(captureDeviceInput)
        else { return }
        
        //Camera
        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer.frame = self.view.layer.frame
        self.view.layer.addSublayer(previewLayer)
        
        let output = AVCaptureVideoDataOutput()
        output.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String): NSNumber(value: kCVPixelFormatType_32BGRA)]
        output.alwaysDiscardsLateVideoFrames = true
        
        
        guard captureSession.canAddOutput(output) else{ return }
        
        let queue = DispatchQueue(label: "rgb.image.camera")
        output.setSampleBufferDelegate(self, queue: queue)
        
        captureSession.addInput(captureDeviceInput)
        captureSession.addOutput(output)
        captureSession.commitConfiguration()
        captureSession.startRunning()
        
    }
    
    func captureOutput (_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if tookPhoto {
            tookPhoto = false
            guard let image = getImageFromSamplerBuffer(buffer: sampleBuffer) else{
                print("image failed to be made")
                return
                
            }
            
            captureSession.stopRunning()
            DispatchQueue.main.async {
                self.previousView.preview = image
                self.dismiss(animated: true, completion: {self.previousView.updateImage()})
            }
           
            
        }
    }
    
    func getImageFromSamplerBuffer(buffer: CMSampleBuffer) -> UIImage?{
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) else{
            return nil
        }
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let context = CIContext()
        
        let imageRect = CGRect(x: 0, y: 0,
                               width: CVPixelBufferGetWidth(pixelBuffer),
                               height: CVPixelBufferGetHeight(pixelBuffer))
        
        guard let image = context.createCGImage(ciImage, from: imageRect) else{
            return nil
        }
        return UIImage(cgImage: image, scale: UIScreen.main.scale, orientation: .right)
    }
    
    @IBAction func takePhoto(){
        tookPhoto = true
    }

}
