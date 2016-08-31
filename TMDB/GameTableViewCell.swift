//
//  MovieTableViewCell.swift
//  TMDB
//
//  Created by Maxim Toyberman on 27/08/2016.
//  Copyright © 2016 Maxim Toyberman. All rights reserved.
//

import UIKit
import FoldingCell

class GameTableViewCell: FoldingCell {
    
    
    @IBOutlet weak var name: UILabel!
    
    
    @IBOutlet weak var gameImage: UIImageView!
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func animationDuration(itemIndex:NSInteger, type:AnimationType)-> NSTimeInterval {
        
        // durations count equal it itemCount
        let durations = [0.33, 0.26, 0.26] // timing animation for each view
        return durations[itemIndex]
    }
    

}
