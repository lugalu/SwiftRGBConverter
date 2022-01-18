//
//  ColorPickerViewController.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 19/08/21.
//

import UIKit
import AVFoundation
import PhotosUI

class ColorPickerViewController: UIViewController {
    //TODO: create my custom collectionview for the images.
    
    
    
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var galeryButton: UIButton!
    @IBOutlet weak var imageView: ImageView!
   
    var colorDelegate: ColorUpdaterDelegate? = nil
    var preview: UIImage? = nil
    var shouldSelectColor: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let vc = self.tabBarController?.viewControllers?.first as? ColorUpdaterDelegate else {
            fatalError("ooops")
        }
        
        colorDelegate = vc
        imageView.ViewController = self
        imageView.colorUpdater = colorDelegate
		imageView.layer.borderColor = UIColor.systemGreen.cgColor
		//imageView.contentMode = .scaleToFill
		imageView.layer.borderWidth = 5
    }
    
    
    @IBAction func onCameraTap() {
        guard handleCameraAuthorization() else { return }
        presentView()
    }
    
    func presentView(){
        guard let vc = storyboard?.instantiateViewController(identifier: "CameraVC") as? CameraViewController else{ return }
        vc.modalPresentationStyle = .fullScreen
        vc.previousView = self
        self.present(vc, animated: true, completion: nil)
    }
        
    
    func handleCameraAuthorization() -> Bool{
        var status:Bool = false
        
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .authorized:
            status = true
            
        case .restricted:
            openRestrictedAlert(title: "Camera Access")
            
        case .denied:
            openSettingsAlert(title: "Allow Access To Your Camera", message: "By allowing the camera you can take pictures and extract color data from them")
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video){ (granted: Bool) in
                if granted {
                    status = true
                }
            }
            
        @unknown default:
            break
        }
        
        return status
    }
    

    func updateImage(){
        if let currentImg = preview {
            imageView.image = currentImg
        }else{
            shouldSelectColor = false
        }
    }
    
    @IBAction func onGaleryTap() {
        switch PHPhotoLibrary.authorizationStatus(for: .readWrite){
        case .authorized:
            showPhotos()
        case .limited:
			showPhotos()
        case .denied:
            openSettingsAlert(title: "Allow Access To Your Photos", message: "By allowing us the acces you can use previously saved photos to extract color data.")
            
        case .restricted:
            openRestrictedAlert(title: "Photos Access")
            
        case .notDetermined:
			requestPhotoAccess()
			
        @unknown default:
            break
        }
    }
    
	func requestPhotoAccess(){
		PHPhotoLibrary.requestAuthorization(for: .readWrite){ [unowned self] (granted: PHAuthorizationStatus) in
			switch granted {
			case .restricted:
				openRestrictedAlert(title: "Photo Access")
			case .authorized:
				showPhotos()
			case .limited:
				showPhotos()
			case .notDetermined, .denied:
				break
			@unknown default:
				break
			}
			
		}
	}
	
	
   
    
    
    /**
        Asks the User what he wants to do when in limited access
     */
//    func showLimitedPhotos(){
//        let actionSheet = UIAlertController(title: "Limited access", message: "Select photo or change settings", preferredStyle: .actionSheet)
//
//        let selectPhoto = UIAlertAction(title: "Select Photo", style: .default){[unowned self] _ in
//            PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
//        }
//
//        let openSettings = UIAlertAction(title: "Change Settings", style: .default){ _ in
//            self.openAppSettings()
//        }
//
//        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//
//        actionSheet.addAction(selectPhoto)
//        actionSheet.addAction(openSettings)
//        actionSheet.addAction(cancel)
//
//        self.present(actionSheet, animated: true, completion: nil)
//    }
//
//
//
    
    
    /**
        Shows alert that tells the user due to restricted access it's impossible to complete the action. The message is a default for all the forbidden actions
     
        - Parameters:
         - title: String containing the tile of the alert
     */
    func openRestrictedAlert(title: String){
        let alert = UIAlertController(title: title, message: "Your status is restricted so this action is forbidden", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    /**
        Generates an alert that let the user decide to open or not the settings on the phone,
        the alert contains by default a cancel and open settings button.
     
        - Parameters:
         - title: the title of the alert
         - message: the body of the alert
     */
    func openSettingsAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let openSettings = UIAlertAction(title: "Open Settings", style: .default){ [unowned self] (_) in
            openAppSettings()
        }
        
        alert.addAction(cancel)
        alert.addAction(openSettings)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    /**
        Opens the System App settings.
     */
    func openAppSettings(){
        guard let appURL = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appURL) else{
            assertionFailure("Not able to open the app settings")
            return
        }
        
        UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
    }
    
}


extension ColorPickerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	func showPhotos(){
		let image = UIImagePickerController()
		
		image.delegate = self
		image.sourceType = .photoLibrary
		image.allowsEditing = false
		
		self.present(image, animated: true, completion: nil)
		
	}
	
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
		
		imageView.image = image
		
		picker.dismiss(animated: true, completion: nil)
	}
	
	
}
