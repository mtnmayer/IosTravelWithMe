//
//  NewPostViewController.swift
//  Travel
//
//  Created by admin on 07/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
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
    }
    
    func textFieldShouldReturn(_ textField: UITextField!)->Bool{
        textField.resignFirstResponder()
        return true
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
    
    @IBAction func postBtn(_ sender: UIButton) {
        if let selectedImage = selectedImage{
            Model.instance.saveImage(image: selectedImage) { (url) in
                let post = Post(title: self.titleTexField.text!, place: self.placeTextField.text!, description: self.descriptionText.text!, avatar: url)
                Model.instance.addPost(post: post)
                self.navigationController?.popViewController(animated: true)
            }
            
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
    
}
