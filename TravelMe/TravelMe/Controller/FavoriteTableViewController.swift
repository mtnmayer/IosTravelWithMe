//
//  FavoriteTableViewController.swift
//  TravelMe
//
//  Created by admin on 26/02/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class FavoriteTableViewController: UITableViewController {

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
    
    override func viewDidAppear(_ animated: Bool) {
        reloadData()
    }
    
    @objc func reloadData(){
         
        Model.instance.getFavoritePosts { (d_data:[Post]?) in
             if (d_data != nil){
                 self.data = d_data!
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

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FavoriteViewCell = tableView.dequeueReusableCell(withIdentifier: "favoriteViewCell", for: indexPath) as! FavoriteViewCell

        // Configure the cell...
        let post = data[indexPath.row]
        cell.titleLabel.text = post.title
        cell.placeLabel.text = post.place
        cell.avatarImg.image = UIImage(named: "avatar")
        if(post.avatar != ""){
            cell.avatarImg.kf.setImage(with: URL(string: post.avatar))
        }
        
        return cell
    }
    

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
