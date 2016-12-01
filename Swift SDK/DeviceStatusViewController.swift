//
//  DeviceStatusViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

import UIKit

class DeviceStatusViewController: CommonViewController, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate {
    enum CellParamIndex: Int {
        case titleIndex = 0
        case detailIndex
        case colorIndex
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var cellArray: NSMutableArray!
    
    var didAppear: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//      self.appendRefreshButton                                    ("refreshDeviceStatus")
        self.appendRefreshButton(#selector(DeviceStatusViewController.refreshDeviceStatus))
        
        self.cellArray = NSMutableArray()
        
        self.didAppear = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if didAppear == false {
            self.refreshDeviceStatus()
            
            self.didAppear = true
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "UITableViewCellStyleValue1"
        
        var cell: UITableViewCell! = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: cellIdentifier)
        }
        
        if cell != nil {
            let cellParam: [AnyObject] = self.cellArray[indexPath.row] as! [AnyObject]
            
            cell      .textLabel!.text      = cellParam[CellParamIndex.titleIndex .rawValue] as? String
            cell.detailTextLabel!.text      = cellParam[CellParamIndex.detailIndex.rawValue] as? String
            cell.detailTextLabel!.textColor = cellParam[CellParamIndex.colorIndex .rawValue] as! UIColor
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Contents"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func refreshDeviceStatus() {
        var result: Bool = false
        
        self.blind = true
        
        defer {
            self.blind = false
        }
        
        self.cellArray.removeAllObjects()
        
        var error: NSError?
        
        while true {
            guard let port: SMPort = SMPort.getPort(AppDelegate.getPortName(), AppDelegate.getPortSettings(), 10000) else {     // 10000mS!!!
                break
            }
            
            defer {
                SMPort.release(port)
            }
            
            var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
            
            port.getParsedStatus(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
            if printerStatus.offline == sm_true {
                self.cellArray.add(["Online", "Offline", UIColor.red])
            }
            else {
                self.cellArray.add(["Online",  "Online",  UIColor.blue])
            }
            
            if printerStatus.coverOpen == sm_true {
                self.cellArray.add(["Cover", "Open",   UIColor.red])
            }
            else {
                self.cellArray.add(["Cover", "Closed", UIColor.blue])
            }
            
            if printerStatus.receiptPaperEmpty == sm_true {
                self.cellArray.add(["Paper", "Empty", UIColor.red])
            }
            else if printerStatus.receiptPaperNearEmptyInner == sm_true ||
                    printerStatus.receiptPaperNearEmptyOuter == sm_true {
                self.cellArray.add(["Paper", "Near Empty", UIColor.orange])
            }
            else {
                self.cellArray.add(["Paper", "Ready",      UIColor.blue])
            }
            
            if AppDelegate.getCashDrawerOpenActiveHigh() == true {
                if printerStatus.compulsionSwitch == sm_true {
                    self.cellArray.add(["Cash Drawer", "Open",   UIColor.red])
                }
                else {
                    self.cellArray.add(["Cash Drawer", "Closed", UIColor.blue])
                }
            }
            else {
                if printerStatus.compulsionSwitch == sm_true {
                    self.cellArray.add(["Cash Drawer", "Closed", UIColor.blue])
                }
                else {
                    self.cellArray.add(["Cash Drawer", "Open",   UIColor.red])
                }
            }
            
            if printerStatus.overTemp == sm_true {
                self.cellArray.add(["Head Temperature", "High",   UIColor.red])
            }
            else {
                self.cellArray.add(["Head Temperature", "Normal", UIColor.blue])
            }
            
            if printerStatus.unrecoverableError == sm_true {
                self.cellArray.add(["Non Recoverable Error", "Occurs", UIColor.red])
            }
            else {
                self.cellArray.add(["Non Recoverable Error", "Ready",  UIColor.blue])
            }
            
            if printerStatus.cutterError == sm_true {
                self.cellArray.add(["Paper Cutter", "Error", UIColor.red])
            }
            else {
                self.cellArray.add(["Paper Cutter", "Ready", UIColor.blue])
            }
            
            if printerStatus.headThermistorError == sm_true {
                self.cellArray.add(["Head Thermistor", "Error",  UIColor.red])
            }
            else {
                self.cellArray.add(["Head Thermistor", "Normal", UIColor.blue])
            }
            
            if printerStatus.voltageError == sm_true {
                self.cellArray.add(["Voltage", "Error",  UIColor.red])
            }
            else {
                self.cellArray.add(["Voltage", "Normal", UIColor.blue])
            }
            
            if printerStatus.etbAvailable == sm_true {
                self.cellArray.add(["ETB Counter", String(format: "%d", printerStatus.etbCounter), UIColor.blue])
            }
            
            result = true
            break
        }
        
        if result == false {
            let alertView: UIAlertView = UIAlertView.init(title: "Fail to Open Port", message: "", delegate: nil, cancelButtonTitle: "OK")
            
            alertView.show()
        }
        
        self.tableView.reloadData()
    }
}
