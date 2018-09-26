//
//  ChoosePhotoFromAlbumViewController.swift
//  Instagram_CodePath
//
//  Created by SiuChun Kung on 9/23/18.
//  Copyright © 2018 SiuChun Kung. All rights reserved.
//

import UIKit
import Photos


class ChoosePhotoFromAlbumViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var selectedImage : UIImage?
    
    let vc = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPermission()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(vc, animated: true, completion: nil)
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
 @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        //        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        selectedImage = editedImage
        // Do something with the images (based on your use case)
        // Dismiss UIImagePickerController to go back to your original view controller
//        dismiss(animated: true, completion: { () -> Void in
            self.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "toCaptionSegue", sender: self)
//        })
    }
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: false, completion: { () -> Void in
            self.dismiss(animated: true, completion: nil)
            
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
