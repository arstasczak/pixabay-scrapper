//
//  VideoScrapperCell.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 16/06/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit
import Kingfisher

class VideoScrapperCell: UITableViewCell {
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var viewsLabel: UILabel!
    @IBOutlet var downloadsLabel: UILabel!
    @IBOutlet var likesLabel: UILabel!
    @IBOutlet var userLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCellAppearance() {
        thumbnailImageView.layer.masksToBounds = false
        thumbnailImageView.layer.borderWidth = 2.0
        thumbnailImageView.layer.borderColor = UIColor.white.cgColor
    }
    
    func configureCell(with data: ScrappedVideoDto) {
        setupCellAppearance()
        guard let imageURL = URL(string: data.imageURL) else {return}
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.kf.setImage(with: imageURL)
        
        viewsLabel.text = "Views: \(data.views)"
        downloadsLabel.text = "Downloads: \(data.downloads)"
        likesLabel.text = "Likes: \(data.likes)"
        userLabel.text = "User: \(data.user)"
    }
    
}
