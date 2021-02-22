//
//  ArtistTableViewCell.swift
//  spotifyext
//
//  Created by Nina Simone Liaw on 2/19/21.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {

    @IBOutlet weak var artistPFP: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
