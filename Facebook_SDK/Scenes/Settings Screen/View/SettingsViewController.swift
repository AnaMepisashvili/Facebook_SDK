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
    
    var settingsViewModel = SettingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImg.layer.cornerRadius = profileImg.bounds.width/2
        title = "Settings"
        
        addFBLoginButton()
        configureViewModel()
    }
    
    func configureViewModel() {
        settingsViewModel.fetrchProfile()
        settingsViewModel.image = { data in
            self.profileImg.image = UIImage(data: data)
        }
        settingsViewModel.fullName = { name in
            self.fullNameLabel.text = name
        }
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
    
}

