//import UIKit
//
//class ViewController: UIViewController {
//    let graphqlUri = "https://api.wonde.com/graphql/me"
//    let tokenUri = "https://api.wonde.com/oauth/token"
//    let authUri = "https://edu.wonde.com/oauth/authorize"
//    let redirectUri = "wondeDemoAppScheme://"
//    
//    let clientId = "<Your Client ID goes here>"
//    let clientSecret = "<Your Client Secret goes here>"
//    var hasUserBeenAuthenticated = false;
//    var token: String?
//    
//    @IBAction  func handleLogin(_ sender: Any) {
//        if (!self.hasUserBeenAuthenticated) {
//            self.authorise()
//        }
//    }
//    
//    @IBAction  func makeAuthenticatedRequest(_ sender: Any) {
//        let params = [
//            "query": """
//                {
//                Me {
//                    id
//                    first_name
//                    last_name
//                    email
//                    mobile
//            
//                    School {
//                            id
//                            name
//                            establishment_number
//                            la_code
//                            urn
//                            }
//                    Person {
//                        __typename
//                        ...on Employee {
//                                forename
//                                surname
//                                }
//                            }
//                    }
//                }
//            """
//        ]
//        
//        let url = URL(string: self.graphqlUri)
//        
//        var request = URLRequest(url: url!)
//        
//        request.httpMethod = "POST"
//        
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.addValue("Bearer " + self.token!, forHTTPHeaderField: "Authorization")
//        
//        try? request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
//        
//        let config = URLSessionConfiguration.default
//        let session = URLSession(configuration: config)
//        
//        let task = session.dataTask(with: request) { (data, response, error) in
//            if let data = data {
//                print(String(data:data, encoding: .utf8))
//            }
//            
//            if let error = error {
//                print(error.localizedDescription)
//            }
//        }
//        
//        task.resume()
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.getAccessToken), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
//    }
//    
//    @objc
//    func getAccessToken() {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        
//        if (appDelegate.code != nil) {
//            let params = [
//                "grant_type": "authorization_code",
//                "client_id": String(self.clientId),
//                "client_secret": self.clientSecret,
//                "redirect_uri": self.redirectUri,
//                "code": appDelegate.code,
//                ]
//            
//            let url = URL(string: self.tokenUri)
//            
//            var request = URLRequest(url: url!)
//            
//            request.httpMethod = "POST"
//            
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.addValue("application/json", forHTTPHeaderField: "Accept")
//            
//            try? request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
//            
//            let config = URLSessionConfiguration.default
//            let session = URLSession(configuration: config)
//            
//            let task = session.dataTask(with: request) { (data, response, error) in
//                if let data = data {
//                    let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
//                    
//                    self.token = json!!["access_token"] as! String
//                }
//                
//                if let error = error {
//                    print(error.localizedDescription)
//                }
//            }
//            
//            task.resume()
//        }
//    }
//    
//    func authorise() {
//        let params = [
//            URLQueryItem(name: "client_id", value: String(self.clientId)),
//            URLQueryItem(name: "redirect_uri", value: self.redirectUri),
//            URLQueryItem(name: "response_type", value: "code"),
//            ]
//        
//        let urlComponents = NSURLComponents(string: self.authUri)
//        
//        urlComponents?.queryItems = params
//        
//        UIApplication.shared.open((urlComponents?.url)!, options: Dictionary(), completionHandler: nil)
//    }
//}
//
//
