
//
//  CompletionVC_edc.swift
//  huihuiMeal
//
//  Created by edc on 2017/3/17.
//  Copyright © 2017年 edc. All rights reserved.
//

import UIKit

class CompletionVC_edc: UIViewController {

    
    //已点数据
    var DataSource = NSMutableArray.init()
    var num : Int = 0
    var Mytitle : NSString?
    var MyScrView = UIScrollView.init()

    //计算金额
    var Sum : CGFloat = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "已点菜单"
        
        view.backgroundColor = EDCRGB(R: 241, G: 241, B: 241, ap: 1.0)
   
        SubUI()
    }

   
    //MARK:视图
    func SubUI () {
        
        let TableNumber = UILabel.init(frame: CGRect(x: Gap, y: 10, width:EDCScreenWidth/2-Gap, height: Gap))
        TableNumber.text = String.init(format: "桌号: %@", (Mytitle as String?)!)
        TableNumber.font = UIFont .systemFont(ofSize: 15)
        view.addSubview(TableNumber)
        
        
        
        let Num = UILabel.init(frame: CGRect(x: EDCScreenWidth/2, y: 10 , width:EDCScreenWidth/2, height: Gap))
        Num.text = String.init(format: "人数: 4人")
        Num.font = UIFont .systemFont(ofSize: 15)
        view.addSubview(Num)

        
        
        let OrderNum = UILabel.init(frame: CGRect(x: Gap, y: Gap*2 , width:EDCScreenWidth-Gap, height: Gap))
        OrderNum.text = String.init(format: "单号: 2345353453454%@", (Mytitle as String?)!)
        OrderNum.font = UIFont .systemFont(ofSize: 15)
        view.addSubview(OrderNum)
        
        
        
        let OrderTime = UILabel.init(frame: CGRect(x: Gap, y: Gap*3+10, width:EDCScreenWidth-Gap, height: Gap))
        OrderTime.text = String.init(format: "时间: 2017/3/21  15:02")
        OrderTime.font = UIFont .systemFont(ofSize: 15)
        view.addSubview(OrderTime)
        
        
        MyScrView .frame = CGRect(x: 0, y: 100 , width:EDCScreenWidth, height: EDCScreenHeight-100-64)
        MyScrView.contentSize = CGSize.init(width: EDCScreenWidth, height: EDCTextandBtn*(DataSource.count+4) + 10)
        MyScrView.backgroundColor = UIColor.white
        view.addSubview(MyScrView)
        
    
        OrderView()
    }

    
    //MARK:订单数据
    func OrderView () {
        
  
        for subview in MyScrView.subviews{
            
            subview.removeFromSuperview()
        }
     
        
        if DataSource.count==0 {
            LCProgressHUD.hide()
            return
        }
        
         var sum : CGFloat = 0
        
        for i in 0..<DataSource.count {

            
            let SubView = UIView.init(frame: CGRect(x: 0, y: Int((i)*EDCTextandBtn) , width:EDCScreenWidth, height: EDCTextandBtn ))
            SubView.backgroundColor = UIColor.white
            MyScrView.addSubview(SubView)
            
            let model : DishModel_edc = DataSource[i] as! DishModel_edc
            
            
            
            let TitleName = UILabel.init(frame: CGRect(x: Gap, y: 0 , width:EDCScreenWidth/2-Gap, height: EDCTextandBtn))
            TitleName.textColor = UIColor.black
            TitleName.font = UIFont.systemFont(ofSize: 15)
            TitleName.text = String.init(format: "%d. %@",i+1, model.VegeName! )
            SubView.addSubview(TitleName)
            
            let MoneyLab = UILabel.init(frame: CGRect(x: EDCScreenWidth/2, y: 0, width:Gap*2, height: EDCTextandBtn ))
            MoneyLab.font = UIFont .systemFont(ofSize: 15)
            MoneyLab.textColor = MyTextColor
            MoneyLab.text = String.init(format: "¥%@", model.Money!)
            SubView.addSubview(MoneyLab)
            
            
            let Reducing = UIButton.init(frame: CGRect(x: EDCScreenWidth - Gap*2 - iconWidth*2, y: (EDCTextandBtn-iconWidth)/2, width:iconWidth, height: iconWidth ))
            Reducing.tag = model.VageId!
            Reducing.addTarget(self, action: #selector(sub), for: .touchUpInside)
            Reducing.setImage(UIImage (named: "ic_sub"), for: .normal)
            SubView.addSubview(Reducing)
            
            
            
            let numLab = UILabel.init(frame: CGRect(x: EDCScreenWidth - Gap*2 - iconWidth , y: 0, width: Gap, height: EDCTextandBtn ))
            numLab.text = String.init(format: "%d", model.OrderCount!)
            numLab.textAlignment = .center
            numLab.font = UIFont .systemFont(ofSize: 12)
            SubView.addSubview(numLab)
            
            
            
            let Canada = UIButton.init(frame: CGRect(x: EDCScreenWidth - Gap - iconWidth ,y: (EDCTextandBtn-iconWidth)/2 , width:iconWidth, height: iconWidth ))
            Canada.tag = model.VageId!
            Canada.addTarget(self, action: #selector(add), for: .touchUpInside)
            Canada.setImage(UIImage (named: "ic_add"), for: .normal)
            SubView.addSubview(Canada)
            
            
            
            let Cellview = UIView.init(frame: CGRect(x: 0.0, y: 43.5 , width:CGFloat (EDCScreenWidth), height: 0.5 ))
            Cellview.backgroundColor = UIColor.lightGray
            SubView.addSubview(Cellview)

            
            let OrderCount : Int = model.OrderCount!
            
            let OrderMoney : CGFloat = StringToFloat(str: model.Money! )
            
            let subSum : CGFloat   =  +CGFloat(CGFloat(OrderCount) * OrderMoney)
            
            sum  = sum + subSum
            
            
            if i == DataSource.count-1 {
                
                Sum = sum
            
    
                let Sumtotal = UILabel.init(frame: CGRect(x: Gap, y: Int((i+1)*EDCTextandBtn) , width:EDCScreenWidth/2-Gap , height: EDCTextandBtn ))
                Sumtotal.text = String.init(format: "合计： %d", DataSource.count)
                Sumtotal.font = UIFont.systemFont(ofSize: 13)
                MyScrView.addSubview(Sumtotal)
                
                
                let TotalAmount = UILabel.init(frame: CGRect(x: EDCScreenWidth/2, y: Int((i+1)*EDCTextandBtn) , width:EDCScreenWidth/2-Gap, height: EDCTextandBtn))
                TotalAmount.textAlignment = .right
                TotalAmount.textColor = EDCRGB(R: 181, G: 166, B: 244, ap: 1.0)
                TotalAmount.font = UIFont.systemFont(ofSize: 15)
                TotalAmount.text = String.init(format: "¥ %.2f", Sum)
                MyScrView.addSubview(TotalAmount)
                

                
                let Cellview = UIView.init(frame: CGRect(x: 0.0, y: CGFloat((i+1)*EDCTextandBtn)+43.5 , width:CGFloat (EDCScreenWidth), height: 0.5 ))
                Cellview.backgroundColor = UIColor.lightGray
                MyScrView.addSubview(Cellview)
                
                
                
                let NextBtn = UIButton.init(frame: CGRect(x: Gap, y: Int((i+4)*EDCTextandBtn) , width:EDCScreenWidth - Gap*2, height: EDCTextandBtn ))
                NextBtn.setTitle("下单", for: .normal)
                NextBtn.layer.masksToBounds = true
                NextBtn.layer.cornerRadius = 5
                NextBtn.addTarget(self, action: #selector(ComNextClick), for: .touchUpInside)
                NextBtn.setTitleColor(UIColor.white, for: .normal)
                NextBtn.backgroundColor = EDCRGB(R: 93, G: 208, B: 171, ap: 1.0)
                MyScrView.addSubview(NextBtn)
            }
            
        }
    }
    
    
    //MARK:添加
    func add (btn: UIButton) {
        
      CominClick(VageId: btn.tag, flag: true)
    }
    
    
    //MARK:减单
    func sub (btn: UIButton) {
        
      CominClick(VageId: btn.tag, flag: false)
    }
    
    
    //MARK:点餐
    func CominClick(VageId: Int , flag : Bool ) {
        
        //查找该菜品的id
        for model in DataSource {
            
            if  (model as! DishModel_edc).VageId! == VageId  {
                
                //添加数量
                if flag {
            
                  (model as! DishModel_edc).OrderCount! = (model as! DishModel_edc).OrderCount!  + 1
                    
                }else{
                    
                    (model as! DishModel_edc).OrderCount! = (model as! DishModel_edc).OrderCount! - 1
                    
                    if (model as! DishModel_edc).OrderCount! == 0 {
                        
                       DataSource .remove(model)
                    }
                }
                //刷新数据
                OrderView()
                return
            }
        }
        
    }
    
    
    //MARK:下单 (请求接口)
    func ComNextClick () {
        

        
        //收款成功
        self.navigationController?.pushViewController(CollectionVC_edc(), animated: true)
        
//        
//        LCProgressHUD.showSuccess("下单成功")
//        
//        navigationController?.popToRootViewController(animated: true)
    }
    

}
