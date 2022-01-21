//
//  SettingsViewController.swift
//  Facebook_SDK
//
//  Created by Ana Mepisashvili on 13.01.22.
//

import UIKit
import FBSDKLoginKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImg.layer.cornerRadius = profileImg.bounds.width/2
        title = "Settings"
        
        fetrchProfile()
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        let sb = UIStoryboard(name: "login", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func fetrchProfile() {
        let token = "EAAHLlZCGjQWYBAHa2U8utqsUMgr8CWLQK2zgHYaKxmKFPr7VnGcPI4l1DQK2o9iGwZBokpNJvtDb79k3wKDxZBYfuG81PdIsR2sbFAyNZCMgyOctqtLxzMEST2pDmBMAfYSa4T7UfZCGDYfZC6G04cYzet9wUbAleFTO7QbZBCzZBJTsZBffLCkJmvM1jj0HitZAlXGFMDc2MTia49cgCXdF3F"
            let params = ["fields": "name, picture.type(large)"]
            let graphRequest = GraphRequest(graphPath: "me",
                                            parameters: params,
                                            tokenString: token,
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

