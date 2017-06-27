//
//  huihuimeal.swift
//  huihuiMeal
//
//  Created by edc on 2017/3/14.
//  Copyright © 2017年 edc. All rights reserved.
//

import UIKit


let EDCScreenHeight : Int = Int(UIScreen.main.bounds.size.height)
let EDCScreenWidth  : Int = Int(UIScreen.main.bounds.size.width)
let EDCGap : Int = 40
let EDCTextandBtn  : Int = 44
let EDCBtnheight : Int = 50


let Gap : Int = 20
let TextColor = EDCRGB(R: 97, G: 97, B: 97, ap: 1.0)
let EDCFonFSize = UIFont .systemFont(ofSize: 16)
let MyTextColor = EDCRGB(R: 93, G: 208, B: 171, ap: 1.0)

let LeftCellIdentifier = "LeftTableViewCell_edc"
let RightCellIdentifier = "RightTableViewCell_edc"
let leftTabHeight = 50
let iconWidth : Int = 30


//判断设备
let EDCDevice = UIDevice.current.userInterfaceIdiom


//MARK类型装换
func StringToFloat(str:String)->(CGFloat){
    
    let string = str
    var cgFloat: CGFloat = 0
    
    
    if let doubleValue = Double(string)
    {
        cgFloat = CGFloat(doubleValue)
    }
    return cgFloat
}




//随机颜色
func RGBCOLOR() -> UIColor
{
    let red = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
    let green = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
    let blue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
    let colorRun = UIColor(red:red, green:green, blue:blue , alpha: 1)
    
    return colorRun
}

func  EDCRGB(R: CGFloat , G: CGFloat, B: CGFloat, ap : CGFloat) -> UIColor {
    
    return  UIColor(red:R/255, green:G/255, blue:B/255 , alpha: ap )
    
}



