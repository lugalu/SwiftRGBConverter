//
//  GalleryViewController.swift
//  Nano04
//
//  Created by Luiz José de Araújo Filho on 29/11/21.
//

import UIKit

class GalleryViewController: UIViewController, UINavigationBarDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedImage:UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
		
		//NavBar
        let height: CGFloat = 75
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height))
        //navbar.backgroundColor = UIColor.white
        navbar.delegate = self

        let navItem = UINavigationItem()
        navItem.title = "Select Photo"

        navItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction(_:)))

        navbar.items = [navItem]

        view.addSubview(navbar)

        //UIImagePicker
       
    }

    @objc func cancelAction(_ sender: UIBarButtonItem){
        self.dismiss(animated: true, completion: nil)
    }
}



extension GalleryViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

extension GalleryViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        
        return cell
    }
    
	
	
    
}
