//
//  CashDrawerExtViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import UIKit

class CashDrawerExtViewController: CommonViewController, StarIoExtManagerDelegate, UIAlertViewDelegate {
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var openButton: UIButton!
    
    var starIoExtManager: StarIoExtManager!
    
    var didAppear: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.commentLabel.text = ""
        
        self.commentLabel.adjustsFontSizeToFitWidth = true
        
        self.openButton.isEnabled           = true
        self.openButton.backgroundColor   = UIColor.cyan
        self.openButton.layer.borderColor = UIColor.blue.cgColor
        self.openButton.layer.borderWidth = 1.0
        
//      self.appendRefreshButton                                     ("refreshCashDrawer")
        self.appendRefreshButton(#selector(CashDrawerExtViewController.refreshCashDrawer))
        
        self.starIoExtManager = StarIoExtManager(type: StarIoExtManagerType.standard,
                                             portName: AppDelegate.getPortName(),
                                         portSettings: AppDelegate.getPortSettings(),
                                      ioTimeoutMillis: 10000)                             // 10000mS!!!
        
        self.starIoExtManager.cashDrawerOpenActiveHigh = AppDelegate.getCashDrawerOpenActiveHigh()
        
        self.starIoExtManager.delegate = self
        
        self.didAppear = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//      NSNotificationCenter.defaultCenter().addObserver(self, selector:                                   "applicationWillResignActive", name: "UIApplicationWillResignActiveNotification", object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PrinterExtViewController.applicationWillResignActive), name: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: nil)
//      NSNotificationCenter.defaultCenter().addObserver(self, selector:                                   "applicationDidBecomeActive",  name: "UIApplicationDidBecomeActiveNotification",  object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PrinterExtViewController.applicationDidBecomeActive),  name: NSNotification.Name(rawValue: "UIApplicationDidBecomeActiveNotification"),  object: nil)
        
//      self.refreshCashDrawer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.refreshCashDrawer()
        
        if self.didAppear == false {
            if self.starIoExtManager.port != nil {
                self.openButton.sendActions(for: UIControlEvents.touchUpInside)
            }
            
            self.didAppear = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.starIoExtManager.disconnect()
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "UIApplicationDidBecomeActiveNotification"),  object: nil)
    }
    
    func applicationDidBecomeActive() {
        self.beginAnimationCommantLabel()
        
        self.refreshCashDrawer()
    }
    
    func applicationWillResignActive() {
        self.starIoExtManager.disconnect()
    }
    
    @IBAction func touchUpInsideOpenButton(_ sender: UIButton) {
        let commands: Data
        
        switch AppDelegate.getSelectedIndex() {
        case 0, 1 :
            commands = CashDrawerFunctions.createData(AppDelegate.getEmulation(), channel: SCBPeripheralChannel.no1)
//      case 2, 3 :
        default   :
            commands = CashDrawerFunctions.createData(AppDelegate.getEmulation(), channel: SCBPeripheralChannel.no2)
        }
        
        self.blind = true
        
        defer {
            self.blind = false
        }
        
        self.starIoExtManager.lock.lock()
        
        switch AppDelegate.getSelectedIndex() {
        case 0, 2 :
            Communication.sendCommands                   (commands, port: self.starIoExtManager.port)
//      case 1, 3 :
        default   :
            Communication.sendCommandsDoNotCheckCondition(commands, port: self.starIoExtManager.port)
        }
        
        self.starIoExtManager.lock.unlock()
    }
    
    func refreshCashDrawer() {
        self.blind = true
        
        defer {
            self.blind = false
        }
        
        self.starIoExtManager.disconnect()
        
        if self.starIoExtManager.connect() == false {
            let alertView: UIAlertView = UIAlertView(title: "Fail to Open Port.", message: "", delegate: self, cancelButtonTitle: "OK")
            
            alertView.show()
        }
    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        self.commentLabel.text = "Check the device. (Power and Bluetooth pairing)\nThen touch up the Refresh button."
        
        self.commentLabel.textColor = UIColor.red
        
        self.beginAnimationCommantLabel()
    }
    
    func didPrinterImpossible(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Printer Impossible."
        
        self.commentLabel.textColor = UIColor.red
        
        self.beginAnimationCommantLabel()
    }
    
    func didCashDrawerOpen(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Cash Drawer Open."
        
//      self.commentLabel.textColor = UIColor.redColor()
        self.commentLabel.textColor = UIColor.magenta
        
        self.beginAnimationCommantLabel()
    }
    
    func didCashDrawerClose(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Cash Drawer Close."
        
        self.commentLabel.textColor = UIColor.blue
        
        self.beginAnimationCommantLabel()
    }
    
    func didAccessoryConnectSuccess(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Accessory Connect Success."
        
        self.commentLabel.textColor = UIColor.blue
        
        self.beginAnimationCommantLabel()
    }
    
    func didAccessoryConnectFailure(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Accessory Connect Failure."
        
        self.commentLabel.textColor = UIColor.red
        
        self.beginAnimationCommantLabel()
    }
    
    func didAccessoryDisconnect(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Accessory Disconnect."
        
        self.commentLabel.textColor = UIColor.red
        
        self.beginAnimationCommantLabel()
    }
    
    func didStatusUpdate(_ manager: StarIoExtManager!, status: String!) {
        NSLog("%@", MakePrettyFunction())
        
//      self.commentLabel.text = status
//
//      self.commentLabel.textColor = UIColor.greenColor()
//
//      self.beginAnimationCommantLabel()
    }
    
    fileprivate func beginAnimationCommantLabel() {
        UIView.beginAnimations(nil, context: nil)
        
        self.commentLabel.alpha = 0.0
        
        UIView.setAnimationDelay             (0.0)                             // 0mS!!!
        UIView.setAnimationDuration          (0.6)                             // 600mS!!!
        UIView.setAnimationRepeatCount       (Float(UINT32_MAX))
        UIView.setAnimationRepeatAutoreverses(true)
        UIView.setAnimationCurve             (UIViewAnimationCurve.easeIn)
        
        self.commentLabel.alpha = 1.0
        
        UIView.commitAnimations()
    }
}
