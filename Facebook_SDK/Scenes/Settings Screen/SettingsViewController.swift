//
//  SettingsViewController.swift
//  Facebook_SDK
//
//  Created by Ana Mepisashvili on 13.01.22.
//

import UIKit
import FBSDKLoginKit

class SettingsViewController: UIViewController, LoginButtonDelegate {
    
    private let fbLoginButton: FBLoginButton = FBLoginButton()
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImg.layer.cornerRadius = profileImg.bounds.width/2
        title = "Settings"
        
        fetrchProfile()
        addFBLoginButton()
    
    }
    
    private func addFBLoginButton() {
        fbLoginButton.delegate = self
        fbLoginButton.center = view.center
        fbLoginButton.permissions = ["public_profile", "email"]

        view.addSubview(fbLoginButton)
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        //  void
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        fbLoginButton.removeFromSuperview()
        let sb = UIStoryboard(name: "LogInViewController", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LogInViewController")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func fetrchProfile() {
            let params = ["fields": "name, picture.type(large)"]
            let graphRequest = GraphRequest(graphPath: "me",
                                            parameters: params,
                                            tokenString: Constants.FBToken,
                                            version: nil,
                                            httpMethod: .get)
            graphRequest.start { (connection, result, error) in

                guard let json = result as? NSDictionary else { return }
                if let picture = json["picture"] as? NSDictionary,
                   let data = picture["data"] as? NSDictionary,
                   let url = data["url"] as? String {
                    print("\(url)")
                    let urlStr = URL(string: url)
                    let imageData = try? Data(contentsOf: urlStr as! URL)
                    self.profileImg.image = UIImage(data: imageData!)
                }
                if let fullName = json["name"] {
                    self.fullNameLabel.text = fullName as! String
                }
            }
        }
    }

