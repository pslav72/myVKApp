//
//  VKOauthWebViewController.swift
//  myVK
//
//  Created by Вячеслав Поляков on 22.03.2021.
//

import UIKit
import WebKit

class VKOauthWebViewController: UIViewController {
    
    let vkApiTarget = VKApiTarget()
    
    @IBOutlet weak var vkOauthWebView: WKWebView! {
        didSet {
            vkOauthWebView.navigationDelegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = vkApiTarget.schemeWebView
        urlComponents.host = vkApiTarget.oauthHost
        urlComponents.path = vkApiTarget.pathMethod(method: .authorize)
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7799049"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: vkApiTarget.apiVersion)
        ]

        let request = URLRequest(url: urlComponents.url!)

        vkOauthWebView.load(request)

    }
    
}

extension VKOauthWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        guard navigationResponse.response.url?.path == "/blank.html",
              let fragment = navigationResponse.response.url?.fragment
        else {
            decisionHandler(.allow)
            return
        }
        
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }

        SessionsUser.shared.userId = params["user_id"] ?? ""
        SessionsUser.shared.token = params["access_token"] ?? ""
        
        print("access_token \(SessionsUser.shared.token)")
        
        performSegue(withIdentifier: "ShowMainTabBarController", sender: nil)
        
        decisionHandler(.cancel)

        
    }
    
}
