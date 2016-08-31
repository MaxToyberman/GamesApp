//
//  MoviesLoader.swift
//  TMDB
//
//  Created by Maxim Toyberman on 28/08/2016.
//  Copyright © 2016 Maxim Toyberman. All rights reserved.
//

import SwiftyJSON

class GamesFeed {
    
     let games:[Game]
    
    init (games newGames:[Game]){
        self.games=newGames
    }
    
    convenience init (gamesJson:JSON){
        
        var newGames=[Game]()
        for (_,json):(String, JSON) in gamesJson {
            
            guard let name=json["name"].string else{
                continue
            }
            guard let description=json["description"].string else{
                continue
            }
            guard let imageURL=json["image"]["icon_url"].string else{
                continue
            }
            
            let game=Game(name: name,description: description,imageURL: imageURL)
            
            newGames.append(game)
        }
        self.init(games: newGames)
    }
    
}
