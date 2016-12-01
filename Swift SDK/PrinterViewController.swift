//
//  PrinterViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import UIKit

class CustomUIImagePickerController: UIImagePickerController {
    override var shouldAutorotate : Bool {
        return true
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if AppDelegate.isIPad() {
            return UIInterfaceOrientationMask.all
        }
        
        return UIInterfaceOrientationMask.allButUpsideDown
    }
}

class PrinterViewController: CommonViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 2 {
            return 7
        }
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "UITableViewCellStyleValue1"
        
        var cell: UITableViewCell! = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: cellIdentifier)
        }
        
        if cell != nil {
            if indexPath.section != 2 {
                let localizeReceipts: ILocalizeReceipts = LocalizeReceipts.createLocalizeReceipts(AppDelegate.getSelectedLanguage(), paperSizeIndex: AppDelegate.getSelectedPaperSize())
                
                switch indexPath.row {
                case 0 :
                    cell.textLabel!.text = String(format: "%@ %@ Text Receipt",                localizeReceipts.languageCode, localizeReceipts.paperSize)
                case 1 :
                    cell.textLabel!.text = String(format: "%@ %@ Text Receipt (UTF8)",         localizeReceipts.languageCode, localizeReceipts.paperSize)
                case 2 :
                    cell.textLabel!.text = String(format: "%@ %@ Raster Receipt",              localizeReceipts.languageCode, localizeReceipts.paperSize)
                case 3 :
                    cell.textLabel!.text = String(format: "%@ %@ Raster Receipt (Both Scale)", localizeReceipts.languageCode, localizeReceipts.scalePaperSize)
                case 4 :
                    cell.textLabel!.text = String(format: "%@ %@ Raster Receipt (Scale)",      localizeReceipts.languageCode, localizeReceipts.scalePaperSize)
                case 5 :
                    cell.textLabel!.text = String(format: "%@ Raster Coupon",                  localizeReceipts.languageCode)
//              case 6  :
                default :
                    cell.textLabel!.text = String(format: "%@ Raster Coupon (Rotation90)",     localizeReceipts.languageCode)
                }
                
                cell.detailTextLabel!.text = ""
                
                cell      .textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                
//              cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                
                var userInteractionEnabled: Bool = true
                
                let emulation: StarIoExtEmulation = AppDelegate.getEmulation()
                
                if emulation == StarIoExtEmulation.starGraphic {
                    if indexPath.row == 0 ||     // Text Receipt
                       indexPath.row == 1 {     // Text Receipt (UTF8)
                        userInteractionEnabled = false
                    }
                }
                
                if emulation == StarIoExtEmulation.escPos ||
                   emulation == StarIoExtEmulation.escPosMobile {
                    if indexPath.row == 1 {     // Text Receipt (UTF8)
                        userInteractionEnabled = false
                    }
                }
                
                if emulation == StarIoExtEmulation.starDotImpact {
                    if indexPath.row == 2 ||     // Raster Receipt
                       indexPath.row == 3 ||     // Raster Receipt (Both Scale)
                       indexPath.row == 4 {      // Raster Receipt (Scale)
                        userInteractionEnabled = false
                    }
                }
                
                if userInteractionEnabled == true {
                    cell      .textLabel!.alpha = 1.0
                    cell.detailTextLabel!.alpha = 1.0
                    
                    cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                    
                    cell.isUserInteractionEnabled = true
                }
                else {
                    cell      .textLabel!.alpha = 0.3
                    cell.detailTextLabel!.alpha = 0.3
                    
                    cell.accessoryType = UITableViewCellAccessoryType.none
                    
                    cell.isUserInteractionEnabled = false
                }
            }
            else {
                if (indexPath.row == 0) {
                    cell.textLabel!.text = "Print Photo from Library"
                }
                else {
                    cell.textLabel!.text = "Print Photo by Camera"
                }
                
                cell.detailTextLabel!.text = ""
                
                cell      .textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                
//              cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                
                var userInteractionEnabled: Bool = true
                
                let emulation: StarIoExtEmulation = AppDelegate.getEmulation()
                
                if emulation == StarIoExtEmulation.starDotImpact {
                    userInteractionEnabled = false
                }
                
                if userInteractionEnabled == true {
                    cell      .textLabel!.alpha = 1.0
                    cell.detailTextLabel!.alpha = 1.0
                    
                    cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                    
                    cell.isUserInteractionEnabled = true
                }
                else {
                    cell      .textLabel!.alpha = 0.3
                    cell.detailTextLabel!.alpha = 0.3
                    
                    cell.accessoryType = UITableViewCellAccessoryType.none
                    
                    cell.isUserInteractionEnabled = false
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title: String
        
        if section == 0 {
            title = "Like a StarIO-SDK Sample"
        }
        else if section == 1 {
            title = "StarIoExtManager Sample"
        }
        else {
            title = "Appendix"
        }
        
        return title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            let commands: Data
            
            let emulation: StarIoExtEmulation = AppDelegate.getEmulation()
            
            let width: Int = AppDelegate.getSelectedPaperSize().rawValue
            
            let localizeReceipts: ILocalizeReceipts = LocalizeReceipts.createLocalizeReceipts(AppDelegate.getSelectedLanguage(), paperSizeIndex: AppDelegate.getSelectedPaperSize())
            
            switch indexPath.row {
            case 0 :
                commands = PrinterFunctions.createTextReceiptData(emulation, localizeReceipts: localizeReceipts, utf8: false)
            case 1 :
                commands = PrinterFunctions.createTextReceiptData(emulation, localizeReceipts: localizeReceipts, utf8: true)
            case 2 :
                commands = PrinterFunctions.createRasterReceiptData(emulation, localizeReceipts: localizeReceipts)
            case 3 :
                commands = PrinterFunctions.createScaleRasterReceiptData(emulation, localizeReceipts: localizeReceipts, width: width, bothScale: true)
            case 4 :
                commands = PrinterFunctions.createScaleRasterReceiptData(emulation, localizeReceipts: localizeReceipts, width: width, bothScale: false)
            case 5 :
                commands = PrinterFunctions.createCouponData(emulation, localizeReceipts: localizeReceipts, width: width, rotation: SCBBitmapConverterRotation.normal)
//          case 6  :
            default :
                commands = PrinterFunctions.createCouponData(emulation, localizeReceipts: localizeReceipts, width: width, rotation: SCBBitmapConverterRotation.right90)
            }
            
            self.blind = true
            
            defer {
                self.blind = false
            }
            
            Communication.sendCommands(commands, portName: AppDelegate.getPortName(), portSettings: AppDelegate.getPortSettings(), timeout: 10000)     // 10000mS!!!
        }
        else if indexPath.section == 1 {
            AppDelegate.setSelectedIndex(indexPath.row)
            
            self.performSegue(withIdentifier: "PushPrinterExtViewController", sender: nil)
        }
        else {
            if (indexPath.row == 0) {
//              let imagePickerController:       UIImagePickerController =       UIImagePickerController()
                let imagePickerController: CustomUIImagePickerController = CustomUIImagePickerController()
                
                imagePickerController.sourceType    = UIImagePickerControllerSourceType.photoLibrary
                imagePickerController.allowsEditing = false
                imagePickerController.delegate      = self
                
                self.present(imagePickerController, animated: true, completion: nil)
            }
            else {
                let imagePickerController: UIImagePickerController = UIImagePickerController()
                
                imagePickerController.sourceType    = UIImagePickerControllerSourceType.camera
                imagePickerController.allowsEditing = false
                imagePickerController.delegate      = self
                
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }
    }
    
    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//      let image: UIImage = info[UIImagePickerControllerEditedImage]   as! UIImage
        
        self.dismiss(animated: true, completion: nil)
        
        let commands: Data
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(AppDelegate.getEmulation())
        
        builder.beginDocument()
        
        builder.appendBitmap(image, diffusion: true, width: AppDelegate.getSelectedPaperSize().rawValue, bothScale: true)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        commands = builder.commands.copy() as! Data
        
        self.blind = true
        
        defer {
            self.blind = false
        }
        
        Communication.sendCommands(commands, portName: AppDelegate.getPortName(), portSettings: AppDelegate.getPortSettings(), timeout: 10000)     // 10000mS!!!
    }
}
