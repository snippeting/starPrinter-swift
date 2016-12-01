//
//  CombinationExtViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import UIKit

class CombinationExtViewController: CommonViewController, StarIoExtManagerDelegate, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate {
    enum CellParamIndex: Int {
        case barcodeData = 0
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var printButton: UIButton!
    
    var cellArray: NSMutableArray!
    
    var starIoExtManager: StarIoExtManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.commentLabel.text = ""
        
        self.commentLabel.adjustsFontSizeToFitWidth = true
        
        self.printButton.isEnabled           = true
        self.printButton.backgroundColor   = UIColor.cyan
        self.printButton.layer.borderColor = UIColor.blue.cgColor
        self.printButton.layer.borderWidth = 1.0
        
//      self.appendRefreshButton                                      ("refreshBarcodeReader")
        self.appendRefreshButton(#selector(CombinationExtViewController.refreshBarcodeReader))
        
        self.cellArray = NSMutableArray()
        
        self.starIoExtManager = StarIoExtManager(type: StarIoExtManagerType.withBarcodeReader,
                                             portName: AppDelegate.getPortName(),
                                         portSettings: AppDelegate.getPortSettings(),
                                      ioTimeoutMillis: 10000)                                      // 10000mS!!!
        
        self.starIoExtManager.cashDrawerOpenActiveHigh = AppDelegate.getCashDrawerOpenActiveHigh()
        
        self.starIoExtManager.delegate = self
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
        
//      self.refreshBarcodeReader()
        
        self.blind = true
        
        defer {
            self.blind = false
        }
        
//      self.cellArray.removeAllObjects()
        
        self.starIoExtManager.disconnect()
        
        if self.starIoExtManager.connect() == false {
            let alertView: UIAlertView = UIAlertView(title: "Fail to Open Port.", message: "", delegate: self, cancelButtonTitle: "OK")
            
            alertView.show()
        }
        
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.starIoExtManager.disconnect()
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "UIApplicationDidBecomeActiveNotification"),  object: nil)
    }
    
    func applicationDidBecomeActive() {
        self.beginAnimationCommantLabel()
        
        self.refreshBarcodeReader()
    }
    
    func applicationWillResignActive() {
        self.starIoExtManager.disconnect()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellParam: [String] = self.cellArray[indexPath.row] as! [String]
        
        let cellIdentifier: String = "UITableViewCellStyleValue1"
        
//      var cell: UITableViewCell! = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        var cell: UITableViewCell! = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: cellIdentifier)
        }
        
        if cell != nil {
            cell      .textLabel!.text = cellParam[CellParamIndex.barcodeData.rawValue]
            cell.detailTextLabel!.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Contents"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func touchUpInsidePrintButton(_ sender: UIButton) {
        let commands: Data
        
        let emulation: StarIoExtEmulation = AppDelegate.getEmulation()
        
        let width: Int = PaperSizeIndex.twoInch.rawValue
        
        let localizeReceipts: ILocalizeReceipts = LocalizeReceipts.createLocalizeReceipts(AppDelegate.getSelectedLanguage(), paperSizeIndex: PaperSizeIndex.twoInch)
        
        switch AppDelegate.getSelectedIndex() {
        case 0 :
            commands = CombinationFunctions.createTextReceiptData(emulation, localizeReceipts: localizeReceipts, utf8: false)
        case 1 :
            commands = CombinationFunctions.createTextReceiptData(emulation, localizeReceipts: localizeReceipts, utf8: true)
        case 2 :
            commands = CombinationFunctions.createRasterReceiptData(emulation, localizeReceipts: localizeReceipts)
        case 3 :
            commands = CombinationFunctions.createScaleRasterReceiptData(emulation, localizeReceipts: localizeReceipts, width: width, bothScale: true)
        case 4 :
            commands = CombinationFunctions.createScaleRasterReceiptData(emulation, localizeReceipts: localizeReceipts, width: width, bothScale: false)
        case 5 :
            commands = CombinationFunctions.createCouponData(emulation, localizeReceipts: localizeReceipts, width: width, rotation: SCBBitmapConverterRotation.normal)
//      case 6  :
        default :
            commands = CombinationFunctions.createCouponData(emulation, localizeReceipts: localizeReceipts, width: width, rotation: SCBBitmapConverterRotation.right90)
        }
        
        self.blind = true
        
        defer {
            self.blind = false
        }
        
        self.starIoExtManager.lock.lock()
        
        Communication.sendCommands(commands, port: self.starIoExtManager.port)
        
        self.starIoExtManager.lock.unlock()
    }
    
    func refreshBarcodeReader() {
        self.blind = true
        
        defer {
            self.blind = false
        }
        
        self.cellArray.removeAllObjects()
        
        self.starIoExtManager.disconnect()
        
        if self.starIoExtManager.connect() == false {
            let alertView: UIAlertView = UIAlertView(title: "Fail to Open Port.", message: "", delegate: self, cancelButtonTitle: "OK")
            
            alertView.show()
        }
        
        self.tableView.reloadData()
    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        self.commentLabel.text = "Check the device. (Power and Bluetooth pairing)\nThen touch up the Refresh button."
        
        self.commentLabel.textColor = UIColor.red
        
        self.beginAnimationCommantLabel()
    }
    
    func didBarcodeDataReceive(_ manager: StarIoExtManager!, data: Data!) {
        NSLog("%@", MakePrettyFunction())
        
        var text: String = ""
        
        var buffer = Array<UInt8>(repeating: 0, count: data.count)
        
        data.copyBytes(to: &buffer, count: data.count)
        
//      for var i: Int = 0; i < data.length; i += 1 {
        for     i: Int in 0 ..< data.count         {
            let ch: UInt8 = buffer[i]
            
            if ch >= 0x20 && ch <= 0x7f {
                text += String(format: "%c", ch)
            }
            else if ch == 0x0d {
                if self.cellArray.count > 30 {     // Max.30Line
                    self.cellArray.removeObject(at: 0)
                    
                    self.tableView.reloadData()
                }
                
                self.cellArray.add([text])
                
                text = ""
            }
        }
        
        self.tableView.reloadData()
        
        let indexPath: IndexPath = IndexPath(row: self.cellArray.count - 1, section: 0)
        
//      self.tableView.selectRowAtIndexPath(indexPath, animated:false, scrollPosition: UITableViewScrollPosition.Bottom)
        self.tableView.selectRow(at: indexPath, animated:true,  scrollPosition: UITableViewScrollPosition.bottom)
        
        self.tableView.deselectRow(at: indexPath, animated:true)
    }
    
    func didPrinterImpossible(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Printer Impossible."
        
        self.commentLabel.textColor = UIColor.red
        
        self.beginAnimationCommantLabel()
    }
    
    func didPrinterOnline(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Printer Online."
        
        self.commentLabel.textColor = UIColor.blue
        
        self.beginAnimationCommantLabel()
    }
    
    func didPrinterOffline(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
//      self.commentLabel.text = "Printer Offline."
//
//      self.commentLabel.textColor = UIColor.redColor()
//
//      self.beginAnimationCommantLabel()
    }
    
    func didPrinterPaperReady(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
//      self.commentLabel.text = "Printer Paper Ready."
//
//      self.commentLabel.textColor = UIColor.blueColor()
//
//      self.beginAnimationCommantLabel()
    }
    
    func didPrinterPaperNearEmpty(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Printer Paper Near Empty."
        
        self.commentLabel.textColor = UIColor.orange
        
        self.beginAnimationCommantLabel()
    }
    
    func didPrinterPaperEmpty(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Printer Paper Empty."
        
        self.commentLabel.textColor = UIColor.red
        
        self.beginAnimationCommantLabel()
    }
    
    func didPrinterCoverOpen(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Printer Cover Open."
        
        self.commentLabel.textColor = UIColor.red
        
        self.beginAnimationCommantLabel()
    }
    
    func didPrinterCoverClose(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
//      self.commentLabel.text = "Printer Cover Close."
//
//      self.commentLabel.textColor = UIColor.blueColor()
//
//      self.beginAnimationCommantLabel()
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
    
    func didBarcodeReaderImpossible(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Barcode Reader Impossible."
        
        self.commentLabel.textColor = UIColor.red
        
        self.beginAnimationCommantLabel()
    }
    
    func didBarcodeReaderConnect(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Barcode Reader Connect."
        
        self.commentLabel.textColor = UIColor.blue
        
        self.beginAnimationCommantLabel()
    }
    
    func didBarcodeReaderDisconnect(_ manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Barcode Reader Disconnect."
        
        self.commentLabel.textColor = UIColor.red
        
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