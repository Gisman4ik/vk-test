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
    var realm = RealmManager.shared
    var token: String?
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
                VKSdk.authorize(scope)
            case .authorized:
                guard let token = realm.readToken() else {return}
                self.token = token
                guard let feedVK = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: FeedVK.self)) as? FeedVK else {return}
                keyWindow?.rootViewController = feedVK
            default:
                print(error?.localizedDescription ?? "error")
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            let prevToken = realm.readToken()
            if prevToken == nil {
                let token = RealmTokenSaver(token: result.token.accessToken)
                realm.saveToken(token: token)
            }
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
