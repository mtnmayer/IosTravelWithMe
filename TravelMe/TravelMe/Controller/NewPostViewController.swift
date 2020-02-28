//
//  NewPostViewController.swift
//  TravelMe
//
//  Created by admin on 13/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var chooseBtn: UIButton!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var titleTexField: UITextField!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        titleTexField.delegate = self
        placeTextField.delegate = self
        descriptionText.delegate = self
        
        activity.isHidden = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(WelcomeViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
           view.endEditing(true)
       }
    
   
    
//    func textFieldShouldReturn(_ textField: UITextField!)->Bool{
//        textField.resignFirstResponder()
//        return true
//    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    var selectedImage: UIImage?
    
    @IBAction func postBtn(_ sender: UIButton) {
        var post = Post(title: self.titleTexField.text!, place: self.placeTextField.text!, description: self.descriptionText.text!, avatar: "", email: Post.userEmail, postId: "", postSelected: "")
        activity.isHidden = false
        saveBtn.isEnabled = false
        chooseBtn.isEnabled = false
        
        if let selectedImage = selectedImage {
            Model.instance.saveImage(image: selectedImage) { (url) in
                post.avatar = url
                Model.instance.addPost(post: post)
                self.navigationController?.popViewController(animated: true)
            }
        }else{
            Model.instance.addPost(post: post)
            self.navigationController?.popViewController(animated: true)
            return
        }
    }
    
    
    
    
    
    
    @IBAction func photoBtn(_ sender: UIButton) {
        
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
    
    func configureTextView(){
        
        
       }
    
}

