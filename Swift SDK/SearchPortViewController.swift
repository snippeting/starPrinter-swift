//
//  SearchPortViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import UIKit

class SearchPortViewController: CommonViewController, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate {
    enum CellParamIndex: Int {
        case portName = 0
        case modelName
        case macAddress
    }
    
    enum AlertViewIndex: Int {
        case refreshPort = 0
        case portName
        case portSettings
        case modelConfirm
        case modelSelect0
        case modelSelect1
        case cashDrawerOpenActive
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var cellArray: NSMutableArray!
    
    var selectedIndexPath: IndexPath!
    
    var didAppear: Bool!
    
    var portName:     String!
    var portSettings: String!
    var modelName:    String!
    var macAddress:   String!
    
    var emulation: StarIoExtEmulation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//      self.appendRefreshButton                                  ("refreshPortInfo")
        self.appendRefreshButton(#selector(SearchPortViewController.refreshPortInfo))
        
        self.cellArray = NSMutableArray()
        
        self.selectedIndexPath = nil
        
        self.didAppear = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if didAppear == false {
            self.refreshPortInfo()
            
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
        let cellIdentifier: String = "UITableViewCellStyleSubtitle"
        
        var cell: UITableViewCell! = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellIdentifier)
        }
        
        if cell != nil {
            let cellParam: [String] = self.cellArray[indexPath.row] as! [String]
            
//          cell      .textLabel!.text = cellParam[CellParamIndex.PortName.rawValue]
            cell      .textLabel!.text = cellParam[CellParamIndex.modelName.rawValue]
//          cell.detailTextLabel!.text = cellParam[CellParamIndex.ModelName.rawValue]
            
            if cellParam[CellParamIndex.macAddress.rawValue] == "" {
                cell.detailTextLabel!.text = cellParam[CellParamIndex.portName.rawValue]
            }
            else {
                cell.detailTextLabel!.text = "\(cellParam[CellParamIndex.portName.rawValue]) (\(cellParam[CellParamIndex.macAddress.rawValue]))"
            }
            
            cell      .textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
            cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
            
            cell.accessoryType = UITableViewCellAccessoryType.none
            
            if self.selectedIndexPath != nil {
                if (indexPath as NSIndexPath).compare(self.selectedIndexPath) == ComparisonResult.orderedSame {
                    cell.accessoryType = UITableViewCellAccessoryType.checkmark
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//      self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var cell: UITableViewCell!
        
        if self.selectedIndexPath != nil {
            cell = tableView.cellForRow(at: self.selectedIndexPath)
            
            if cell != nil {
                cell.accessoryType = UITableViewCellAccessoryType.none
            }
        }
        
        cell = tableView.cellForRow(at: indexPath)!
        
        cell.accessoryType = UITableViewCellAccessoryType.checkmark
        
        self.selectedIndexPath = indexPath
        
        let cellParam: [String] = self.cellArray[self.selectedIndexPath.row] as! [String]
        
//      let portName:   String = cellParam[CellParamIndex.PortName  .rawValue]
        let modelName:  String = cellParam[CellParamIndex.modelName .rawValue]
//      let macAddress: String = cellParam[CellParamIndex.MacAddress.rawValue]
        
        if false {     // Ex1. Direct Setting.
//          let portSettings: String = ""
//          let portSettings: String = "mini"
//          let portSettings: String = "escpos"
//          let portSettings: String = "Portable"
//
//          let emulation: StarIoExtEmulation = StarIoExtEmulation.StarPRNT
//          let emulation: StarIoExtEmulation = StarIoExtEmulation.StarLine
//          let emulation: StarIoExtEmulation = StarIoExtEmulation.StarGraphic
//          let emulation: StarIoExtEmulation = StarIoExtEmulation.EscPos
//          let emulation: StarIoExtEmulation = StarIoExtEmulation.EscPosMobile
//          let emulation: StarIoExtEmulation = StarIoExtEmulation.StarDotImpact
//
//          AppDelegate.setPortName    (portName)
//          AppDelegate.setModelName   (modelName)
//          AppDelegate.setMacAddress  (macAddress)
//          AppDelegate.setPortSettings(portSettings)
//          AppDelegate.setEmulation   (emulation)
//
//          self.navigationController!.popViewControllerAnimated(true)
        }
        else if false {     // Ex2. Direct Setting.
//          let modelIndex: ModelIndex = ModelIndex.MPOP
//          let modelIndex: ModelIndex = ModelIndex.FVP10
//          let modelIndex: ModelIndex = ModelIndex.TSP100
//          let modelIndex: ModelIndex = ModelIndex.TSP650II
//          let modelIndex: ModelIndex = ModelIndex.TSP700II
//          let modelIndex: ModelIndex = ModelIndex.TSP800II
//          let modelIndex: ModelIndex = ModelIndex.SM_S210I
//          let modelIndex: ModelIndex = ModelIndex.SM_S220I
//          let modelIndex: ModelIndex = ModelIndex.SM_S230I
//          let modelIndex: ModelIndex = ModelIndex.SM_T300I
//          let modelIndex: ModelIndex = ModelIndex.SM_T400I
//          let modelIndex: ModelIndex = ModelIndex.BSC10
//          let modelIndex: ModelIndex = ModelIndex.SM_S210I_StarPRNT
//          let modelIndex: ModelIndex = ModelIndex.SM_S220I_StarPRNT
//          let modelIndex: ModelIndex = ModelIndex.SM_S230I_StarPRNT
//          let modelIndex: ModelIndex = ModelIndex.SM_T300I_StarPRNT
//          let modelIndex: ModelIndex = ModelIndex.SM_T400I_StarPRNT
//          let modelIndex: ModelIndex = ModelIndex.SM_L200
//          let modelIndex: ModelIndex = ModelIndex.SP700
//
//          let portSettings: String             = ModelCapability.portSettingsAtModelIndex(modelIndex)
//          let emulation:    StarIoExtEmulation = ModelCapability.emulationAtModelIndex   (modelIndex)
//
//          AppDelegate.setPortName    (portName)
//          AppDelegate.setModelName   (modelName)
//          AppDelegate.setMacAddress  (macAddress)
//          AppDelegate.setPortSettings(portSettings)
//          AppDelegate.setEmulation   (emulation)
//
//          self.navigationController!.popViewControllerAnimated(true)
        }
        else if false {     // Ex3. Indirect Setting.
//          let modelIndex: ModelIndex = ModelCapability.modelIndexAtModelName(modelName)
//
//          let portSettings: String             = ModelCapability.portSettingsAtModelIndex(modelIndex)
//          let emulation:    StarIoExtEmulation = ModelCapability.emulationAtModelIndex   (modelIndex)
//
//          AppDelegate.setPortName    (portName)
//          AppDelegate.setModelName   (modelName)
//          AppDelegate.setMacAddress  (macAddress)
//          AppDelegate.setPortSettings(portSettings)
//          AppDelegate.setEmulation   (emulation)
//
//          self.navigationController!.popViewControllerAnimated(true)
        }
        else {     // Ex4. Indirect Setting.
            let modelIndex: ModelIndex = ModelCapability.modelIndexAtModelName(modelName: modelName)
            
            if modelIndex != ModelIndex.None {
                let message: String = String(format: "Is your printer %@?", ModelCapability.titleAtModelIndex(modelIndex: modelIndex))
                
                let alertView: UIAlertView = UIAlertView.init(title: "Confirm.", message: message, delegate: self, cancelButtonTitle: "NO", otherButtonTitles: "YES")
                
                alertView.tag = AlertViewIndex.modelConfirm.rawValue
                
                alertView.show()
            }
            else {
                let alertView: UIAlertView = UIAlertView.init(title: "Confirm.", message: "What is your printer?", delegate: self, cancelButtonTitle: "Cancel")
                
//              for var i: Int = 0; i < ModelCapability.modelIndexCount(); i += 1 {
                for     i: Int in 0 ..< ModelCapability.modelIndexCount()         {
                    alertView.addButton(withTitle: ModelCapability.titleAtModelIndex(modelIndex: ModelCapability.modelIndexAtIndex(index: i)))
                }
                
                alertView.tag = AlertViewIndex.modelSelect0.rawValue
                
                alertView.show()
            }
        }
    }
    
    func refreshPortInfo() {
        let alertView: UIAlertView = UIAlertView.init(title: "Select Interface.", message: "", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "LAN", "Bluetooth", "Bluetooth Low Energy", "All", "Manual")
        
        alertView.tag = AlertViewIndex.refreshPort.rawValue
        
        alertView.show()
    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if alertView.tag == AlertViewIndex.portName.rawValue {
            if buttonIndex == alertView.cancelButtonIndex {
                alertView.delegate = nil
                
                self.navigationController!.popViewController(animated: true)
            }
            else {
                self.portName = alertView.textField(at: 0)!.text
                
                if self.portName == "" {
                    let nestAlertView: UIAlertView = UIAlertView.init(title: "Please enter the port name.", message: "Fill in the port name.", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "OK")
                    
                    nestAlertView.tag            = AlertViewIndex.portName.rawValue
                    nestAlertView.alertViewStyle = UIAlertViewStyle.plainTextInput
                    
                    nestAlertView.textField(at: 0)!.text = AppDelegate.getPortName()
                    
                    nestAlertView.show()
                }
                else {
                    let nestAlertView: UIAlertView = UIAlertView.init(title: "Please enter the port settings.", message: "", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "OK")
                    
                    nestAlertView.tag            = AlertViewIndex.portSettings.rawValue
                    nestAlertView.alertViewStyle = UIAlertViewStyle.plainTextInput
                    
                    nestAlertView.textField(at: 0)!.text = AppDelegate.getPortSettings()
                    
                    nestAlertView.show()
                }
            }
        }
        else if alertView.tag == AlertViewIndex.portSettings.rawValue {
            if buttonIndex == alertView.cancelButtonIndex {
                alertView.delegate = nil
                
                self.navigationController!.popViewController(animated: true)
            }
            else {
                self.portSettings = alertView.textField(at: 0)!.text
                
                let nestAlertView: UIAlertView = UIAlertView.init(title: "Confirm.", message: "What is your printer?", delegate: self, cancelButtonTitle: "Cancel")
                
//              for var i: Int = 0; i < ModelCapability.modelIndexCount(); i += 1 {
                for     i: Int in 0 ..< ModelCapability.modelIndexCount()         {
                    nestAlertView.addButton(withTitle: ModelCapability.titleAtModelIndex(modelIndex: ModelCapability.modelIndexAtIndex(index: i)))
                }
                
                nestAlertView.tag = AlertViewIndex.modelSelect1.rawValue
                
                nestAlertView.show()
            }
        }
        else if alertView.tag == AlertViewIndex.modelConfirm.rawValue {
            if buttonIndex == 1 {     // YES!!!
                let cellParam: [String] = self.cellArray[self.selectedIndexPath.row] as! [String]
                
                self.portName   = cellParam[CellParamIndex.portName  .rawValue]
                self.modelName  = cellParam[CellParamIndex.modelName .rawValue]
                self.macAddress = cellParam[CellParamIndex.macAddress.rawValue]
                
                let modelIndex: ModelIndex = ModelCapability.modelIndexAtModelName(modelName: self.modelName)
                
                self.portSettings = ModelCapability.portSettingsAtModelIndex(modelIndex: modelIndex)
                self.emulation    = ModelCapability.emulationAtModelIndex   (modelIndex: modelIndex)
                
                if ModelCapability.cashDrawerOpenActiveAtModelIndex(modelIndex: modelIndex) == true {
                    let nestAlertView: UIAlertView = UIAlertView.init(title: "Select CashDrawer Open Status.", message: "", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "High when Open", "Low when Open")
                    
                    nestAlertView.tag = AlertViewIndex.cashDrawerOpenActive.rawValue
                    
                    nestAlertView.show()
                }
                else {
                    AppDelegate.setPortName                (self.portName)
                    AppDelegate.setPortSettings            (self.portSettings)
                    AppDelegate.setModelName               (self.modelName)
                    AppDelegate.setMacAddress              (self.macAddress)
                    AppDelegate.setEmulation               (self.emulation)
                    AppDelegate.setCashDrawerOpenActiveHigh(true)
                    
                    alertView.delegate = nil;
                    
                    self.navigationController!.popViewController(animated: true)
                }
            }
            else {     // NO!!!
                let nestAlertView: UIAlertView = UIAlertView.init(title: "Confirm.", message: "What is your printer?", delegate: self, cancelButtonTitle: "Cancel")
                
//              for var i: Int = 0; i < ModelCapability.modelIndexCount(); i += 1 {
                for     i: Int in 0 ..< ModelCapability.modelIndexCount()         {
                    nestAlertView.addButton(withTitle: ModelCapability.titleAtModelIndex(modelIndex: ModelCapability.modelIndexAtIndex(index: i)))
                }
                
                nestAlertView.tag = AlertViewIndex.modelSelect0.rawValue
                
                nestAlertView.show()
            }
        }
        else if alertView.tag == AlertViewIndex.modelSelect0.rawValue {
            if buttonIndex != alertView.cancelButtonIndex {
                let cellParam: [String] = self.cellArray[self.selectedIndexPath.row] as! [String]
                
                self.portName   = cellParam[CellParamIndex.portName  .rawValue]
                self.modelName  = cellParam[CellParamIndex.modelName .rawValue]
                self.macAddress = cellParam[CellParamIndex.macAddress.rawValue]
                
                let modelIndex: ModelIndex = ModelCapability.modelIndexAtIndex(index: buttonIndex - 1)
                
                self.portSettings = ModelCapability.portSettingsAtModelIndex(modelIndex: modelIndex)
                self.emulation    = ModelCapability.emulationAtModelIndex   (modelIndex: modelIndex)
                
                if ModelCapability.cashDrawerOpenActiveAtModelIndex(modelIndex: modelIndex) == true {
                    let nestAlertView: UIAlertView = UIAlertView.init(title: "Select CashDrawer Open Status.", message: "", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "High when Open", "Low when Open")
                    
                    nestAlertView.tag = AlertViewIndex.cashDrawerOpenActive.rawValue
                    
                    nestAlertView.show()
                }
                else {
                    AppDelegate.setPortName                (self.portName)
                    AppDelegate.setPortSettings            (self.portSettings)
                    AppDelegate.setModelName               (self.modelName)
                    AppDelegate.setMacAddress              (self.macAddress)
                    AppDelegate.setEmulation               (self.emulation)
                    AppDelegate.setCashDrawerOpenActiveHigh(true)
                    
                    alertView.delegate = nil;
                    
                    self.navigationController!.popViewController(animated: true)
                }
            }
        }
        else if alertView.tag == AlertViewIndex.modelSelect1.rawValue {
            if buttonIndex != alertView.cancelButtonIndex {
                let modelIndex: ModelIndex = ModelCapability.modelIndexAtIndex(index: buttonIndex - 1)
                
                self.modelName    = ModelCapability.titleAtModelIndex       (modelIndex: modelIndex)
                self.macAddress   = self.portSettings;                                       // for display.
//              self.portSettings = ModelCapability.portSettingsAtModelIndex(modelIndex)
                self.emulation    = ModelCapability.emulationAtModelIndex   (modelIndex: modelIndex)
                
                if ModelCapability.cashDrawerOpenActiveAtModelIndex(modelIndex: modelIndex) == true {
                    let nestAlertView: UIAlertView = UIAlertView.init(title: "Select CashDrawer Open Status.", message: "", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "High when Open", "Low when Open")
                    
                    nestAlertView.tag = AlertViewIndex.cashDrawerOpenActive.rawValue
                    
                    nestAlertView.show()
                }
                else {
                    AppDelegate.setPortName                (self.portName)
                    AppDelegate.setPortSettings            (self.portSettings)
                    AppDelegate.setModelName               (self.modelName)
                    AppDelegate.setMacAddress              (self.macAddress)
                    AppDelegate.setEmulation               (self.emulation)
                    AppDelegate.setCashDrawerOpenActiveHigh(true)
                    
                    alertView.delegate = nil;
                    
                    self.navigationController!.popViewController(animated: true)
                }
            }
        }
        else if alertView.tag == AlertViewIndex.cashDrawerOpenActive.rawValue {
            if buttonIndex != alertView.cancelButtonIndex {
                AppDelegate.setPortName    (self.portName)
                AppDelegate.setPortSettings(self.portSettings)
                AppDelegate.setModelName   (self.modelName)
                AppDelegate.setMacAddress  (self.macAddress)
                AppDelegate.setEmulation   (self.emulation)
                
                if buttonIndex == 1 {     // High when Open
                    AppDelegate.setCashDrawerOpenActiveHigh(true)
                }
                else if buttonIndex == 2 {     // Low when Open
                    AppDelegate.setCashDrawerOpenActiveHigh(false)
                }
                
                alertView.delegate = nil;
                
                self.navigationController!.popViewController(animated: true)
            }
        }
    }
    
    func alertView(_ alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        if alertView.tag == AlertViewIndex.refreshPort.rawValue {
            if buttonIndex == alertView.cancelButtonIndex {
                alertView.delegate = nil
                
                self.navigationController!.popViewController(animated: true)
            }
            else if buttonIndex == 5 {     // Manual
                let nestAlertView: UIAlertView = UIAlertView.init(title: "Please enter the port name.", message: "", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "OK")
                
                nestAlertView.tag            = AlertViewIndex.portName.rawValue
                nestAlertView.alertViewStyle = UIAlertViewStyle.plainTextInput
                
                nestAlertView.textField(at: 0)!.text = AppDelegate.getPortName()
                
                nestAlertView.show()
            }
            else {
                self.blind = true
                
                defer {
                    self.blind = false
                }
                
                self.cellArray.removeAllObjects()
                
                self.selectedIndexPath = nil
                
                let searchPrinterResult: [PortInfo]?
                
                switch buttonIndex {
                case 1  :     // LAN
                    searchPrinterResult = SMPort.searchPrinter("TCP:") as? [PortInfo]
                case 2  :     // Bluetooth
                    searchPrinterResult = SMPort.searchPrinter("BT:")  as? [PortInfo]
                case 3  :     // Bluetooth Low Energy
                    searchPrinterResult = SMPort.searchPrinter("BLE:") as? [PortInfo]
//              case 4  :     // All
                default :
                    searchPrinterResult = SMPort.searchPrinter()       as? [PortInfo]
                }
                
                guard let portInfoArray: [PortInfo] = searchPrinterResult else {
                    self.tableView.reloadData()
                    return
                }
                
                let portName:   String = AppDelegate.getPortName()
                let modelName:  String = AppDelegate.getModelName()
                let macAddress: String = AppDelegate.getMacAddress()
                
                var row: Int = 0
                
                for portInfo: PortInfo in portInfoArray {
                    self.cellArray.add([portInfo.portName, portInfo.modelName, portInfo.macAddress])
                    
                    if portInfo.portName   == portName  &&
                       portInfo.modelName  == modelName &&
                       portInfo.macAddress == macAddress {
                        self.selectedIndexPath = IndexPath(row: row, section: 0)
                    }
                    
                    row += 1
                }
                
                self.tableView.reloadData()
            }
        }
        
        return
    }
}
