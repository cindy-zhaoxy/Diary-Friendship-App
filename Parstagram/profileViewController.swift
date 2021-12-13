//
//  profileViewController.swift
//  Parstagram
//
//  Created by Joohak Lee on 11/28/21.
//

import UIKit
import AlamofireImage
import Parse

class profileViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = PFUser.current()!
        if(user["image"] != nil){
            let imageFile = user["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            imageView.af_setImage(withURL: url)
        }
//        if(user["profileName"] != nil){
//            profileName = user["profileName"] as! UILabel
//        }
    }
    


    @IBAction func onLogOut(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
    
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
                
        delegate.window?.rootViewController = loginViewController
    }
    
}
