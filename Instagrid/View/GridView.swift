//
//  GridView.swift
//  stack view
//
//  Created by Massinissa_theking on 20/06/2019.
//  Copyright © 2019 Massinissa_theking. All rights reserved.
//

import UIKit

extension UIView {
    var image: UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in layer.render(in: rendererContext.cgContext) }
    }
}

