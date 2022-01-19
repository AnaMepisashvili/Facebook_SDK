//
//  SettingsViewController.swift
//  Facebook_SDK
//
//  Created by Ana Mepisashvili on 13.01.22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var profileImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        //        UserDefaultsHelper.delegateToken()
        let sb = UIStoryboard(name: "login", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
//    func UserData() {
//        if let token = UserDefaultsHelper.getToken() {
//            let params = ["fields": "picture.type(large)"]
//            let graphRequest = GraphRequest(graphPath: "me",
//                                            parametres: params,
//                                            tokenString: token,
//                                            version: nil,
//                                            httpMethod: .get)
//            graphRequest.start { (connection, result, error) in
//                
//                if let err = error {
//                    print("error: \(err)")
//                } else {
//                    print("successful!")
//                    
//                    guard let json = result as? NSDictionary else { return }
//                    if let picture = json["picture"] as? NSDictionary,
//                        let data = picture["data"] as? NSDictionary,
//                        let url = data["url"] as? String {
//                        print("\(url)")
//                        let urlStr = URL(string: url)
//                        let data = try? Data(contentof: URL(string: "https://www.smartdatajob.com/images/joomlart/demo/default.jpg")!)
//                        self.profileImg.image = UIImage(data: (data ?? defaultData)!)
//                    }
//                    
//                }
//            }
//            
//        }
//    }
}

