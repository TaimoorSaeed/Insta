//
//  HomeViewController.swift
//  Insta
//
//  Created by Taimoor Saeed on 22/07/2017.
//  Copyright © 2017 Taimoor. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.90, green:0.45, blue:0.45, alpha:1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor(red:0.90, green:0.45, blue:0.45, alpha:1.0)]
  
        let ref = Database.database().reference()
        ref.child("posts/\(Auth.auth().currentUser!.uid)").observe(.childAdded, with: { (snapshot) in
            
            if let data = snapshot.value as? NSDictionary {
                let url = data["imageURL"] as! String
                let text = data["text"] as! String
                let post = Post(imageURL: url, text: text)
                self.posts.append(post)
                self.tableView.reloadData()
            }
        })
    }
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        if Auth.auth().currentUser != nil {
            do{
                try Auth.auth().signOut()
                print("logged out")
                let vc  = self.storyboard?.instantiateViewController(withIdentifier: "signIn")
//                self.present(vc!, animated: true, completion: nil)
                self.navigationController!.pushViewController(vc!, animated: true)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let post = self.posts[indexPath.row]
        
        cell.imageViewCell.sd_setShowActivityIndicatorView(true)
        cell.imageViewCell.sd_setIndicatorStyle(.gray)
        
        cell.captionLabel.text = post.text
        let url = URL(string: post.imageURL)
        cell.imageViewCell.sd_setImage(with: url)
        return cell
    }
    
}
