//
//  Planet.swift
//  Predict The Sky
//
//  Created by Benjamin Bernstein on 2/16/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import Foundation
import UIKit

class Planet {
    
    var title: String
    var image: UIImage
    
    init(title: String, image: UIImage) {
        self.title = title
        self.image = image
    }
    
}


struct PlanetStruct {
    var title: String
    var imgUrl: String
}
