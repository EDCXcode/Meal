//
//  SweepsPayVC_edc.swift
//  huihuiMeal
//
//  Created by edc on 2017/3/27.
//  Copyright © 2017年 edc. All rights reserved.
//

import UIKit

class SweepsPayVC_edc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        SubUI()
    }

    
    //MARK:视图
    func  SubUI  ()  {
    
        title = "二维码收款"
        
        view.backgroundColor = EDCRGB(R: 241, G: 241, B: 241, ap: 1.0)
        
        
        let CenterView = UIView.init(frame: CGRect(x: Gap ,y:EDCGap ,width:EDCScreenWidth - Gap*2 ,height: EDCScreenHeight/5*3))
        CenterView.backgroundColor = UIColor.white
        CenterView.layer.cornerRadius = 5
        CenterView.layer.masksToBounds = true
        view.addSubview(CenterView)
        
        
        let GapView = UIView.init(frame: CGRect(x: 0.0 ,y: Double(EDCGap) ,width:Double(EDCScreenWidth - Gap*2) ,height: 0.5 ))
        GapView.backgroundColor = UIColor.lightGray
        CenterView.addSubview(GapView)
        
        
        let LabTitle = UILabel.init(frame: CGRect(x: 0 ,y:0 ,width:EDCScreenWidth - Gap*2 ,height: EDCGap))
        LabTitle.textAlignment = .center
        LabTitle.text = "汇汇点餐 - 几号"
        CenterView.addSubview(LabTitle)
        
        
        let TXLab = UILabel.init(frame: CGRect(x: 0 ,y:EDCGap ,width:EDCScreenWidth - Gap*2 ,height: EDCGap))
        TXLab.text = "请告知顾客使用微信或支付宝扫描二维码"
        TXLab.font = UIFont.systemFont(ofSize: 15)
        TXLab.textAlignment = .center
        CenterView.addSubview(TXLab)
        
        //二维码连接
        let Str : String  = "第三方gh76786eferjkfh1、、-0-=0《》<>【】234"
        

        let  Sweepimg  = UIImageView.init(frame: CGRect(x: Gap ,y:EDCGap*2 ,width:EDCScreenWidth - EDCGap*2 ,height: Int(CenterView.bounds.size.height) - EDCGap*2))
        CenterView.addSubview(Sweepimg)
        
        
        //异步线程
        DispatchQueue.global().async {
            
            let image = Str.generateQRCodeWithSize(size: 300)
            DispatchQueue.main.async(execute: {
                Sweepimg.image = image
            })
        }
    }
    
    
   
}
