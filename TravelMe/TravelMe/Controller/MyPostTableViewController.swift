//
//  MyPostTableViewController.swift
//  TravelMe
//
//  Created by Studio on 15/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import SwipeCellKit

class MyPostTableViewController: UITableViewController {
    
    var data = [Post]()
    var postID:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        
        ModelEvents.postDataEvent.observ {
            self.reloadData()
        }
        self.refreshControl?.beginRefreshing()
        reloadData()
    }
    
    
    @objc func reloadData(){
        
        Model.instance.getMyPosts { (d_data:[Post]?) in
            if (d_data != nil){
                self.data = d_data!
                self.tableView.reloadData()
            }
            self.refreshControl?.endRefreshing()
        }
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        //        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
    //        //      super.viewWillAppear(animated)
    //
    //        // Add a background view to the table view
    //        let backgroundImage = UIImage(named: "background2")
    //        let imageView = UIImageView(image: backgroundImage)
    //        self.tableView.backgroundView = imageView
    //
    //        tableView.tableFooterView = UIView(frame: CGRect.zero)
    //        imageView.contentMode = .scaleAspectFill
    //        tableView.backgroundColor = .lightGray
    //    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MyPostViewCell = tableView.dequeueReusableCell(withIdentifier: "myPostCell", for: indexPath) as! MyPostViewCell
        cell.delegate = self
        // Configure the cell...
        
        let post = data[indexPath.row]
        cell.titleLabel.text = post.title
        cell.placeLabel.text = post.place
        cell.avatarImg.image = UIImage(named: "avatar")
        if (post.avatar != ""){
            cell.avatarImg.kf.setImage(with: URL(string: post.avatar))
        }
        
//        cell.delegate = self
//        cell.index = indexPath
        
        return cell
    }
    
    var selectedPost:Post?
    
    func editPost(index: Int) {
        selectedPost = data[index]
        performSegue(withIdentifier: "goToEditSegue", sender: self)
    }
    
    func deletePost(index: Int) {
        Model.instance.deleteMyPost(postID: data[index].postId!)
        reloadData()
    }
    
    //    var selectedPost:Post?
    //
    //       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //             tableView.deselectRow(at: indexPath, animated: true)
    //
    //           selectedPost = data[indexPath.row]
    //
    //           performSegue(withIdentifier: "postInfoSegue", sender: self)
    //
    //       }
    //
    //       override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //           cell.backgroundColor = .clear
    //       }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToEditSegue"{
            let vc:EditMyPostViewController = segue.destination as! EditMyPostViewController 
            vc.post = selectedPost
        }
    }
}

extension MyPostTableViewController : SwipeTableViewCellDelegate{
  
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion

            self.deletePost(index: indexPath.row)

        }
        
        let editAction = SwipeAction(style: .destructive, title: "Edit") { action, indexPath in
                   // handle action by updating model with deletion

                   self.editPost(index: indexPath.row)

               }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        deleteAction.backgroundColor = UIColor.red
        editAction.image = UIImage(named: "edit-icon")
        editAction.backgroundColor = UIColor.blue
        return [deleteAction,editAction]
    }
    
    func updateAction(at indexPath: IndexPath) {
        // Update our data model.
        
        print("Item deleted from superclass")
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           cell.backgroundColor = .clear
       }
    
    
}
