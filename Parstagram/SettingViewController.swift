//
//  SettingViewController.swift
//  Parstagram
//
//  Created by Joohak Lee on 11/28/21.
//

import UIKit
import AlamofireImage
import Parse

class SettingViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = PFUser.current()!
        if(user["image"] != nil){
            print("hello")
            let imageFile = user["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            imageView.af_setImage(withURL: url)
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onProfileImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func changeSetting(_ sender: Any) {
        let user = PFUser.current()!
        
        //post["author"] = PFUser.current()!
        //post["profileIMG"] = imageView!
        if(pwField.text != ""){
            user.password = pwField.text!
        }
//        if(nameField.text != ""){
//            user.username = nameField.text!
//        }
        if(emailField.text != ""){
            user.email = emailField.text!
        }
        
        user["profileName"] = nameField.text!
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        user["image"] = file
        user.saveInBackground{(success, error) in
            if success {
                print("user info changed")
            }
            else{
                print("error")
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onLogOut(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
    
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
                
        delegate.window?.rootViewController = loginViewController
    }
}
