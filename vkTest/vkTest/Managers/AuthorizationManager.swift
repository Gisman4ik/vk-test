//
//  AuthManager.swift
//  vkTest
//
//  Created by Artur Radziukhin on 26.06.21.
//

import Foundation
import VK_ios_sdk

final class AuthorizationManager: NSObject, VKSdkDelegate,VKSdkUIDelegate {
    
    private var appId = "7889000"
    private let vkSDK: VKSdk
//    var token: VKAccessToken?
    var token = "832b980b816ab6d60297f8c7366ebca260b84d0c8963fad74df5fa5da4ddf63bab0fa88644b56c3ff1108"
    let versionAPI = "5.131"
    static let shared = AuthorizationManager()
    private var keyWindow: UIWindow? { UIApplication.shared.windows.first(where: { $0.isKeyWindow }) ?? UIApplication.shared.windows.first
    }
    
   private override init() {
        vkSDK = VKSdk.initialize(withAppId: appId)
        super.init()
        vkSDK.register(self)
        vkSDK.uiDelegate = self
    }
    
    func wakeUpSession() {
        let scope = ["photos","wall","friends"]
        VKSdk.wakeUpSession(scope) { [self] state, error in
            switch state {
            case .initialized:
                print("initialized")
                VKSdk.authorize(scope)
            case .authorized:
                print("authorized")
                guard let feedVK = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: FeedVK.self)) as? FeedVK else {return}
                keyWindow?.rootViewController = feedVK
            default:
                print(error?.localizedDescription ?? "error")
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
//            token = result.token
        } else if result.error != nil {
            print(result?.error ?? "error")
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        guard let topController = keyWindow?.rootViewController else {return}
        topController.present(controller, animated: true, completion: nil)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
        
    }
}
