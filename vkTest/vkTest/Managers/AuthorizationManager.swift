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
        let scope = ["wall", "friends", "groups","audio"]
        VKSdk.wakeUpSession(scope) { [self] state, error in
            switch state {
            case .initialized:
                VKSdk.authorize(scope)
            case .authorized:
                didAuthorize()
            default:
                print(error?.localizedDescription ?? "error")
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            let prevToken = realm.readToken()
            let token = RealmTokenSaver(token: result.token.accessToken)
            if prevToken == nil {
                realm.saveToken(token: token)
            } else {
                realm.updateToken(token: token)
            }
            didAuthorize()
        } else if result.error != nil {
            print(result?.error ?? "error")
        }
    }
    
    func didAuthorize() {
        guard let token = realm.readToken() else {return}
        self.token = token
        keyWindow?.rootViewController = MainTabBar()
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
