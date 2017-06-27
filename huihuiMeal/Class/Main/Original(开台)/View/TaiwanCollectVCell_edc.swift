//
//  TaiwanCollectVCell_edc.swift
//  huihuiMeal
//
//  Created by edc on 2017/3/14.
//  Copyright © 2017年 edc. All rights reserved.
//

import UIKit

class TaiwanCollectVCell_edc: UICollectionViewCell {

  
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var Num: UILabel!
    
    @IBOutlet weak var Population: UILabel!
    
    @IBOutlet weak var Openpwd: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        bgView.layer.cornerRadius = 5.0
        
        bgView.backgroundColor = RGBCOLOR()
  
    }
    
    
    
    func setCell()  {
        
        //判断设备
        if EDCDevice == .pad {
            
            Num.font = UIFont.systemFont(ofSize: 20)
            
            Population.font = UIFont.systemFont(ofSize: 20)
            
            
        }
        
        
        Num.text="18号桌"
        
        Population.text = "人数7人"
        
        
    }
    
   
}
