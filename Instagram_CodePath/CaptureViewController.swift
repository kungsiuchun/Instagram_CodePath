//
//  CaptureViewController.swift
//  Instagram_CodePath
//
//  Created by SiuChun Kung on 9/19/18.
//  Copyright © 2018 SiuChun Kung. All rights reserved.
//

import UIKit
import Parse

class CaptureViewController: UIViewController{

    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var imageToPost: UIImageView!
    var postImage: UIImage?
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageToPost.image = postImage
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(upload))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postImage(_ sender: Any) {
        Post.postUserImage(image: postImage,
                           withCaption: message.text,
                           withCompletion: { (success: Bool, error: Error?) -> Void in
                            DispatchQueue.main.async {
                                self.imageToPost.image = nil
                                self.message.text = nil
                            }}
        )
        self.performSegue(withIdentifier: "toHomeSegue", sender: self)
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
