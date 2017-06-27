//
//  LGVController_edc.swift
//  huihuiMeal
//
//  Created by edc on 2017/3/14.
//  Copyright © 2017年 edc. All rights reserved.
//

import UIKit


class LGVController_edc: UIViewController {
    
    
       
    //MARK:背景图片
    fileprivate lazy var BGImg : UIImageView = {
        
        let BGImg = UIImageView.init(frame: self.view.bounds)
        
        BGImg.image = UIImage (named: "pic_dgc")
        
        return BGImg
    }()
    
    
    //MARK:logo图片
    fileprivate lazy var  LogoImg : UIImageView = {
        
        let logoWidth : Int = EDCScreenWidth/5
        
        let LogoImg = UIImageView.init(frame: CGRect(x: (EDCScreenWidth-logoWidth)/2 ,y: 60,width: logoWidth ,height: logoWidth))
        
        LogoImg.image = UIImage (named: "logo")
        
        return LogoImg
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        SubUI()
        
       
    }
    
    
    
    func SubUI () {
        
        view.addSubview(BGImg)
        view.addSubview(LogoImg)
        
        
            
        
        
        let SJNum : UITextField = UITextField.init(frame: CGRect(x:EDCGap ,y: Int(LogoImg.bounds.size.width + 60*2) ,width: EDCScreenWidth-EDCGap*2  ,height: EDCTextandBtn))
        SJNum.layer.cornerRadius = 5.0
        SJNum.layer.masksToBounds = true
        SJNum.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        SJNum.clearButtonMode = .whileEditing
        SJNum.font = EDCFonFSize
        SJNum.placeholder = "请输入门店编码"
        SJNum.leftView = TextLeftView(imgName: "ic_store")
        SJNum.leftViewMode = .always
        view.addSubview(SJNum)
        
       
        
        let SJnumber : UITextField = UITextField.init(frame: CGRect(x:EDCGap ,y: Int(SJNum.frame.minY + 20 + SJNum.frame.size.height) ,width: EDCScreenWidth-EDCGap*2  ,height: EDCTextandBtn))
        SJnumber.layer.cornerRadius = 5.0
        SJnumber.layer.masksToBounds = true
        SJnumber.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        SJnumber.clearButtonMode = .whileEditing
        SJnumber.font = EDCFonFSize
        SJnumber.placeholder = "请输入账号"
        SJnumber.leftView = TextLeftView(imgName: "ic_acc")
        SJnumber.leftViewMode = .always
        view.addSubview(SJnumber)

        
        
        
        let SJpaw : UITextField = UITextField.init(frame: CGRect(x:EDCGap ,y: Int(SJnumber.frame.minY + 20 + SJnumber.frame.size.height) ,width: EDCScreenWidth-EDCGap*2  ,height: EDCTextandBtn))
        SJpaw.layer.cornerRadius = 5.0
        SJpaw.layer.masksToBounds = true
        SJpaw.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        SJpaw.clearButtonMode = .whileEditing
        SJpaw.font = EDCFonFSize
        SJpaw.placeholder = "请输入密码"
        SJpaw.isSecureTextEntry = true
        SJpaw.leftView = TextLeftView(imgName: "ic_pwd")
        SJpaw.leftViewMode = .always
        view.addSubview(SJpaw)

        
        
        
        let  LGBtn = UIButton.init(frame: CGRect(x:EDCGap ,y: Int(SJpaw.frame.minY + 30*2 + SJpaw.frame.size.height) ,width: EDCScreenWidth-EDCGap*2  ,height: EDCTextandBtn))
        LGBtn.setTitle("登录", for: .normal)
        LGBtn.backgroundColor = EDCRGB(R: 93, G: 208, B: 172 ,ap: 1.0)
        LGBtn.layer.cornerRadius=5.0
        LGBtn.layer.masksToBounds=true
        LGBtn.addTarget(self, action: #selector(LgClick) , for: .touchUpInside)
        view.addSubview(LGBtn)
        
    }

    
    
    
    //MARK: 登录事件
    func LgClick () {
        
        
        UserDefaults.standard.set(1, forKey: "type")
        
        
        huihuiLG(SJNum: "", SJnumber: "", SJpwd: "")
        
    }
    
    
    //MARK:汇汇点餐登录
    func huihuiLG(SJNum : NSString, SJnumber : NSString, SJpwd : NSString ) {
        
    
        //请求参数
        //{"datas":{"stoCode":"HH00000001","login":"13812344321","pwd":"123456"}}
        
        let datas : NSMutableDictionary = NSMutableDictionary.init()
        datas .setValue("HH00000001" , forKey: "stoCode")
        datas .setValue("13812344321", forKey: "login")
        datas .setValue("123456", forKey: "pwd")
        
        let ReqData : NSMutableDictionary = NSMutableDictionary.init()
        ReqData .setObject(datas, forKey: "datas" as NSCopying)
        
        
      //  let ReqLg = NHNetworkHelper.init()
        
        //登录post请求
//        ReqLg.post(UserLG as String!, parameters: ReqData as Any! as! [AnyHashable : Any]! , success: { (respres) in
//            
//            print(respres ?? String())
//            
//        }) { (error) in
//            
//            print(error ?? String())
//        }
    
        
        
      // 登录成功后回调
       self.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    
    
    //MARK:文本框左视图
    func TextLeftView(imgName: NSString ) -> UIView {
        let leftView = UIView.init(frame: CGRect(x:0 ,y: 0 ,width: EDCTextandBtn,height: EDCTextandBtn))
        leftView.backgroundColor = EDCRGB(R: 93, G: 208, B: 172, ap: 1.0)
        
        let leftImg = UIImageView.init(frame: CGRect(x:(leftView.bounds.size.width-20)/2 ,y: (leftView.bounds.size.height-20)/2 ,width: 20, height: 20))
        
        
        leftImg.image = UIImage (named: imgName as String )
        
        leftView.addSubview(leftImg)
        
        
        return leftView
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
        
    }
    
    
    
  
    
}








