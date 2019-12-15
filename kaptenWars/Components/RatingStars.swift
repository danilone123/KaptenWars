//
//  RatingStars.swift
//  kaptenWars
//
//  Created by daniel velasco on 14/12/2019.
//  Copyright © 2019 daniel velasco. All rights reserved.
//

import UIKit

public class RatingStars : UIStackView {
    public var image = UIImage(named: "Filled", in: nil, compatibleWith: nil)
    public var emptyImage = UIImage(named: "Empty", in: nil, compatibleWith: nil)
    
    public var stars: Int = 5 {
        didSet {
            update()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        axis = .horizontal
        distribution = .equalCentering
        alignment = .center
        spacing = 0
    }
    
    private func update() {
        guard arrangedSubviews.count != stars else {
            return
        }
      
        for _ in arrangedSubviews.count..<5 {
            if arrangedSubviews.count < stars {
                addArrangedSubview(UIImageView(image: image))
            } else {
                addArrangedSubview(UIImageView(image: emptyImage))
            }
        }
    }
    
}
