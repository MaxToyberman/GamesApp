//
//  PostersViewController.swift
//  TMDB
//
//  Created by Maxim Toyberman on 03/09/2016.
//  Copyright © 2016 Maxim Toyberman. All rights reserved.
//  Linkedin:https://www.linkedin.com/in/maxim-toyberman-8a75556b
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import TRMosaicLayout

extension PostersViewController:TRMosaicLayoutDelegate {
    
    //MARK: collectionView
    func collectionView(collectionView:UICollectionView, mosaicCellSizeTypeAtIndexPath indexPath:NSIndexPath) -> TRMosaicCellType {
        // I recommend setting every third cell as .Big to get the best layout
        return indexPath.item % 3 == 0 ? TRMosaicCellType.Big : TRMosaicCellType.Small
    }
    
    func collectionView(collectionView:UICollectionView, layout collectionViewLayout: TRMosaicLayout, insetAtSection:Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
    
    func heightForSmallMosaicCell() -> CGFloat {
        return 150
    }
    
}
class PostersViewController:UICollectionViewController {
    
    //MARK: Constants
    struct Config {
        static let baseURL = "http://image.tmdb.org/t/p/w185"
        static let resuseIdentifier="posterCell"
        
    }
    //MARK: Properties
    var movieId: String?{
        didSet{
            updatePosters()
        }
    }
    private var posters=[String]()
    //MARK: LifeCycle
    override func viewDidLoad() {
        self.collectionView!.backgroundColor = UIColor.whiteColor()
        
        let mosaicLayout = TRMosaicLayout()
        self.collectionView?.collectionViewLayout = mosaicLayout
        mosaicLayout.delegate = self
        
    }
    
    // MARK: - UICollectionViewDataSource protocol
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posters.count ?? 0
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Config.resuseIdentifier, forIndexPath: indexPath) as! PosterCollectionViewCell
        let poster=posters[indexPath.row]
        
        let url=NSURL(string:Config.baseURL+poster)
        cell.imageView.frame=cell.frame
        
        cell.imageView.af_setImageWithURL(url!)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    }
    
    func updatePosters(){
        
        Alamofire.request(.GET,Constants.apiURL+movieId!+"/images?api_key="+Constants.apiKey).responseJSON { response in
            
            switch response.result{
                
            case .Success(let data):
                let json=JSON(data)
                let postersJson = json["posters"]
                for (_,json):(String, JSON) in postersJson {
                    if let file_path=json["file_path"].string{
                        self.posters.append(file_path)
                    }
                }
                //posters=postersArr
                self.collectionView?.reloadData()
                
            case .Failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
}
