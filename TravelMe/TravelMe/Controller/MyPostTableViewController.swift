//
//  MyPostTableViewController.swift
//  TravelMe
//
//  Created by Studio on 15/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class MyPostTableViewController: UITableViewController , myPostCellDelegate{
    
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
        
        // Configure the cell...
        
        let post = data[indexPath.row]
        cell.titleLabel.text = post.title
        cell.placeLabel.text = post.place
        cell.avatarImg.image = UIImage(named: "avatar")
        if (post.avatar != ""){
            cell.avatarImg.kf.setImage(with: URL(string: post.avatar))
        }
        
        cell.delegate = self
        cell.index = indexPath
        //cell.editBtn.tag = indexPath.row
        
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
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToEditSegue"{
            let vc:EditMyPostViewController = segue.destination as! EditMyPostViewController 
            vc.post = selectedPost
        }
    }
    
    
    
}
