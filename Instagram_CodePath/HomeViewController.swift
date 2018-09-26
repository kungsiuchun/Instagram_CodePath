//
//  HomeViewController.swift
//  Instagram_CodePath
//
//  Created by SiuChun Kung on 9/19/18.
//  Copyright © 2018 SiuChun Kung. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var posts: [PFObject] = []
    var raw_posts: [PFObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Home Feed"
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        self.collectionView.insertSubview(refreshControl, at: 0)
//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
//        let cellsPerLine:CGFloat = 1
//        let widthOfEachItem = self.view.frame.size.width / cellsPerLine
//        layout.itemSize = CGSize(width: widthOfEachItem, height: widthOfEachItem * 1.75)
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        getData(completion: {(success: Bool, error: Error?) -> Void in
            
            if success {
                print ("successfully received data")
                
                // Tell the refreshControl to stop spinning
                refreshControl.endRefreshing()
            } else {
                print (error?.localizedDescription ?? "no error")
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            getData(completion: {(success: Bool, error: Error?) -> Void in
                if success {
                    print ("successfully received data")
                } else {
                    print (error?.localizedDescription ?? "no error")
                }
            })
        }
    
    func getData(completion: @escaping (_ success: Bool, _ error: Error?) -> Void) -> Void {
            let query = PFQuery(className: "Post")
            query.order(byDescending: "createdAt")
            query.includeKey("author")
            query.limit = 20
            
            // fetch data asynchronously
            query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
                if let posts = posts {
                    print("Posts are: ", posts)
                    // do something with the data fetched
                    self.raw_posts = posts
                    completion(true, nil)
                    
                } else {
                    print("Error! : ", error?.localizedDescription ?? "No localized description for error")
                    // handle error
                    completion(false, error)
                }
                self.collectionView.reloadData()
            }
        }
    
    @IBAction func logoutButton(_ sender: Any) {
        self.performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    
    
    @IBAction func captureButton(_ sender: Any) {
        self.performSegue(withIdentifier: "captureSegue", sender: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.raw_posts.count != 0 {
            return self.raw_posts.count
        } else {
            print ("came here")
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
        
        cell.post = self.raw_posts[indexPath.row]
        return cell
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
