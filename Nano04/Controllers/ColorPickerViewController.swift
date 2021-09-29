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
    @IBOutlet weak var imageView: ImageView!
    var mainView: ViewController? = nil
    var preview: UIImage? = nil
    var shouldSelectColor: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.viewControllers?.forEach(){ vc in
            if let main = vc as? ViewController{
                mainView = main
                return
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.ViewController = self
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
}


