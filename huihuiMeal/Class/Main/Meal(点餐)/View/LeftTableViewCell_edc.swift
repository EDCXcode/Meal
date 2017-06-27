//
//  LeftTableViewCell_edc.swift
//  huihuiMeal
//
//  Created by edc on 2017/3/16.
//  Copyright © 2017年 edc. All rights reserved.
//

import UIKit

class LeftTableViewCell_edc: UITableViewCell {

    
    lazy var TextName = UILabel.init()
 
    private lazy var SelectView = UIView.init()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

  
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        configureUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func  configureUI() {
        
        TextName.frame = CGRect(x: 10, y: 0, width: 60, height: leftTabHeight)
        TextName.textColor = UIColor.black
        contentView.addSubview(TextName)
        
        
        SelectView.frame = CGRect(x: 0, y: 0, width: 3, height: leftTabHeight)
        SelectView.backgroundColor = EDCRGB(R: 93, G: 208, B: 171, ap: 1.0)
        contentView.addSubview(SelectView)

    }
    

    func setCellvalue( model : Classification_edc ) {
        
        TextName.text = model.ClassificationName as String?
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        //contentView.backgroundColor = selected ? UIColor.white : UIColor(white: 0, alpha: 0.1)
        //contentView.backgroundColor=UIColor.red
        
        TextName.textColor = selected ? MyTextColor : UIColor.black
        
        //TextName.textColor =
        
        isHighlighted = selected
        TextName.isHighlighted = selected
        SelectView.isHidden = !selected
        
    }
    

}
