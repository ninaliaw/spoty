//
//  PlayerViewController.swift
//  spotifyext
//
//  Created by Nina Simone Liaw on 2/20/21.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage


class PlayerViewController : UIViewController {

    //
    //reg vars
    var bounds = UIScreen.main.bounds
    var width : CGFloat?
    var height : CGFloat?
    
    
    //IBOutlet s
    @IBOutlet weak var coverArt: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!
    //testers:
    @IBOutlet weak var bg: UILabel!
    @IBOutlet weak var pr: UILabel!
    @IBOutlet weak var sc: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var darkBG: UILabel!
    
    
    //constraints
    @IBOutlet weak var coverArtWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var coverArtHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var coverArtYCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var coverArtXCenterConstraint: NSLayoutConstraint!
    //
   //
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
        //
        
//        self.view.backgroundColor =
        
//        width = bounds.size.width
//        height = bounds.size.height
//
//        coverArt.isUserInteractionEnabled = true
//        coverArt.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(coverArtTapped)))
        
        let hdr = HTTPHeaders(
            ["Authorization": "Bearer \(ViewController.token!)",
             "Content-Type": "application/json"])
        
        let parameters: [String:Any] = ["market": "US",
//                                        "limit": 2
                        ]
        
        AF.request("https://api.spotify.com/v1/me/player/currently-playing",
                   parameters: parameters,
                   headers: hdr).responseDecodable(of: CurrentTrackData.self) { resp in
                     
                    switch resp.result {
                    case .success(let currentTrackData):
                        
                        self.songTitle.text = currentTrackData.item.name
                        self.artistName.text = currentTrackData.item.artists.first?.name
                        
                        if let url = currentTrackData.item.album.images.first?.url {
                            
                                 AF.request(url).responseImage { resp in
                                     switch resp.result {
                                     case .success(let image):
//                                        self.coverArt.alpha = 1
                                        self.coverArt.image = image
                                        
                                        var backgroundColor_ : UIColor = UIColor.green
                                        var songTitleColor_ : UIColor = UIColor.yellow
                                        
                                        
                                        //gets colors from image
                                        self.coverArt.image?.getColors { colors in
                                            
                                            //getting colors from the method
                                            let bgColor = colors?.background
                                            let primary = colors?.primary
                                            let secondary = colors?.secondary
                                            let detail = colors?.detail
                                            
                                            var r : CGFloat = 0
                                            var g : CGFloat = 0
                                            var b : CGFloat = 0
                                            var a : CGFloat = 0
                                            
                                            let ratio : CGFloat = 0.7
                                            
                                            //getting rgb values of background color
                                            bgColor?.getRed(&r, green: &g, blue: &b, alpha: &a)
                                            
                                            //setting background color to shade of background color
                                            let newBG : UIColor = UIColor(red: r*ratio, green: g*ratio, blue: b*ratio, alpha: 1)
                                            newBG.getRed(&r, green: &g, blue: &b, alpha: &a)
                                            //now r,g,b store shaded color
                                            
                                            //tester colors!
                                            self.bg.textColor = bgColor
                                            self.darkBG.textColor = newBG
                                            self.pr.textColor = primary
                                            self.sc.textColor = secondary
                                            self.detail.textColor = detail
                                            
                                            ///kkkkk
                                            ///
                                            ///
                                            ///
                                            ///
                                            ///
                                            /*
                                             later,,...
                                             if bg color is boring gray, change to other color
                                             if (bg_is_boring) {
                                                choose better color
                                             }
                                             
                                             look for other progam to get colors (like for engineering)
                                             stay away from yellow,gray,red,brown go toward cool pretty colors/pastels
                                             either shadow + background or complete blend like black
                                             */
                                            
                                            //if the extracted bg color is dark, set song title color to primary
                                            var colorText : Bool = false
                                            
                                            if (r < 0.12 && g < 0.12 && b < 0.12) {
                                                
                                                backgroundColor_ = newBG
                                                songTitleColor_ = primary!
                                                colorText = true
                                            
                                                print("1. dark background, primary color title")
                                            } else {
                                                
                                                //shadow if lighter background
                                                self.coverArt.layer.shadowPath = UIBezierPath(rect: self.coverArt.bounds).cgPath
                                                self.coverArt.layer.shadowRadius = 10
                                                self.coverArt.layer.shadowOffset = .zero
//                                                self.coverArt.layer.shadowOffset = CGSize(width: 0, height: 1)
//                                                self.coverArt.layer.shadowColor = UIColor.black.cgColor
                                                self.coverArt.layer.shadowOpacity = 0.6
                                                self.coverArt.clipsToBounds = false
                                                
                                                //if the extracted bg color is light, set bg color to primary
                                                if (r > 0.6 && g > 0.6 && b > 0.6) {
                                                    print("2. would've been light/white/gray bg, change to primary")
                                                    
                                                    backgroundColor_ = primary!
//                                                    self.view.backgroundColor = primary
                                                }
                                                //regular coloring -- bg color = newBG
                                                else {
                                                        print("3. reg")
                                                        backgroundColor_ = newBG
                                                }
                                                
                                                newBG.getRed(&r, green: &g, blue: &b, alpha: &a)
                                                
                                                //if light, white text
                                                if (!colorText) {
                                                    if (((r*299) + (g*587) + (b*114))/1000 < 0.7) {
                                                        songTitleColor_ = UIColor.white
                                                        print("dark, white text")
//                                                        print("r \(r), g \(g), b \(b), value: \(((r*299*ratio) + (g*587*ratio) + (b*114*ratio))/1000)")
                                                    } else {
                                                        songTitleColor_ = UIColor.black
                                                        print ("888 it's black text?!?! lol")
                                                    }
                                                }
                                            }
                                            
                                            UIView.animate(withDuration: 1.0) {
                                                self.view.backgroundColor = backgroundColor_
                                                self.songTitle.textColor = songTitleColor_
                                                self.artistName.textColor = songTitleColor_.withAlphaComponent(0.75)
                                            }
                                        }
                                            
                                     case .failure(let error):
                                         print(error)
                                     }
                                   }
                             
                            
//                            self.coverArt.loadImage(url: url)
                        }
                        else {
                            //question mark image ...
                        }
                    case .failure(let error):
                        print(error)
                   }
                }
        
    }
    
    @objc func coverArtTapped() {
        animateCoverArt()
    }
    
    func animateCoverArt() {
        
        self.coverArtWidthConstraint.constant = 50
        self.coverArtHeightConstraint.constant = 50
        
        self.coverArtXCenterConstraint.isActive = false
        self.coverArtYCenterConstraint.isActive = false
        
        
        
//        let constraint = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: <#T##NSLayoutConstraint.Attribute#>, multiplier: <#T##CGFloat#>, constant: <#T##CGFloat#>)
                
        UIView.animate(withDuration: 3) {
            self.view.layoutIfNeeded()
//            self.coverArt.alpha = 0
        }
    }
}
