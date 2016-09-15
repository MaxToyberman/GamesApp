//
//  TrailersViewController.swift
//  TMDB
//
//  Created by Maxim Toyberman on 14/09/2016.
//  Copyright © 2016 Maxim Toyberman. All rights reserved.
//


import UIKit
import YoutubeSourceParserKit
import MediaPlayer
import AVKit

import Alamofire
import SwiftyJSON

class TrailersViewController :UIViewController{
    
    
    let moviePlayer = MPMoviePlayerController()
    
    var movieId: String?{
        didSet{
            getTrailer()
        }
    }
    
    
    func getTrailer(){
        
        Alamofire.request(.GET,"https://api.themoviedb.org/3/movie/"+movieId!+"/videos?api_key=39ce2c8a878066aa7e7ff178828aadb2").responseJSON { response in
            
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviePlayer.view.frame = view.frame
        view.addSubview(moviePlayer.view)
        moviePlayer.fullscreen = true

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