//
//  PostTableViewController.swift
//  TravelMe
//
//  Created by admin on 13/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Kingfisher

class PostTableViewController: UITableViewController {

    var data = [Post]()
    var favoriteData = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.refreshControl = UIRefreshControl()
         self.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        
        ModelEvents.postDataEvent.observ {
            self.refreshControl?.beginRefreshing()
            self.reloadData()               
        }
        
        ModelEvents.gpsUpdateEvent.observ { (postID) in
            Model.instance.modelSql.delete(postId: postID)
        }
        self.refreshControl?.beginRefreshing()
        reloadData()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//           reloadData()
//       }
    
    
    @objc func reloadData(){
        Model.instance.getAllPosts { (d_data:[Post]?) in
            if (d_data != nil){
                self.data = d_data!
                
                   for post in self.data {
                    if (Post.favoritePostSet.contains(post.postId!)){
                        post.postSelected = "true"
                    }else{
                        post.postSelected = "false"
                    }
                }
                let arr = Array(Post.favoritePostSet)
                for post in arr {
                    if(!Post.postSet.contains(post)){
                        Model.instance.deleteFavoritePostByID(postId: post)
                    }
                }
                self.tableView.reloadData()
            }
            self.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    var flag:Bool = false
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PostViewCell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostViewCell
        
        // Configure the cell...
          let post = data[indexPath.row]
        
      
        cell.titleLabel.text = post.title
        cell.placeLabel.text = post.place
        cell.avatar.image = UIImage(named: "avatar")
        if (post.avatar != ""){
            cell.avatar.kf.setImage(with: URL(string: post.avatar))
        }
        cell.strBtn.tag = indexPath.row
        cell.strBtn.addTarget(self, action: #selector(favoriteCliked(sender:)), for: .touchUpInside)
        if(post.postSelected == "true"){
            cell.strBtn.tintColor = .orange
        }else if(post.postSelected == "false"){
            cell.strBtn.tintColor = .lightGray
        }
            return cell
    }
    
    @objc func favoriteCliked(sender: UIButton){
        print("button presed")
        
        if sender.isSelected{
            sender.tintColor = .lightGray
            sender.isSelected = false
            flag = false
            Model.instance.deleteFavoritePost(post: data[sender.tag])
            print(sender.tag)
        }else{
            sender.tintColor = .orange
            sender.isSelected = true
            flag = true
            Model.instance.addFavoritePost(post: data[sender.tag])
           print(sender.tag)
        }
    }
    
    var selectedPost:Post?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.deselectRow(at: indexPath, animated: true)
        
        selectedPost = data[indexPath.row]
        performSegue(withIdentifier: "postInfoSegue", sender: self)
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }

    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "postInfoSegue"{
            let vc:PostInfoViewController = segue.destination as! PostInfoViewController
            vc.post = selectedPost
        }
    }
    
   
    
}
