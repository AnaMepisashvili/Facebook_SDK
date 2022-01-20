//
//  SettingsViewController.swift
//  Facebook_SDK
//
//  Created by Ana Mepisashvili on 13.01.22.
//

import UIKit
import FBSDKLoginKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var profileImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        
        ferchProfile()
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        let sb = UIStoryboard(name: "login", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func ferchProfile() {
        let token = AccessToken.current?.tokenString
            let params = ["fields": "picture.type(large)"]
            let graphRequest = GraphRequest(graphPath: "me",
                                            parameters: params,
                                            tokenString: token,
                                            version: nil,
                                            httpMethod: .get)
            graphRequest.start { (connection, result, error) in

            if let err = error {
                print("error: \(err)")
            } else {
                print("successful!")

                guard let json = result as? NSDictionary else { return }
                if let picture = json["picture"] as? NSDictionary,
                   let data = picture["data"] as? NSDictionary,
                   let url = data["url"] as? String {
                    print("\(url)")
                    let urlStr = URL(string: url)
                    let data = try? Data(contentsOf: URL(string: "https://scontent.ftbs5-2.fna.fbcdn.net/v/t39.30808-6/242393884_1665289276996536_179147493713356190_n.jpg?_nc_cat=103&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=AIY01Xtbw0EAX_wSGit&_nc_ht=scontent.ftbs5-2.fna&oh=00_AT-cqnxWWf5pf0lv61nuaNaE24SROLQAuU6TC_zUmwlHFQ&oe=61EEFA01")!)
                    self.profileImg.image = UIImage(data: (data ?? .init())!)
                }
            }
        }
    }
}

