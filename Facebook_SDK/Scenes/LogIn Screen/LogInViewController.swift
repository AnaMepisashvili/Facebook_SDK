//
//  SignInViewController.swift
//  Facebook_SDK
//
// Add this to the header of your file, e.g. in ViewController.swift
import FBSDKLoginKit

// Add this to the body
class LogInViewController: UIViewController, LoginButtonDelegate {
            
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let token = AccessToken.current, !token.isExpired {
            let token = token.tokenString

            let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                     parameters: ["fields": "email, name"],
                                                     tokenString: token,
                                                     version: nil,
                                                     httpMethod: .get)
            request.start(completion:{ connection, result, error in
                        print("\(result)")
                    })
        } else {
            let loginButton = FBLoginButton()
            loginButton.delegate = self
            loginButton.center = view.center
            loginButton.permissions = ["public_profile", "email"]

            view.addSubview(loginButton)
        }
        
//        let loginButton = FBLoginButton()
//        loginButton.delegate = self
//        loginButton.center = view.center
//        loginButton.permissions = ["public_profile", "email"]
//
//        view.addSubview(loginButton)
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields": "email, name"],
                                                 tokenString: token,
                                                 version: nil,
                                                 httpMethod: .get)
        request.start(completion:{ connection, result, error in
            let sb = UIStoryboard(name: "TabBarController", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "TabBarController")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
                    print("\(result)")
                })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
}
