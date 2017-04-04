//
//  AlbumListTableViewCell.swift
//  RMPPhotoAlbum
//
//  Created by Lee Jiho on 2017. 4. 4..
//  Copyright © 2017년 Lee Jiho. All rights reserved.
//

import UIKit

class AlbumListTableViewCell: UITableViewCell {
    
    fileprivate var thumbnailImageView = UIImageView()
    fileprivate var albumNameLabel = UILabel()
    fileprivate var album: AlbumList?
    
    struct Metric {
        static let thumbnailImageViewLeft:CGFloat = 20.0
        static let thumbnailImageViewUp:CGFloat = 10.0
        static let thumbnailImageViewSize:CGFloat = 50.0
        
        static let albumNameLabelLeft:CGFloat = 20.0
        static let albumNameLabelRight:CGFloat = 20.0
        static let albumNameLabelUp:CGFloat = 10.0

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
        self.contentView.addSubview(self.thumbnailImageView)
        self.contentView.addSubview(self.albumNameLabel)
    }
    
    func configure(album: AlbumList) {
        
        self.album = album
        if let photo = album.photo.first?.photo {
            self.thumbnailImageView.image = UIImage(data: photo, scale: 0.1)
        } else {
            self.thumbnailImageView.image = UIImage(named: "Placeholder")
        }

        self.albumNameLabel.text = album.albumName
        
        self.setNeedsLayout()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.thumbnailImageView.frame = CGRect(x: Metric.thumbnailImageViewLeft, y: Metric.thumbnailImageViewUp, width: Metric.thumbnailImageViewSize, height: Metric.thumbnailImageViewSize)
        
        self.albumNameLabel.frame = CGRect(x: self.thumbnailImageView.frame.origin.x+Metric.thumbnailImageViewSize+Metric.albumNameLabelLeft, y: Metric.albumNameLabelUp, width: self.frame.size.width - Metric.albumNameLabelRight, height: self.frame.size.height - Metric.albumNameLabelUp * 2)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
