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
    
    
    
    var selectedPost:Post?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
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
