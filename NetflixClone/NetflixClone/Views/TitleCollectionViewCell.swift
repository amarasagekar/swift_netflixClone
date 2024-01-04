//
//  TitleCollectionViewCell.swift
//  NetflixClone
//
//  Created by AMAR on 04/01/24.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    
    private let posterimageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterimageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterimageView.frame = contentView.bounds
    }
    
    public func configure(with model: String){
        guard let url = URL(string: model) else { return }
        posterimageView.sd_setImage(with: url, completed: nil)
    }
}
