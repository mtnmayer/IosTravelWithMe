//
//  EditMyPostViewController.swift
//  TravelMe
//
//  Created by admin on 16/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class EditMyPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var decriptionTextField: UITextField!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    @IBOutlet weak var chooseBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    var post:Post?
    var postId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        titleTextField.text = post?.title
        placeTextField.text = post?.place
        decriptionTextField.text = post?.description
        avatarImg.image = UIImage(named: "avatar")
        if(post?.avatar != ""){
            avatarImg.kf.setImage(with: URL(string: post!.avatar))
        }
        
        postId = post!.postId!
        
        activity.isHidden = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(WelcomeViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    var selectedImage: UIImage?
    
    @IBAction func choosePicBtn(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.avatarImg.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBtn(_ sender: UIButton) {
        
        var post = Post(title: self.titleTextField.text!, place: self.placeTextField.text!, description: self.decriptionTextField.text!, avatar: "", email: Post.userEmail)
             activity.isHidden = false
             saveBtn.isEnabled = false
             chooseBtn.isEnabled = false
             
             
        Model.instance.saveImage(image:  self.avatarImg.image!) { (url) in
                     post.avatar = url
                    Model.instance.updateMyPost(postId: self.postId, post: post)
                     self.navigationController?.popViewController(animated: true)
        }
//             }else{
//                Model.instance.updateMyPost(postId: postId, post: post)
//                 self.navigationController?.popViewController(animated: true)
//                 return
//             }
        
    }
    
}
