//
//  CameraViewController.swift
//  Parstagram
//
//  Created by Cindy Zhao on 10/13/21.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    //@IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var postTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postTextField.delegate = self
        postTextField.text = "What's on your mind?"
        postTextField.textColor = UIColor.lightGray
    }

    @IBAction func onSubmitButton(_ sender: Any) {
        let post = PFObject(className: "Posts")
        
        post["caption"] = postTextField.text!
        post["author"] = PFUser.current()!
        
        
        /* let imageData = imageView.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        post["image"] = file
         */
        
        post.saveInBackground { success, error in
            if success {
                //self.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
                print("saved!")
            } else {
                print("error!")
            }
        }
    }
    
    func textViewDidBeginEditing(_ postTextField: UITextView) {
        if postTextField.textColor == UIColor.lightGray {
            postTextField.text = nil
            postTextField.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ postTextField: UITextView) {
        if postTextField.text.isEmpty {
            postTextField.text = "What's on your mind?"
            postTextField.textColor = UIColor.lightGray
        }
    }
/* @IBAction func onCameraButton(_ sender: Any) {
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
*/
    

}
