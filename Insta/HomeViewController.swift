//
//  HomeViewController.swift
//  Insta
//
//  Created by Taimoor Saeed on 22/07/2017.
//  Copyright © 2017 Taimoor. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                self.present(vc!, animated: true, completion: nil)
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
        cell.captionLabel.text = post.text
        let url = URL(string: post.imageURL)
        let data = try? Data(contentsOf: url!)
        cell.imageViewCell?.image = UIImage(data: data!)
        
        return cell
    }
    
}
