//
//  ChoosePhotoFromAlbumViewController.swift
//  Instagram_CodePath
//
//  Created by SiuChun Kung on 9/23/18.
//  Copyright © 2018 SiuChun Kung. All rights reserved.
//

import UIKit

class ChoosePhotoFromAlbumViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var selectedImage : UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = .photoLibrary
        present(vc, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        //        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        selectedImage = editedImage
        // Do something with the images (based on your use case)
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: { () -> Void in
            self.dismiss(animated: false, completion: nil)
            self.performSegue(withIdentifier: "toCaptionSegue", sender: self)
        })
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: { () -> Void in
            self.dismiss(animated: false, completion: nil)
            
            self.tabBarController?.selectedIndex = 0
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "toCaptionSegue" {
            let controller = segue.destination as! CaptureViewController
            let size = CGSize(width: 300.0, height: 300.0)
            controller.postImage = self.selectedImage?.af_imageAspectScaled(toFit: size)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
