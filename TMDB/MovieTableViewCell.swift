//
//  MovieTableViewCell.swift
//  TMDB
//
//  Created by Maxim Toyberman on 27/08/2016.
//  Copyright © 2016 Maxim Toyberman. All rights reserved.
//

import FoldingCell

class MovieTableViewCell: FoldingCell {
    
    


    @IBOutlet weak var overView: UITextView!

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieImageUnfolded: UIImageView!
    
    override func animationDuration(itemIndex:NSInteger, type:AnimationType)-> NSTimeInterval {
        
        // durations count equal it itemCount
        let durations = [0.33, 0.26, 0.26] // timing animation for each view
        return durations[itemIndex]
    }
    

}
