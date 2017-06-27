//
//  MainVController_edc.swift
//  huihuiMeal
//
//  Created by edc on 2017/3/14.
//  Copyright © 2017年 edc. All rights reserved.
//

import UIKit

class MainVController_edc: UIViewController,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    var SelectBtn : UIButton = UIButton.init()
    var SelectView : UIView = UIView.init()
    var LGStar : Int = 0
    
  
    let Textwidth : Int = 50
    fileprivate lazy  var MyScrView = UIScrollView.init()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = EDCRGB(R: 247, G: 247, B: 247, ap: 1.0)
        
        TopView()
        
//        UserDefaults.standard.set(0, forKey: "type")
        
        SubUI()

        
        //设置导航栏背景图片
        // self.navigationController?.navigationBar.setBackgroundImage(UIImage (named: "ic_add"), for: .default)
        
       //设置是否半透明
       //self.navigationController?.navigationBar.isTranslucent  = true
     
       //隐藏导航栏
       //self.navigationController?.isNavigationBarHidden = true
        
       //导航栏提示语
       // self.navigationItem.prompt = "正在观看"
    }
    
    

    override func viewWillAppear(_ animated: Bool) {

//        let LGNum : Int = UserDefaults.standard.object(forKey: "type") as! Int
//        if  LGNum == 0 {
//            
//            self.present(LGVController_edc(), animated: true, completion: nil)
//        }
        
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName :UIFont .systemFont(ofSize: 18),];
        
        //导航栏是否透明
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.navigationController?.navigationBar.tintColor = UIColor.white

        self.navigationController?.navigationBar.barTintColor = UIColor.black
        
