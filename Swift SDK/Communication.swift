//
//  Communication.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import Foundation

class Communication {
    static func sendCommands(_ commands: Data!, port: SMPort!) -> Bool {
        var result: Bool = false
        
        var title:   String = ""
        var message: String = ""
        
        var error: NSError?
        
        let length: UInt32 = UInt32(commands.count)
        
        var array: [UInt8] = [UInt8](repeating: 0, count: commands.count)
        
        commands.copyBytes(to: &array, count: commands.count)
        
        while true {
            if port == nil {
                title   = "Fail to Open Port"
                message = ""
                break
            }
            
            var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
            
            port.beginCheckedBlock(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
            if printerStatus.offline == sm_true {
                title   = "Printer Error"
                message = "Printer is offline (BeginCheckedBlock)"
                break
            }
            
            let startDate: Date = Date()
            
            var total: UInt32 = 0
            
            while total < length {
                let written: UInt32 = port.write(array, total, length - total, &error)
                
                if error != nil {
                    break
                }
                
                total += written
                
                if Date().timeIntervalSince(startDate) >= 30.0 {     // 30000mS!!!
                    title   = "Printer Error"
                    message = "Write port timed out"
                    break
                }
            }
            
            if total < length {
                break
            }
            
            port.endCheckedBlockTimeoutMillis = 30000     // 30000mS!!!
            
            port.endCheckedBlock(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
            if printerStatus.offline == sm_true {
                title   = "Printer Error"
                message = "Printer is offline (endCheckedBlock)"
                break
            }
            
            title   = "Send Commands"
            message = "Success"
            
            result = true
            break
        }
        
        if error != nil {
            title   = "Printer Error"
            message = error!.description
        }
        
        DispatchQueue.main.async {
            let alertView: UIAlertView = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
            
            alertView.show()
        }
        
        return result
    }
    
    static func sendCommandsDoNotCheckCondition(_ commands: Data!, port: SMPort!) -> Bool {
        var result: Bool = false
        
        var title:   String = ""
        var message: String = ""
        
        var error: NSError?
        
        let length: UInt32 = UInt32(commands.count)
        
        var array: [UInt8] = [UInt8](repeating: 0, count: commands.count)
        
        commands.copyBytes(to: &array, count: commands.count)
        
        while true {
            if port == nil {
                title   = "Fail to Open Port"
                message = ""
                break
            }
            
            var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
            
            port.getParsedStatus(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
//          if printerStatus.offline == sm_true {     // Do not check condition.
//              title   = "Printer Error"
//              message = "Printer is offline (getParsedStatus)"
//              break
//          }
            
            let startDate: Date = Date()
            
            var total: UInt32 = 0
            
            while total < length {
                let written: UInt32 = port.write(array, total, length - total, &error)
                
                if error != nil {
                    break
                }
                
                total += written
                
                if Date().timeIntervalSince(startDate) >= 30.0 {     // 30000mS!!!
                    title   = "Printer Error"
                    message = "Write port timed out"
                    break
                }
            }
            
            if total < length {
                break
            }
            
            port.getParsedStatus(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
//          if printerStatus.offline == sm_true {     // Do not check condition.
//              title   = "Printer Error"
//              message = "Printer is offline (getParsedStatus)"
//              break
//          }
            
            title   = "Send Commands"
            message = "Success"
            
            result = true
            break
        }
        
        if error != nil {
            title   = "Printer Error"
            message = error!.description
        }
        
        DispatchQueue.main.async {
            let alertView: UIAlertView = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "OK")
            
            alertView.show()
        }
        
        return result
    }
    
    static func sendCommands(_ commands: Data!, portName: String!, portSettings: String!, timeout: UInt32) -> Bool! {
        var result: Bool = false
        
        var title:   String = ""
        var message: String = ""
        
        var error: NSError?
        
        let length: UInt32 = UInt32(commands.count)
        
        var array: [UInt8] = [UInt8](repeating: 0, count: commands.count)
        
        commands.copyBytes(to: &array, count: commands.count)
        
        while true {
            guard let port: SMPort = SMPort.getPort(portName, portSettings, timeout) else {
                title   = "Fail to Open Port"
                message = ""
                break
            }
            
            defer {
                SMPort.release(port)
            }
            
            var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
            
            port.beginCheckedBlock(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
            if printerStatus.offline == sm_true {
                title   = "Printer Error"
                message = "Printer is offline (BeginCheckedBlock)"
                break
            }
            
            let startDate: Date = Date()
            
            var total: UInt32 = 0
            
            while total < length {
                let written: UInt32 = port.write(array, total, length - total, &error)
                
                if error != nil {
                    break
                }
                
                total += written
                
                if Date().timeIntervalSince(startDate) >= 30.0 {     // 30000mS!!!
                    title   = "Printer Error"
                    message = "Write port timed out"
                    break
                }
            }
            
            if total < length {
                break
            }
            
            port.endCheckedBlockTimeoutMillis = 30000     // 30000mS!!!
            
            port.endCheckedBlock(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
            if printerStatus.offline == sm_true {
                title   = "Printer Error"
                message = "Printer is offline (endCheckedBlock)"
                break
            }
            
            title   = "Send Commands"
            message = "Success"
            
            result = true
            break
        }
        
        if error != nil {
            title   = "Printer Error"
            message = error!.description
        }
        
        DispatchQueue.main.async {
            let alertView: UIAlertView = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
            
            alertView.show()
        }
        
        return result
    }
    
    static func sendCommandsDoNotCheckCondition(_ commands: Data!, portName: String!, portSettings: String!, timeout: UInt32) -> Bool! {
        var result: Bool = false
        
        var title:   String = ""
        var message: String = ""
        
        var error: NSError?
        
        let length: UInt32 = UInt32(commands.count)
        
        var array: [UInt8] = [UInt8](repeating: 0, count: commands.count)
        
        commands.copyBytes(to: &array, count: commands.count)
        
        while true {
            guard let port: SMPort = SMPort.getPort(portName, portSettings, timeout) else {
                title   = "Fail to Open Port"
                message = ""
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
            
//          if printerStatus.offline == sm_true {     // Do not check condition.
//              title   = "Printer Error"
//              message = "Printer is offline (getParsedStatus)"
//              break
//          }
            
            let startDate: Date = Date()
            
            var total: UInt32 = 0
            
            while total < length {
                let written: UInt32 = port.write(array, total, length - total, &error)
                
                if error != nil {
                    break
                }
                
                total += written
                
                if Date().timeIntervalSince(startDate) >= 30.0 {     // 30000mS!!!
                    title   = "Printer Error"
                    message = "Write port timed out"
                    break
                }
            }
            
            if total < length {
                break
            }
            
            port.getParsedStatus(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
//          if printerStatus.offline == sm_true {     // Do not check condition.
//              title   = "Printer Error"
//              message = "Printer is offline (getParsedStatus)"
//              break
//          }
            
            title   = "Send Commands"
            message = "Success"
            
            result = true
            break
        }
        
        if error != nil {
            title   = "Printer Error"
            message = error!.description
        }
        
        DispatchQueue.main.async {
            let alertView: UIAlertView = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
            
            alertView.show()
        }
        
        return result
    }

    static func connectBluetooth() {
        EAAccessoryManager.shared().showBluetoothAccessoryPicker(withNameFilter: nil) { (error) -> Void in
            var result: Bool
            var show:   Bool
            
            if error != nil {
                NSLog("Error:%@", error.debugDescription)
                
                switch error!._code {
                case EABluetoothAccessoryPickerError.alreadyConnected.rawValue :
                    result = true
                    show   = true
                case EABluetoothAccessoryPickerError.resultCancelled.rawValue,
                     EABluetoothAccessoryPickerError.resultFailed   .rawValue :
                    result = false
                    show   = false
//              case EABluetoothAccessoryPickerErrorCode.ResultNotFound :
                default                                                 :
                    result = false
                    show   = true
                }
            }
            else {
                result = true
                show   = true
            }
            
            if show == true {
                DispatchQueue.main.async {
                    var alertView: UIAlertView
                    
                    if result == true {
                        alertView = UIAlertView(title: "Success", message: nil, delegate: nil, cancelButtonTitle: "OK")
                    }
                    else {
                        alertView = UIAlertView(title: "Fail to Connect", message: nil, delegate: nil, cancelButtonTitle: "OK")
                    }
                    
                    alertView.show()
                }
            }
        }
    }
    
    static func disconnectBluetooth(_ modelName: String!, portName: String!, portSettings: String!, timeout: UInt32) -> Bool! {
        var result: Bool = false
        
        while true {
            guard let port: SMPort = SMPort.getPort(AppDelegate.getPortName(), AppDelegate.getPortSettings(), 10000) else {     // 10000mS!!!
                break
            }
            
            defer {
                SMPort.release(port)
            }
            
            if modelName.hasPrefix("TSP143IIIBI") == true {
                var error: NSError?
                
                let array: [UInt8] = [0x1b, 0x1c, 0x26, 0x49]     // Only TSP143IIIBI
                
                let length: UInt32 = UInt32(array.count)
                
                var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
                
                port.beginCheckedBlock(&printerStatus, 2, &error)
                
                if error != nil {
                    break
                }
                
                if printerStatus.offline == sm_true {
                    break
                }
                
                let startDate: Date = Date()
                
                var total: UInt32 = 0
                
                while total < length {
                    let written: UInt32 = port.write(array, total, length - total, &error)
                    
                    if error != nil {
                        break
                    }
                    
                    total += written
                    
                    if Date().timeIntervalSince(startDate) >= 30.0 {     // 30000mS!!!
                        break
                    }
                }
                
                if total < length {
                    break
                }
                
//              port.endCheckedBlockTimeoutMillis = 30000     // 30000mS!!!
//
//              port.endCheckedBlock(&printerStatus, 2, &error)
//
//              if error != nil {
//                  break
//              }
//
//              if printerStatus.offline == sm_true {
//                  break
//              }
            }
            else {
                if port.disconnect() == false {
                    break
                }
            }
            
            result = true
            break
        }
        
        DispatchQueue.main.async {
            let alertView: UIAlertView
            
            if result == true {
                alertView = UIAlertView(title: "Success", message: nil, delegate: nil, cancelButtonTitle: "OK")
            }
            else {
                alertView = UIAlertView(title: "Fail to Disconnect", message: "Note. Portable Printers is not supported.", delegate: nil, cancelButtonTitle: "OK")
            }
            
            alertView.show()
        }
        
        return result
    }
}
