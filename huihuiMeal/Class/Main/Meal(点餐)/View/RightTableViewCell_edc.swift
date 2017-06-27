//
//  RightTableViewCell_edc.swift
//  huihuiMeal
//
//  Created by edc on 2017/3/16.
//  Copyright © 2017年 edc. All rights reserved.
//

import UIKit

class RightTableViewCell_edc: UITableViewCell {
    
    
    lazy var TextName = UILabel.init()
    lazy var TextResidual = UILabel.init()
    lazy var TextMoeny = UILabel.init()
    lazy var bgimg = UIImageView.init()
    lazy var TextQuantity = UILabel.init()
    lazy var ReducingBtn = UIButton.init()
    lazy var CanadaBtn = UIButton.init()
    lazy var bgView : UIView = UIView.init()
    lazy var tapui = UITapGestureRecognizer.init()
    

    var Quantity : Int = 0
    var typeB : Bool? = false
    
    
    lazy var CellModel: DishModel_edc = DishModel_edc()
    
    
    let imgWidth = 80
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ReducingBtn.isHidden = true
        TextQuantity.isHidden = true
        CanadaBtn.isHidden = true
        Quantity = 0
        typeB = false
    }
    
    
    override  init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        configureUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:视图发生改变时
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        if Quantity > 0 {
            
            ReducingBtn.isHidden = false
            TextQuantity.isHidden = false
            CanadaBtn.isHidden = false
            
        }else{
            
            ReducingBtn.isHidden = true
            TextQuantity.isHidden = true
            CanadaBtn.isHidden = true
        }

        
     }
    
    
    //MARK:赋值
    func setCellvalue(model :DishModel_edc ) {
        
        CellModel = model
       
        if (model.OrderCount != nil) {
            Quantity = model.OrderCount!
        }else{
            Quantity = 0
        }
        
        
    
        TextName.text = model.VegeName as String?
        TextResidual.text =  model.Quantity as String?
        TextMoeny.text = String.init(format: "¥%@", model.Money!)
        bgimg.image = UIImage (named: model.ImgName!)
        TextQuantity.text = "\(Quantity)"
       
    }
    
    //MARK:SubUI
    func  configureUI() {
        
        bgimg.frame = CGRect(x: 10, y: 10, width: imgWidth, height: imgWidth)
        bgimg.backgroundColor = EDCRGB(R: 93, G: 208, B: 171, ap: 1.0)
        contentView.addSubview(bgimg)
        
        
        TextName.frame = CGRect(x: Int(bgimg.frame.maxX)+10 , y: 10, width: Int(self.bounds.width) - imgWidth - 20, height: 20)
        TextName.font = UIFont .systemFont(ofSize: 16)
        TextName.textColor = UIColor.black
        contentView.addSubview(TextName)
        
        
        TextResidual.frame = CGRect(x: Int(bgimg.frame.maxX)+10 , y: Int(TextName.frame.maxY) + 10, width: Int(self.bounds.width) - imgWidth - 20, height: 20)
        TextResidual.font = UIFont .systemFont(ofSize: 13)
        TextResidual.textColor = UIColor.lightGray
        contentView.addSubview(TextResidual)
        
        
        TextMoeny.frame = CGRect(x: Int(bgimg.frame.maxX)+10 , y: Int(TextResidual.frame.maxY) + 10, width: 90, height: 20)
        TextMoeny.textAlignment = .left
        TextMoeny.font = UIFont .systemFont(ofSize: 14)
        TextMoeny.textColor = MyTextColor
        contentView.addSubview(TextMoeny)
        
        
        bgView.frame = CGRect(x: 0, y: 0 , width: EDCScreenWidth , height: 100)
        contentView.addSubview(bgView)
        tapui.addTarget(self, action: #selector(SelcetCell))
        bgView.addGestureRecognizer(tapui)
         
        
        ReducingBtn.frame = CGRect(x:EDCScreenWidth - iconWidth - 150 , y: Int(TextResidual.frame.maxY)+5, width: iconWidth, height: iconWidth)
        ReducingBtn.setImage(UIImage (named: "ic_sub"), for: .normal)
        ReducingBtn.isHidden = true
        ReducingBtn.tag = 1000
        ReducingBtn.addTarget(self, action: #selector(SetClick), for: .touchUpInside)
        contentView.addSubview(ReducingBtn)
        
        
        TextQuantity.frame = CGRect(x: EDCScreenWidth - iconWidth - 120, y: Int(TextResidual.frame.maxY)+10 , width: 20, height: 20)
        TextQuantity.text = "1"
        TextQuantity.font = UIFont.systemFont(ofSize: 15)
        TextQuantity.isHidden = true
        TextQuantity.textAlignment = .center
        contentView.addSubview(TextQuantity)
        
        
        CanadaBtn.frame = CGRect(x: EDCScreenWidth - iconWidth - 100, y: Int(TextResidual.frame.maxY)+5 , width: iconWidth, height: iconWidth)
        CanadaBtn.setImage(UIImage (named: "ic_add"), for: .normal)
        CanadaBtn.isHidden = true
        CanadaBtn.tag = 1001
        CanadaBtn.addTarget(self, action: #selector(SetClick), for: .touchUpInside)
        contentView.addSubview(CanadaBtn)
        
    }
    

    
    //MARK:点餐
    func SelcetCell () {
        
        if ReducingBtn.isHidden {

            let btn = UIButton.init()
            btn.tag = 1001
            SetClick(btn: btn)
        }
        
    }
    
    
    
    //MARK:数量设置
    func SetClick (btn : UIButton) {
        
        //减少
        if btn.tag == 1000 {
            typeB = false
            Quantity -= 1
        }else if btn.tag == 1001{
           
            Quantity += 1
            typeB = true
        }
        
        TextQuantity.text = "\(Quantity)"
        
        
        if Quantity > 0 {
            
            ReducingBtn.isHidden = false
            TextQuantity.isHidden = false
            CanadaBtn.isHidden = false
            
        }else{
            
            ReducingBtn.isHidden = true
            TextQuantity.isHidden = true
            CanadaBtn.isHidden = true
        }

        //发送通知
        let notificationName = Notification.Name(rawValue: "MealNot")
        NotificationCenter.default.post(name: notificationName, object: self,
                                        userInfo: ["RightTableViewCell" : self ])
        
        
//        //发送通知
//        let notificationName = Notification.Name(rawValue: "MealNot")
//        NotificationCenter.default.post(name: notificationName, object: self,
//                                        userInfo: ["VegeId" : CellModel.VageId! as Int,"OreDerId": Quantity,"type":typeB! as Int])
    }
    
    
    
}
