//
//  CollectionVC_edc.swift
//  huihuiMeal
//
//  Created by edc on 2017/3/24.
//  Copyright © 2017年 edc. All rights reserved.
//

import UIKit

class CollectionVC_edc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "收款详情"
        
        view.backgroundColor = UIColor.white
        
        initUI()
    }

    
    //MARK:界面
    func initUI () {
        
        let bgImg = UIImageView.init(image: UIImage.init(named: "pic_succ"))
        bgImg.frame = CGRect(x: (EDCScreenWidth - EDCScreenWidth/5)/2, y: 60 , width: EDCScreenWidth/5 , height: EDCScreenWidth/5)
        view.addSubview(bgImg)
        
        
        let Text = UILabel.init(frame: CGRect(x: 0 , y:EDCScreenWidth/5 + 60  , width:EDCScreenWidth, height: EDCTextandBtn))
        Text.textAlignment = .center
        Text.text = "收款成功"
        view.addSubview(Text)
        
        
        let  titleName : NSArray = ["订  单  号:","消费金额:","消费时间:"]
        
        for i in 0...2 {
            
            let LabTitle  = UILabel.init(frame: CGRect(x: EDCGap , y: 240 + i*EDCBtnheight  , width: 100 , height: EDCBtnheight))
            LabTitle.text = titleName[i] as Any? as! String?
            LabTitle.font = UIFont .systemFont(ofSize: 14)
            view.addSubview(LabTitle)
            
            
            
            
            let Cellview = UIView.init(frame: CGRect(x: 0.0, y: CGFloat((i+1)*EDCBtnheight)+240 , width:CGFloat (EDCScreenWidth), height: 0.5 ))
            Cellview.backgroundColor = UIColor.lightGray
            view.addSubview(Cellview)

            let NeLab = UILabel.init(frame: CGRect(x: 120 , y: 240 + i*EDCBtnheight , width:EDCScreenWidth - 120  , height:  EDCBtnheight))
            NeLab.text = "哈哈哈哈哈哈哈爱好好"
            NeLab.font = UIFont .systemFont(ofSize: 14)
            view.addSubview(NeLab)
            
            
            if i == 2 {
                //创建返回按钮
                
                let BalckBtn = UIButton.init(frame: CGRect(x: EDCGap , y: 240 + (i+2)*EDCBtnheight , width:EDCScreenWidth - EDCGap*2  , height:  EDCTextandBtn))
                BalckBtn.setTitle("返回", for: .normal)
                BalckBtn.addTarget(self, action: #selector(BlackMain), for: .touchUpInside)
                BalckBtn.setTitleColor(UIColor.white, for: .normal)
                BalckBtn.backgroundColor = MyTextColor
                BalckBtn.layer.masksToBounds = true
                BalckBtn.layer.cornerRadius = 5
                view.addSubview(BalckBtn)
                
            }
            
        }
  
    }
    
    //MARK:返回
    func BlackMain (){
        
        
        self.navigationController?.pushViewController(SweepsPayVC_edc(), animated: true)
        
        
        //navigationController?.popViewController(animated: true)
        
    }
    
    
    //重新父类方法 （override）
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
