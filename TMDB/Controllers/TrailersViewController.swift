//
//  TrailersViewController.swift
//  TMDB
//
//  Created by Maxim Toyberman on 14/09/2016.
//  Copyright © 2016 Maxim Toyberman. All rights reserved.
//  Linkedin:https://www.linkedin.com/in/maxim-toyberman-8a75556b
//


import UIKit
import YoutubeSourceParserKit
import MediaPlayer
import AVKit

import Alamofire
import SwiftyJSON

class TrailersViewController :UIViewController{
    
    private let moviePlayer = MPMoviePlayerController()
    //MARK: Properties
    var movieId: String?{
        didSet{
            getTrailer()
        }
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        moviePlayer.view.frame = view.frame
        view.addSubview(moviePlayer.view)
        moviePlayer.fullscreen = true
    }
    //MARK: Methods
    private func getTrailer(){
        
        Alamofire.request(.GET,Constants.apiURL+movieId!+"/videos?api_key="+Constants.apiKey).responseJSON { response in
            
            switch response.result{
                
            case .Success(let data):
                let json=JSON(data)
                let trailersJson = json["results"]
                
                
                if let movieURL=trailersJson[0]["key"].string{
                    let youtubeURL = NSURL(string: "https://www.youtube.com/watch?v="+movieURL)!
                    self.playVideoWithYoutubeURL(youtubeURL)
                }
                
            case .Failure(let error):
                print("Request failed with error: \(error)")
            }
            
        }
    }
    
    func playVideoWithYoutubeURL(url: NSURL) {
        Youtube.h264videosWithYoutubeURL(url, completion: { (videoInfo, error) -> Void in
            if let
                videoURLString = videoInfo?["url"] as? String,
                videoTitle = videoInfo?["title"] as? String {
                self.moviePlayer.contentURL = NSURL(string: videoURLString)
            }
        })
    }
}