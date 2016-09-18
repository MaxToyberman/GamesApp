//
//  MoviesLoader.swift
//  TMDB
//
//  Created by Maxim Toyberman on 28/08/2016.
//  Copyright © 2016 Maxim Toyberman. All rights reserved.
//  Linkedin:https://www.linkedin.com/in/maxim-toyberman-8a75556b
//

import SwiftyJSON

class MoviesFeed {
    
    struct Config {
        static let baseURL = "http://image.tmdb.org/t/p/w185/"
    }
    let movies:[Movie]
    
    init (movies newMovies:[Movie]){
        self.movies=newMovies
    }
    
    convenience init (moviesJson:JSON){
        
        var newMovies=[Movie]()
        for (_,json):(String, JSON) in moviesJson {
            
            guard let id=json["id"].uInt else{
                continue
            }
            
            guard let title=json["title"].string else{
                continue
            }
            
            guard let overview=json["overview"].string else{
                continue
            }
            guard let imageURL=json["poster_path"].string else{
                continue
            }
            let movie=Movie(title: title,overview: overview,imageURL: Config.baseURL+imageURL,movieId: id,posters: nil)
            
            newMovies.append(movie)
        }
        self.init(movies: newMovies)
    }
    
}
