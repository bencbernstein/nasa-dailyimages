//
//  PlanetCell.swift
//  Predict The Sky
//
//  Created by Benjamin Bernstein on 2/16/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import UIKit

class PlanetCell: UICollectionViewCell {
    
    var planet: PlanetStruct! {
        didSet {
            print("did set")
            titleLabel.text = planet.title
            NASA.downloadPic(picURL: planet.imgUrl) { (imageData) in
                if let image = UIImage(data: imageData) {
                    OperationQueue.main.addOperation {
                        self.imageView.image = image
                    }
                }
            }
        }
    }
    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Not defined"
        return label
    }()
    
    var imageView: UIImageView = {
        var image = UIImageView()
        return image
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        
        addSubview(titleLabel)
        addSubview(imageView)
        
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -(self.frame.height * 0.8)).isActive = true
        
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
}
