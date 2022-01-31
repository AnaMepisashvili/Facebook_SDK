//
//  SignInViewController.swift
//  Facebook_SDK
//
// Add this to the header of your file, e.g. in ViewController.swift
import FBSDKLoginKit

// Add this to the body
class LogInViewController: UIViewController, LoginButtonDelegate {
    
    private let fbLoginButton: FBLoginButton = FBLoginButton()
    
    //MARK: - LifeCycle
    override func viewDidAppear(_ animated: Bool) {
        if AccessToken.isCurrentAccessTokenActive {
            openTabViewController()
        }
        else {
            addFBLoginButton()
        }
    }
    
    //MARK: - Functions
    private func addFBLoginButton() {
        fbLoginButton.delegate = self
        fbLoginButton.center = view.center
        fbLoginButton.permissions = ["public_profile", "email"]
        
        view.addSubview(fbLoginButton)
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        self.fbLoginButton.removeFromSuperview()
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields": "email, name"],
                                                 tokenString: Constants.FBToken,
                                                 version: nil,
                                                 httpMethod: .get)
        
        request.start(completion:{ connection, result, error in
            self.openTabViewController()
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        //  void
    }
    
    private func openTabViewController() {
        let sb = UIStoryboard(name: "TabBarController", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "TabBarController")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
