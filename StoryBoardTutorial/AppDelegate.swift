//
//  AppDelegate.swift
//  StoryBoardTutorial
//
//  Created by 박종훈 on 2021/08/10.
//

import UIKit
//푸쉬 알림을 위한 임포트
import UserNotifications
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        //푸쉬 알림을 생성하기위해 현재 알림센터에 (알림, 소리, 뱃지) 권한 요청
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { (success, error) in
            guard success else {
                //APNs(Apple push norification service) 에러
                print("APNs Registry 에러: \(error.debugDescription)")
                return
            }
            //APNS 성공
            print("APNs Registry 성공 \(success.description)")
        })
        //앱에 원격 알림을 등록
        application.registerForRemoteNotifications()
        return true
    }
    
    //메시지 출력하기
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token(completion: { (token, error) in
            guard let token = token else {
                print("Token 에러: \(error.debugDescription)")
                return
            }
            print("Token: \(token)")
        })
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

