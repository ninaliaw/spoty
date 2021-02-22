//
//  UIImageViewExt.swift
//  spotifyext
//
//  Created by Nina Simone Liaw on 2/20/21.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    
    func loadImage(url: String) {
        
        print("LOAD img/n***/nLOAD/n***/nLOAD/n***/nLOAD/n***/nLOAD/n***/nLOAD/n")
        
        AF.request(url).responseImage { resp in
            switch resp.result {
            case .success(let image):
                self.image = image
            case .failure(let error):
                print(error)
                print("haha it no work :(/n/n/n:(/n/n/n:((((((")
            }
          }

    }
    
}
