//
//  MealVController_edc.swift
//  huihuiMeal
//
//  Created by edc on 2017/3/15.
//  Copyright © 2017年 edc. All rights reserved.
//

import UIKit


typealias SwiftClosure = (_ name:String,_ age:Int) -> Void


class MealVController_edc: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var MYTitle : NSString?
    var SelectBtn = UIButton.init()
    let LeftTabWidth = 90
    let LeftnumberOfRows = 9
    var OrderCount : UILabel = UILabel.init()
    var OrderNum : Int = 0
    //计算金额
    var Sum : CGFloat = 0
    
    
    fileprivate lazy  var RightDataSource : NSMutableArray = NSMutableArray.init()
    fileprivate lazy  var LeftDataSource : NSMutableArray = NSMutableArray.init()
    var AlreadyAry : NSMutableArray = NSMutableArray.init()
    
    
    fileprivate var PayView : UIView = UIView.init()
    fileprivate var Menu : UIButton = UIButton.init()
    fileprivate var NextList : UIButton = UIButton.init()
    fileprivate var SumMoney : UILabel = UILabel.init()
    fileprivate var NodataImg : UIImageView = UIImageView.init()
    fileprivate var CollectionleBtn : UIButton = UIButton.init()
    fileprivate var CollectionriBtn : UIButton = UIButton.init()
    
    
    fileprivate var selectIndex = 0
    fileprivate var isScrollDown = true
    fileprivate var lastOffsetY : CGFloat = 0.0
    
    
    //MARK:懒加载滚动视图
    fileprivate lazy var MealScrView : UIScrollView = {
        
        let  MyScrView = UIScrollView.init(frame: CGRect(x: 0, y: EDCTextandBtn, width:EDCScreenWidth, height: EDCScreenHeight-EDCTextandBtn-64))
        
        MyScrView.delegate = self
        MyScrView.backgroundColor = EDCRGB(R: 247, G: 247, B: 247, ap: 1.0)
        MyScrView.isPagingEnabled = true
        MyScrView.showsHorizontalScrollIndicator = false
        MyScrView.bounces = false
        MyScrView.contentSize = CGSize(width: EDCScreenWidth*2, height: EDCScreenHeight-EDCTextandBtn*2-64)
        
        return MyScrView
        
    }()
    
    
    //MARK:懒加载左右表格
     fileprivate lazy var leftTab : UITableView = {
        
        let leftTab = UITableView.init(frame: CGRect(x:0 ,y: 0,width:self.LeftTabWidth ,height: EDCScreenHeight - EDCTextandBtn - 64 - 49))
        //  UIEdgeInsetsZero
        //表格cell线左对齐
        leftTab.separatorInset = UIEdgeInsets.zero
        leftTab.layoutMargins = UIEdgeInsets.zero
        leftTab.cellLayoutMarginsFollowReadableWidth = false
        
        //去除tableView 多余行的方法 添加一个tableFooterView 后面多余行不再显示
        leftTab.tableFooterView = UIView()
        
        leftTab.delegate = self
        leftTab.dataSource = self
        leftTab.rowHeight = CGFloat(leftTabHeight)
        //leftTab.separatorColor = UIColor.clear
        leftTab.register(LeftTableViewCell_edc.self, forCellReuseIdentifier: LeftCellIdentifier)
        
        return leftTab
    }()
    
    
    fileprivate lazy var RightTab : UITableView = {
        
        let RightTab = UITableView.init(frame: CGRect(x: self.LeftTabWidth ,y: 0 ,width: EDCScreenWidth - self.LeftTabWidth ,height: EDCScreenHeight - EDCTextandBtn - 64 - 49))
        
        RightTab.delegate = self
        RightTab.dataSource = self
        RightTab.rowHeight = 100
        RightTab.register(RightTableViewCell_edc.self, forCellReuseIdentifier: RightCellIdentifier)
        // RightTab.register(UINib.init(nibName: "RightTabVCell_edc", bundle: nil), forCellReuseIdentifier: RightCellIdentifier)
        
        RightTab.backgroundColor = UIColor.clear
        
        return RightTab
    }()
    
    
    fileprivate lazy var ButtonView : UIView = {
        
        let ButtonView = UIView.init(frame: CGRect(x: 0 ,y: EDCScreenHeight-EDCTextandBtn - 64 - 49 ,width: EDCScreenWidth ,height: 49))
        ButtonView.backgroundColor = UIColor.white
        // ButtonView.layer.borderWidth=0.5
        // ButtonView.layer.borderColor = UIColor.lightGray.cgColor
        return ButtonView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureData()
        
        SubUI()
        
        let notificationName = Notification.Name(rawValue: "MealNot")
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(MealNot),
                                               name: notificationName, object: nil)
    }
    
    //MARK:接收通知 (点菜)
    func MealNot (Not : Notification) {
        
        let Mealcell : RightTableViewCell_edc = (Not.userInfo!["RightTableViewCell"] as!  RightTableViewCell_edc?)!
        //        let VegeId : Int = Not.userInfo!["VegeId"] as! Int
        //        let orderCount : Int = Not.userInfo!["OreDerId"] as! Int
        //        let type : Int = Not.userInfo!["typeB"] as! Int
        
        for DishModel  in RightDataSource{
            
            // 数据源找到该id菜
            if Mealcell.CellModel.VageId ==  (DishModel as! DishModel_edc).VageId{
                
                (DishModel as! DishModel_edc) .OrderCount = Mealcell.Quantity
                
                AlreadyAry.remove(DishModel)
                
                if Mealcell.Quantity > 0 {
                    
                    AlreadyAry.add(DishModel)
                }
                
                break
            }
            
        }
        
        //添加动画
        if Mealcell.typeB! {
            
            OrderNum += 1
            
            let point :CGPoint = Mealcell.convert(Mealcell.CanadaBtn.center, to: view)
            //动画开始坐标
            MealAnimation(Starpoint: point)
            
        }else{
            
            OrderNum -= 1
            
            //刷新购物车数据
            ShoppingData(AlreaData: AlreadyAry)
        }
    }
    
    
    
    func Balck(x: String,y: String ) -> String {
        
        return x + y
        
    }
    
    
    //MARK:点餐动画(动画路径)
    func MealAnimation (Starpoint :CGPoint) {
        
        //结束坐标
        let endPoint = ButtonView.convert(Menu.center, to: view)
        
        //过渡坐标
        let CenterPoint : CGPoint = CGPoint.init(x: Starpoint.x-50, y: endPoint.x-50)
        
        //创建贝塞尔曲线
        let path :UIBezierPath = UIBezierPath.init()
        path .move(to: Starpoint)
        path .addCurve(to: endPoint, controlPoint1: Starpoint, controlPoint2: CenterPoint)
        
        //图层
        let layer = CALayer.init()
        layer.frame = CGRect(x: -50,y:0 ,width:20,height:20)
        layer.backgroundColor = EDCRGB(R: 181, G: 166, B: 244, ap: 1.0).cgColor
        layer.cornerRadius = 20/2
        view.layer.addSublayer(layer)
        
        //添加动画
        let CakeyAnimation : CAKeyframeAnimation = CAKeyframeAnimation.init(keyPath: "position")
        CakeyAnimation.duration = 0.5
        CakeyAnimation.path = path.cgPath
        
        layer.add(CakeyAnimation, forKey: nil)
        
        //刷新购物车数据
        ShoppingData(AlreaData: AlreadyAry)
        
        self.perform(#selector(finishAnimation), with: layer, afterDelay: 1.0)
    }
    
    //MARK:动画结束
    func finishAnimation (layer : CALayer) {
        
        layer.removeFromSuperlayer()
    }
    
    
    
    //MARK:购物车数据
    func ShoppingData(AlreaData: NSMutableArray) {
        
        if AlreadyAry.count > 0 {
            
            NextList.backgroundColor = EDCRGB(R: 181, G: 166, B: 244, ap: 1.0)
            NextList.setTitleColor(UIColor.white, for: .normal)
            NextList.isEnabled = true
            
            var sum : CGFloat = 0
            var Order : Int = 0
            
            
            for Model in AlreadyAry {
                
                let OrderCount : Int = (Model as! DishModel_edc).OrderCount!
                
                let OrderMoney : CGFloat = StringToFloat(str: ((Model as! DishModel_edc).Money)!)
                
                let subSum : CGFloat   =  +CGFloat(CGFloat(OrderCount) * OrderMoney)
                
                sum  = sum + subSum
                
                Order = Order + OrderCount
            }
            
            Sum = sum
            OrderNum = Order
            
            
            SumMoney.text =  String.init(format: "¥%.2f", Sum)
            
            //菜单角标
            OrderCount.text = "\(OrderNum)"
            
        }else{
            
            NextList.isEnabled = false
            SumMoney.text =  "¥0.00"
            OrderCount.text = "0"
            NextList.backgroundColor = EDCRGB(R: 229, G: 229, B: 229, ap: 1.0)
            NextList.setTitleColor(UIColor.lightGray, for: .normal)
        }
    }
    
    
    //MARK:(刷新数据)开始加载视图
    override func viewWillAppear(_ animated: Bool) {
        
        RightTab.reloadData()
        ShoppingData(AlreaData: AlreadyAry)
        
    }
    
    
    //MARK:子视图
    func SubUI () {
        
        title = MYTitle as String?
        view.backgroundColor = UIColor.white
        
        MealTopView()
        view.addSubview(MealScrView)
        MealScrView.addSubview(leftTab)
        MealScrView.addSubview(RightTab)
        MealScrView.addSubview(ButtonView)
        MealButtonView()
        PayRightView()
        
        leftTab.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
    }
    
    
    
    
    //MARK:结账单View
    func PayRightView () {
        
        PayView.frame = CGRect(x: EDCScreenWidth ,y: 0 ,width:EDCScreenWidth ,height: EDCScreenHeight - 64 - EDCTextandBtn)
        PayView.backgroundColor = UIColor.white
        MealScrView.addSubview(PayView)
        
        
        NodataImg = UIImageView.init(image: UIImage (named: "NOdata"))
        NodataImg.frame =  CGRect(x: (EDCScreenWidth-100)/2 ,y: (EDCScreenHeight - 64 - 127 - EDCTextandBtn)/2  ,width:100 ,height: 127)
        PayView.addSubview(NodataImg)
        
        
        CollectionleBtn.frame = CGRect(x: 0 ,y: Int(PayView.bounds.size.height - CGFloat(49)) ,width:EDCScreenWidth/2 ,height: 49)
        CollectionleBtn.setTitle("付款码收款", for: .normal)
        CollectionleBtn.backgroundColor = MyTextColor
        CollectionleBtn.tag = 10000
        CollectionleBtn.addTarget(self, action: #selector(SweepsPay), for: .touchUpInside)
        CollectionleBtn.isHidden = true
        CollectionleBtn.setTitleColor(UIColor.white, for: .normal)
        PayView.addSubview(CollectionleBtn)
        
        
        CollectionriBtn.frame = CGRect(x: EDCScreenWidth/2,y: Int(PayView.bounds.size.height - CGFloat(49)) ,width:EDCScreenWidth/2 ,height: 49)
        CollectionriBtn.setTitle("二维码收款", for: .normal)
        CollectionriBtn.addTarget(self, action: #selector(SweepsPay), for: .touchUpInside)
        CollectionriBtn.tag = 10001
        CollectionriBtn.isHidden = true
        CollectionriBtn.backgroundColor = EDCRGB(R: 68, G: 170, B: 137, ap: 1.0)
        CollectionriBtn.setTitleColor(UIColor.white, for: .normal)
        PayView.addSubview(CollectionriBtn)
    }
    
    
    //MARK:二维码收款
    func SweepsPay (btn : UIButton)  {
        
        if btn.tag == 10000 {
            
            self.navigationController?.pushViewController(ScanningVC_edc(), animated: true)
            
        }else{
            
            self.navigationController?.pushViewController(SweepsPayVC_edc(), animated: true)
        }
    }
    
    
    //MARK:底部视图
    func MealButtonView () {
        
        Menu.frame = CGRect(x: 20,y: -15 ,width: 60,height: 60)
        Menu.layer.masksToBounds = true
        Menu.backgroundColor = MyTextColor
        Menu.layer.cornerRadius = 60/2
        Menu.setImage(UIImage (named: "ic_project"), for: .normal)
        Menu.addTarget(self, action: #selector(MenuClick), for: .touchUpInside)
        ButtonView.addSubview(Menu)
        
        
        
        OrderCount.frame = CGRect(x: 80-18 ,y: -10 ,width: 18,height: 18)
        OrderCount.layer.cornerRadius = 9
        OrderCount.layer.masksToBounds = true
        OrderCount.backgroundColor =  EDCRGB(R: 181, G: 166, B: 244, ap: 1.0)
        OrderCount.textColor = UIColor.white
        OrderCount.text = "0"
        OrderCount.textAlignment = .center
        OrderCount.font = UIFont .systemFont(ofSize: 12)
        ButtonView.addSubview(OrderCount)
        
        
        
        
        NextList.frame = CGRect(x: EDCScreenWidth-EDCScreenWidth/3 ,y: 0 ,width: EDCScreenWidth/3,height: 49)
        NextList.setTitle("下单", for: .normal)
        NextList.addTarget(self, action: #selector(NextLsitClick), for: .touchUpInside)
        NextList.isEnabled = false
        NextList.backgroundColor = EDCRGB(R: 229, G: 229, B: 229, ap: 1.0)
        NextList.setTitleColor(UIColor.lightGray, for: .normal)
        ButtonView.addSubview(NextList)
        
        
        SumMoney .frame = CGRect(x: Int(Menu.bounds.maxX + 40),y: 0 ,width: EDCScreenWidth/3 ,height: 49)
        SumMoney.text = "¥\(0.00)"
        SumMoney.font = UIFont .systemFont(ofSize: 18)
        SumMoney.textColor = EDCRGB(R: 181, G: 166, B: 244, ap: 1.0)
        ButtonView.addSubview(SumMoney)
    }
    
    
    //MARK:菜单点击事件
    func MenuClick (){
        
        if AlreadyAry.count > 0 {
            
            let Compl = CompletionVC_edc()
            Compl.DataSource = AlreadyAry
            Compl.Mytitle = title as NSString?
            self.navigationController?.pushViewController(Compl, animated: true)
            
        }else{
            
            LCProgressHUD.showInfoMsg("请点菜")
        }
        
    }
    
    
    //MARK:下单 （请求接口）
    func NextLsitClick (){
        
        //查找当前tag为101的视图
        let btn = self.view.viewWithTag(101)
        MealtopBtnClick(btn: btn as! UIButton)
        
        
        //请求接口下单接口
        
        LCProgressHUD.showSuccess("下单成功")
        
        
        configureData()
        AlreadyAry .removeAllObjects()
        RightTab.reloadData()
        
        
        
        PayingupView()
    }
    
    
    //MARK: 下单成功（结账单）
    func  PayingupView ()  {
        
        //隐藏图片
        NodataImg.isHidden = true
        CollectionleBtn.isHidden = false
        CollectionriBtn.isHidden = false
        
        
        
        let TableNumber = UILabel.init(frame: CGRect(x: Gap, y: 10, width:EDCScreenWidth/2-Gap, height: Gap))
        TableNumber.text = String.init(format: "桌号: %@", (title as String?)!)
        TableNumber.font = UIFont .systemFont(ofSize: 15)
        PayView.addSubview(TableNumber)
        
        
        
        let Num = UILabel.init(frame: CGRect(x: EDCScreenWidth/2, y: 10 , width:EDCScreenWidth/2, height: Gap))
        Num.text = String.init(format: "人数: 4人")
        Num.font = UIFont .systemFont(ofSize: 15)
        PayView.addSubview(Num)
        
        
        
        let OrderNum = UILabel.init(frame: CGRect(x: Gap, y: Gap*2 , width:EDCScreenWidth-Gap, height: Gap))
        OrderNum.text = String.init(format: "单号: 2345353453454")
        OrderNum.font = UIFont .systemFont(ofSize: 15)
        PayView.addSubview(OrderNum)
        
        
        
        let OrderTime = UILabel.init(frame: CGRect(x: Gap, y: Gap*3+10, width:EDCScreenWidth-Gap, height: Gap))
        OrderTime.text = String.init(format: "时间: 2017/3/21  15:02")
        OrderTime.font = UIFont .systemFont(ofSize: 15)
        PayView.addSubview(OrderTime)
        
        
        //  let OrderScrView = UIScrollView.init(frame:  CGRect(x: 0, y: 100 , width:EDCScreenWidth, height: EDCScreenHeight-100-64))
        //  OrderScrView.contentSize = CGSize.init(width: EDCScreenWidth, height: EDCTextandBtn*(AlreadyAry.count+4) + 10)
        //  OrderScrView.backgroundColor = UIColor.yellow
        // PayView.addSubview(OrderScrView)
        
        //navigationController?.popToRootViewController(animated: true)
        
    }
    
    
    //MARK:加载数据源
    fileprivate func configureData () {
        
        for i in 1...9 {
            
            let model = DishModel_edc()
            model.VageId = i + 100
            model.VegeName = "菜品\(i)" as String?
            model.Money = "\(12.2 +  (CGFloat)(i))" as String?
            model.ImgName = "pic_01"
            model.Quantity = "剩余: \(i+1)"
            
            RightDataSource.add(model)
        }
        
        
        for i in 1...5 {
            
            let model = Classification_edc()
            model.ClassificationId = i + 2
            model.ClassificationName = "分类\(i)" as NSString?
            
            LeftDataSource.add(model)
        }
        
        
        
    }
    
    
    //MARK:顶部视图
    func MealTopView () {
        
        let topView : UIView = UIView.init(frame: CGRect(x: 0, y: 0 , width:EDCScreenWidth, height: EDCTextandBtn))
        topView.backgroundColor=UIColor.white
        topView.layer.borderWidth=0.5
        topView.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(topView)
        
        
        let btnTitleAry = ["点菜","结账单"]
        
        
        for i in 0..<2{
            
            let btn : UIButton = UIButton.init(frame: CGRect(x: i*(EDCScreenWidth/2) , y: 0 , width:EDCScreenWidth/2, height: EDCTextandBtn))
            btn.tag = 100+i
            btn.titleLabel?.font = UIFont .systemFont(ofSize: 16)
            btn.setTitle(btnTitleAry[i], for: .normal)
            btn.setTitleColor(TextColor, for: .normal)
            btn.setTitleColor(EDCRGB(R: 181, G: 166, B: 244, ap: 1.0), for: .selected)
            btn.addTarget(self, action: #selector(MealtopBtnClick), for: .touchUpInside)
            topView.addSubview(btn)
            
            
            if i == 0 {
                
                SelectBtn = btn
                SelectBtn.isSelected = true
            }
        }
    }
    
    
    //MARK:选项卡
    func MealtopBtnClick (btn : UIButton) {
        
        SelectBtn.isSelected = false
        
        SelectBtn = btn
        
        SelectBtn.isSelected = true
        
        MealScrView.setContentOffset(CGPoint(x: EDCScreenWidth*(btn.tag-100), y: 0), animated: true)
    }
    
    
    //MARK: - TableView DataSource Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if tableView == leftTab {
            return 1
        }else{
            return LeftDataSource.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == leftTab {
            return LeftDataSource.count
        }else{
            return RightDataSource.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if  tableView == leftTab {
            
            let cell : LeftTableViewCell_edc  = tableView.dequeueReusableCell(withIdentifier: LeftCellIdentifier, for: indexPath) as! LeftTableViewCell_edc
            
            cell .setCellvalue(model: LeftDataSource[indexPath.row] as! Classification_edc)
            
            return cell
            
        }else{
            
            let cell : RightTableViewCell_edc = tableView.dequeueReusableCell(withIdentifier: RightCellIdentifier, for: indexPath) as! RightTableViewCell_edc
            
            //cell.backgroundColor = UIColor.yellow
            
            cell .setCellvalue(model: RightDataSource[indexPath.row] as! DishModel_edc)
            
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if leftTab == tableView {
            
            return 0
            
        }else{
            
            return 30
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if leftTab == tableView {
            return nil
        }
        
        let headerView = RightTabHeadView_edc(frame: CGRect(x: 0, y: 0, width: RightTab.bounds.size.width, height: 30))
        
        
        let model :Classification_edc  = LeftDataSource[section] as! Classification_edc
        headerView.nameLabel.text = model.ClassificationName as String?
        
        
        return headerView
    }
    
    
    // TableView 分区标题即将展示
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if (RightTab == tableView) && !isScrollDown && RightTab.isDragging
        {
            selectRow(index: section)
        }
        
    }
    
    // TableView分区标题展示结束
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        
        
        if (RightTab == tableView) && isScrollDown && RightTab.isDragging
        {
            selectRow(index: section + 1)
        }
    }
    
    
    // 当拖动右边 TableView 的时候，处理左边 TableView
    private func selectRow(index : Int) {
        
        leftTab.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .top)
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if leftTab == tableView {
            
            selectIndex = indexPath.row
            
            RightTab.scrollToRow(at: IndexPath(row: 0, section: selectIndex), at: .top, animated: true)
            
            leftTab.scrollToRow(at: IndexPath(row: selectIndex , section: 0), at: .top, animated: true)
            
        }
        
    }
    
    
    // 标记一下 RightTableView 的滚动方向，是向上还是向下
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == MealScrView {
            
        }else{
            
            let tableView = scrollView as! UITableView
            if RightTab == tableView {
                
                isScrollDown = lastOffsetY < scrollView.contentOffset.y
                lastOffsetY = scrollView.contentOffset.y
            }
        }
        
    }
    
    
    //滚动结束回调
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView == MealScrView {
            
            let contentoffset : Int = Int(scrollView.contentOffset.x)
            let numOfTable : Int = Int(contentoffset/EDCScreenWidth)
            
            let btn = self.view.viewWithTag(100+numOfTable)
            
            
            MealtopBtnClick(btn: btn as! UIButton)
        }
    }
    
    
}










