//
//  ScanningVC_edc.swift
//  huihuiMeal
//
//  Created by edc on 2017/3/30.
//  Copyright © 2017年 edc. All rights reserved.
//

import UIKit
import AVFoundation

class ScanningVC_edc: UIViewController {

    
    //var scanPane: UIImageView!///扫描框
    var activityIndicatorView: UIActivityIndicatorView!
    
    var scanSession :  AVCaptureSession?

    var lightOn = false///开光灯
    
    
    
    fileprivate  lazy var ScanPane : UIImageView =
    {
        
        let scanLine = UIImageView()
        scanLine.frame = CGRect(x: EDCGap, y: 100, width: EDCScreenWidth-EDCGap*2, height: EDCScreenWidth-EDCGap*2)
        scanLine.image = UIImage(named: "QRCode_ScanBox")
        
        return scanLine
    }()
    
    
   fileprivate  lazy var scanLine : UIImageView =
        {
            
            let scanLine = UIImageView()
            scanLine.frame = CGRect(x: 0, y: 0, width: EDCScreenWidth-EDCGap*2, height: 3)
            scanLine.image = UIImage(named: "QRCode_ScanLine")
            
            return scanLine
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
        
          startScan()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // 4、设置导航栏半透明
        self.navigationController?.navigationBar.isTranslucent = false
        
     
    }
    
    
    //MARK:背景图片
    fileprivate lazy var BGImg : UIImageView = {
        
        let BGImg = UIImageView.init(frame: self.view.bounds)
        
        BGImg.image = UIImage (named: "pic_dgc")
        
        return BGImg
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "二维码/条形码"
        
        // 4、设置导航栏半透明
        self.navigationController?.navigationBar.isTranslucent = true
        
        // 5、设置导航栏背景图片
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        // 6、设置导航栏阴影图片
        self.navigationController?.navigationBar.shadowImage = UIImage()
    
        
        view.backgroundColor = UIColor.white
        
        SubUi()
        
        view.layoutIfNeeded()
        
        view.addSubview(ScanPane)
        
        ScanPane.addSubview(scanLine)
        
        setupScanSession()
        
      
    }

    
    
    func setupScanSession()
    {
        
        do
        {
            //设置捕捉设备
            let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            //设置设备输入输出
            let input = try AVCaptureDeviceInput(device: device)
            
            let output = AVCaptureMetadataOutput()
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            //设置会话
            let  scanSession = AVCaptureSession()
            scanSession.canSetSessionPreset(AVCaptureSessionPresetHigh)
            
            if scanSession.canAddInput(input)
            {
                scanSession.addInput(input)
            }
            
            if scanSession.canAddOutput(output)
            {
                scanSession.addOutput(output)
            }
            
            //设置扫描类型(二维码和条形码)
            output.metadataObjectTypes = [
                AVMetadataObjectTypeQRCode,
                AVMetadataObjectTypeCode39Code,
                AVMetadataObjectTypeCode128Code,
                AVMetadataObjectTypeCode39Mod43Code,
                AVMetadataObjectTypeEAN13Code,
                AVMetadataObjectTypeEAN8Code,
                AVMetadataObjectTypeCode93Code]
            
            //预览图层
            let scanPreviewLayer = AVCaptureVideoPreviewLayer(session:scanSession)
            scanPreviewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill
            scanPreviewLayer!.frame = view.layer.bounds
            
            view.layer.insertSublayer(scanPreviewLayer!, at: 0)
            
            //设置扫描区域
            NotificationCenter.default.addObserver(forName: NSNotification.Name.AVCaptureInputPortFormatDescriptionDidChange, object: nil, queue: nil, using: { (noti) in
                output.rectOfInterest = (scanPreviewLayer?.metadataOutputRectOfInterest(for: self.ScanPane.frame))!
            })
            
            
            
            //保存会话
            self.scanSession = scanSession
            
        }
        catch
        {
            //摄像头不可用
            
            Tool.confirm(title: "温馨提示", message: "摄像头不可用", controller: self)
            
            return
        }
        
    }

    
    
  
    
    //MARK:界面
    func SubUi () {
        
        view.addSubview(BGImg)
    
    
        let leftBarBtn = UIBarButtonItem(title: "", style: .plain, target: self,
                                         action: #selector(ScanningVC_edc.backToPrevious))
        leftBarBtn.image = UIImage(named: "pic_return")
        
        //用于消除左边空隙，要不然按钮顶不到最前面
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                     action: nil)
        spacer.width = 5;
        
        self.navigationItem.leftBarButtonItems = [spacer, leftBarBtn]
    }
    
    
    
    //返回按钮点击响应
    func backToPrevious(){
        self.navigationController?.popViewController(animated: true)
    }
    
    

    //开始扫描
    fileprivate func startScan()
    {
        
        scanLine.layer.add(scanAnimation(), forKey: "scan")
        
        guard let scanSession = scanSession else { return }
        
        if !scanSession.isRunning
        {
            scanSession.startRunning()
        }
    
    }
    
    //扫描动画
    private func scanAnimation() -> CABasicAnimation
    {
        
        let startPoint = CGPoint(x: scanLine .center.x  , y: 1)
        let endPoint = CGPoint(x: scanLine.center.x, y: ScanPane.bounds.size.height - 2)
        
        let translation = CABasicAnimation(keyPath: "position")
        translation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        translation.fromValue = NSValue(cgPoint: startPoint)
        translation.toValue = NSValue(cgPoint: endPoint)
        translation.duration = 3
        translation.repeatCount = MAXFLOAT
        translation.autoreverses = true
        
        return translation
    }
    
    
    
    ///闪光灯
    private func turnTorchOn()
    {
        
        guard let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) else
        {
            
            if lightOn
            {
                
                Tool.confirm(title: "温馨提示", message: "闪光灯不可用", controller: self)
                
            }
            
            return
        }
        
        if device.hasTorch
        {
            do
            {
                try device.lockForConfiguration()
                
                if lightOn && device.torchMode == .off
                {
                    device.torchMode = .on
                }
                
                if !lightOn && device.torchMode == .on
                {
                    device.torchMode = .off
                }
                
                device.unlockForConfiguration()
            }
            catch{ }
            
        }
        
    }

}



//扫描捕捉完成
extension ScanningVC_edc : AVCaptureMetadataOutputObjectsDelegate
{
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!)
    {
        
        //停止扫描
        self.scanLine.layer.removeAllAnimations()
        self.scanSession!.stopRunning()
        
        //播放声音
        Tool.playAlertSound(sound: "noticeMusic.caf")
        
        //扫完完成
        if metadataObjects.count > 0
        {
            
            if let resultObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject
            {
                
                Tool.confirm(title: "扫描结果", message: resultObj.stringValue, controller: self,handler: { (_) in
                    //继续扫描
                    self.startScan()
                })
                
            }
            
        }
        
    }
    
}