//        self.navigationController?.navigationBar.barTintColor = EDCRGB(R: 85, G: 173, B: 252, ap: 1.0)
    }
    
    
    //MARK:顶部视图
    func TopView () {
        
        let topView : UIView = UIView.init(frame: CGRect(x: 0, y: 0 , width:EDCScreenWidth, height: EDCTextandBtn))
        topView.backgroundColor=UIColor.white
        topView.layer.borderWidth=0.5
        topView.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(topView)
        
        
        SelectView = UIView.init(frame: CGRect(x: 0, y: EDCTextandBtn-2, width:EDCScreenWidth/3 , height: 2))
        SelectView.backgroundColor = UIColor.green
        topView.addSubview(SelectView)
        
        
        let btnTitleAry = ["全部","大厅","包厢",]
        
        let textAry = ["预定","占用","空闲",]
        
        let ClolcAry = [ #colorLiteral(red: 0.3607843137, green: 0.8078431373, blue: 0.7764705882, alpha: 1),#colorLiteral(red: 0.4745098039, green: 0.7215686275, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)];
        
        
        for i in 0...2{
            
            let btn : UIButton = UIButton.init(frame: CGRect(x: i*(EDCScreenWidth/3) , y: 0 , width:EDCScreenWidth/3, height: EDCTextandBtn))
            btn.tag = 100+i
            btn.titleLabel?.font = UIFont .systemFont(ofSize: 16)
            btn.setTitle(btnTitleAry[i], for: .normal)
            btn.setTitleColor(TextColor, for: .normal)
            btn.setTitleColor(UIColor.green, for: .selected)
            btn.addTarget(self, action: #selector(topBtnClick), for: .touchUpInside)
            topView.addSubview(btn)
            
            if i == 0 {
                
                SelectBtn = btn
                SelectBtn.isSelected = true
            }
            
            let text = UILabel.init(frame: CGRect(x:(EDCScreenWidth - Textwidth - 10) - i*(Textwidth + 10), y: EDCTextandBtn+12, width: Textwidth, height: 20 ))
            text.font = UIFont .systemFont(ofSize: 13)
            text.text = textAry[i]
            text.textAlignment = .right
            text.textColor = TextColor
            text.backgroundColor = UIColor.clear
            view.addSubview(text)
            
            let iconView = UIView.init(frame: CGRect(x: 0 ,y: 2.5,width: 15 ,height: 15))
            iconView.backgroundColor = ClolcAry[i]
            text.addSubview(iconView)
            
        }
        
    }
    
    
    
    //MARK:UIScrollViewDelegate
    
    //滚动结束回调
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        
        if scrollView == MyScrView {
            
            let contentoffset : Int = Int(scrollView.contentOffset.x)
            let numOfTable : Int = Int(contentoffset/EDCScreenWidth)
            
            let btn = self.view.viewWithTag(100+numOfTable)
        
            
            topBtnClick(btn: btn as! UIButton)
        }
    }
    
    
    
    
    
    //MARK:点击切换
    func topBtnClick (btn : UIButton ) {
        
        if SelectBtn==btn {
            return;
        }
        
        SelectBtn.isSelected = false
        SelectBtn = btn
        SelectBtn.isSelected = true
        
        //SelectBtn.setTitleColor(MyTextColor, for: .normal)
       // SelectBtn.setTitleColor(TetxClolc, for: .selected)
        
    
        
        MyScrView.setContentOffset(CGPoint(x: EDCScreenWidth*(btn.tag-100), y: 0), animated: true)
        
        //添加动画
        UIView.animate(withDuration: 0.3) {
            
            self.SelectView.frame = CGRect(x: EDCScreenWidth/3*(btn.tag-100),y:  EDCTextandBtn-2, width: EDCScreenWidth/3,height: 2)
        }
        
    }
    
    
    
    //MARK:子视图
    func SubUI () {
        
        title = "桌台列表"
        
       
        //OneCollView = UICollectionView.init(frame:CGRect(x: EDCScreenWidth/3*(btn.tag-100),y:  EDCTextandBtn-1, width: EDCScreenWidth/3,height: 1))
        
        
        MyScrView = UIScrollView.init(frame: CGRect(x: 0, y: EDCTextandBtn*2 , width:EDCScreenWidth, height: EDCScreenHeight-EDCTextandBtn*2-64))
        
        MyScrView.delegate = self
        MyScrView.backgroundColor = EDCRGB(R: 247, G: 247, B: 247, ap: 1.0)
        MyScrView.isPagingEnabled = true
        MyScrView.showsHorizontalScrollIndicator = false
        MyScrView.bounces = false
        MyScrView.contentSize = CGSize(width: EDCScreenWidth*3, height: EDCScreenHeight-EDCTextandBtn*2-64)
        view.addSubview(MyScrView)
        
        
        let CollLayout = UICollectionViewFlowLayout()
        CollLayout.itemSize=CGSize(width: (EDCScreenWidth-30)/3,height: EDCScreenWidth/5)
        CollLayout.sectionInset=UIEdgeInsetsMake(5,5, 5, 5)
        
        
        
        let OneCollView = UICollectionView.init(frame: CGRect(x: 0, y: 0 , width:EDCScreenWidth, height: Int(MyScrView.bounds.size.height)), collectionViewLayout: CollLayout)
        OneCollView.delegate = self
        OneCollView.dataSource = self
        OneCollView.showsVerticalScrollIndicator = false
        OneCollView.backgroundColor = UIColor.clear
        MyScrView.addSubview(OneCollView)
        
        
        //注册
        OneCollView.register(UINib(nibName: "TaiwanCollectVCell_edc", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage (named: "ic_set"), style: .plain, target: self, action: #selector(Setting))
        
    }
    
    
    
    //MARK:开台
    func Original(num: Int ) {
        
        
        var  AlertTitle = ""
        var  MealTitle = ""
        
        
        if num < 10 {
            AlertTitle = ("0\(num)号桌开台" as NSString) as String
            MealTitle = ("0\(num)号桌" as NSString) as String
            
        }else{
            AlertTitle = ("\(num)号桌开台" as NSString) as String
            MealTitle = ("\(num)号桌" as NSString) as String
        }
        
        
        
        let AlertView = UIAlertController.init(title: AlertTitle as String, message: "顾客人数", preferredStyle: .alert)
        
        AlertView.addTextField { (numText) in
            
            numText.keyboardType = .numberPad
            numText.placeholder = "请输入用餐人数"
            
        }

        
        let AlertAct = UIAlertAction.init(title: "确定", style: .default) { (AlertAct)
            in
            
            let NumText = (AlertView.textFields?.first)! as UITextField
            
            //获取文本框数据
            let Strnum : NSString = NumText.text as NSString? ?? NSString()
            
            //非空验证
            if Strnum != "" {
                
                //类型装换
                let Num : Int = Int(Strnum as String)!
                
                
                if  Num > 0 {
                    
                    let MealVC = MealVController_edc()
                    MealVC.MYTitle = MealTitle as NSString?
                    
                    print(MealVC.Balck(x: "EDC", y: "gsfsd"))
            
                    
                    self.navigationController?.pushViewController(MealVC, animated: true)
                    
                }else{
                    
                    print("请输入正确的用餐人数")
                }
                
                
            }else{
                
                print("内容不能为空")
            }
        
        }
        
        
        
        let AlertAct2 = UIAlertAction.init(title: "取消", style: .default) { (AlertAct2) in
        }
        
        AlertView.addAction(AlertAct2)
        AlertView.addAction(AlertAct)
       
        //模态跳转
        present(AlertView, animated: true, completion: nil )
        
    }
    
    
    //MARK:设置
    func Setting () {
        
        self.navigationController?.pushViewController(SetVController_edc() , animated: true)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 34
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:TaiwanCollectVCell_edc = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TaiwanCollectVCell_edc
        
        
        cell.backgroundColor = UIColor.clear
        
        cell.setCell()
        
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
      //  print(indexPath.row)
        
        Original(num: indexPath.row + 1)
        
        
    }
    
    
    
    
    
}

















