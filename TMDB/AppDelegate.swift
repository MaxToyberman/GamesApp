//
//  AppDelegate.swift
//  TMDB
//
//  Created by Maxim Toyberman on 26/08/2016.
//  Copyright © 2016 Maxim Toyberman. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let API_KEY="b472d300833b5fb961d972dfb58cdd9c5f99a463"
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        updateGamesFeed({(feed)->Void in
            //find the first navigationController
            let navigationController=application.windows[0].rootViewController as? UINavigationController
            
            //when the navigationController is found,find the rootView controller that the navigationController points to.
            if let viewController=navigationController?.viewControllers.first as?  MovieFeedTableViewController{
                viewController.feed=feed
            }
            
        })
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func updateGamesFeed(completion:(feed:MoviesFeed)->Void){
        
        Alamofire.request(.GET,Constants.apiURL+"now_playing?api_key="+Constants.apiKey+"&page=1").responseJSON { response in
            
            switch response.result{
                
            case .Success(let data):
                let json=JSON(data)
                let movies = MoviesFeed(moviesJson: json["results"])
                completion(feed: movies)
                
            case .Failure(let error):
                print("Request failed with error: \(error)")
            }
            
        }
        
    }
    
    
}

