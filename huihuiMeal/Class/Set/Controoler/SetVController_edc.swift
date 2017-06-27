//
//  SetVController_edc.swift
//  huihuiMeal
//
//  Created by edc on 2017/3/15.
//  Copyright © 2017年 edc. All rights reserved.
//

import UIKit

class SetVController_edc: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var TabText = ["我的门店","我的账号","蓝牙打印","检查更新"]
    

    
    
    //MARK:懒加载表格
    private lazy var SetTab : UITableView = {
    
        let tab = UITableView.init(frame: CGRect(x: 0, y: 0 , width:EDCScreenWidth, height: EDCScreenHeight ), style: .grouped)
        
        tab.dataSource = self
        tab.delegate = self
        
        tab.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        return tab
    }()
    
    
    
    
    //MARK:UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       // var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "cell")
            
  
        
        cell.textLabel?.text = TabText[indexPath.row]
        cell.selectionStyle = .none
        cell.textLabel?.font = UIFont .systemFont(ofSize: 15)
       
        
        if indexPath.row == 2 {
            
            
            if cell.contentView.subviews.count == 1 {
                
                
                let SwOpne = UISwitch.init(frame: CGRect(x: EDCScreenWidth-70,y: 8 ,width:60  ,height: 20))
                //  SwOpne.onTintColor = UIColor.blue
                SwOpne.onImage = UIImage (named: "pic_close")
                SwOpne.addTarget(self, action: #selector(SwClick), for: .editingChanged)
                cell.contentView.addSubview(SwOpne)
                
            }
        }
        
        
        if indexPath.row==0 {
            
            cell.detailTextLabel?.text = "好味道"
            
        }
        
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "设置"
        view.backgroundColor = UIColor.yellow
        
        view.addSubview(SetTab)
        
        
        
        let TabFooterView = UIView.init(frame: CGRect(x:0,y:0,width: EDCScreenWidth ,height:260))
        TabFooterView.backgroundColor=UIColor.clear
        SetTab.tableFooterView=TabFooterView
        
        
        let BlackBtn = UIButton.init(frame:CGRect(x:20,y:260 - EDCTextandBtn,width:EDCScreenWidth - 40,height: EDCTextandBtn))
        
        BlackBtn .setTitle("退出登录", for: .normal)
        BlackBtn.backgroundColor=#colorLiteral(red: 0.3607843137, green: 0.8078431373, blue: 0.7764705882, alpha: 1)
        BlackBtn.titleLabel?.tintColor=UIColor.white
        BlackBtn.layer.masksToBounds=true
        BlackBtn.layer.cornerRadius=5
        
        
        BlackBtn.layer.rasterizationScale=5
        
        BlackBtn.addTarget(self, action: #selector(BlackClick), for: .touchUpInside)
        
        TabFooterView.addSubview(BlackBtn)

        
    }

    
    //MARK:蓝牙打印
    func SwClick (Swop : UISwitch){
        
        
        if Swop.isOn {
            
            print("开")
            
        }else{
            
            print("关")
        }
    }
    
    
    func BlackClick (){
        

        let AlertView = UIAlertController.init(title: "提示", message: "确定退出账号", preferredStyle: .alert)
        
        let AlertAct = UIAlertAction.init(title: "确定", style: .default) { (AlertAct)
            in
        
            
           // UserDefaults.standard.removeObject(forKey: "type")
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
        
        
        let AlertAct2 = UIAlertAction.init(title: "取消", style: .default) { (AlertAct2) in
            
            print("取消")
            
        }
        
        
     
        AlertView.addAction(AlertAct2)
        AlertView.addAction(AlertAct)
        
        //模态跳转
        present(AlertView, animated: true, completion: nil )
        

        
    }
    
    
    
    
}
