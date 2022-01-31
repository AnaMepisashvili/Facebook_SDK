//
//  SettingsViewModel.swift
//  Facebook_SDK
//
//  Created by Ana Mepisashvili on 31.01.22.
//

import UIKit
import FBSDKLoginKit

class SettingsViewModel: NSObject {
    
    //MARK: - Variables
    var image: ((Data)->Void)?
    var fullName: ((String)->Void)?
    
    //MARK: - Functions
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
                self.image?(imageData!)
            }
            if let fullName = json["name"] {
                self.fullName?(fullName as! String)
            }
        }
    }
}
