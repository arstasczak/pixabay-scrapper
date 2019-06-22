//
//  ImageScrapperCell.swift
//  PixabayScrapper
//
//  Created by Arkadiusz Staśczak on 09/06/2019.
//  Copyright © 2019 Arkadiusz Staśczak. All rights reserved.
//

import UIKit
import Kingfisher

class ImageScrapperCell: UICollectionViewCell {

    @IBOutlet var thumbnailImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCellAppearance() {
        thumbnailImage.layer.masksToBounds = false
        thumbnailImage.layer.borderWidth = 2.0
        thumbnailImage.layer.borderColor = UIColor.white.cgColor
    }

    func configureCell(with data: ScrappedImageDto) {
        setupCellAppearance()
        guard let imageURL = URL(string: data.thumbnailURL) else {return}
        thumbnailImage.contentMode = .scaleAspectFill
        thumbnailImage.kf.setImage(with: imageURL)
    }
    
}
