//
//  RightTabHeadView_edc.swift
//  huihuiMeal
//
//  Created by edc on 2017/3/16.
//  Copyright © 2017年 edc. All rights reserved.
//

import UIKit

class RightTabHeadView_edc: UIView {


    lazy var nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = MyTextColor
        nameLabel.frame = CGRect(x: 15, y: 0, width: 200, height: 30)
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.textColor = UIColor.white
        addSubview(nameLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
