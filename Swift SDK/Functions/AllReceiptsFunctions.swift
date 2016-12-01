//
//  AllReceiptsFunctions.swift
//  Swift SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

import Foundation

class AllReceiptsFunctions {
    static func createRasterReceiptData(_ emulation: StarIoExtEmulation, localizeReceipts: ILocalizeReceipts, receipt: Bool, info: Bool, qrCode: Bool, completion: @escaping ((Int, Error?) -> Void)) -> Data? {
        let image: UIImage = localizeReceipts.createRasterReceiptImage()!
        
        let urlString: String = SMCSAllReceipts.uploadBitmap(image, completion: completion)
        
        if receipt == true ||
           info    == true ||
           qrCode  == true {
            let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
            
            builder.beginDocument()
            
            if receipt == true {
                builder.appendBitmap(image, diffusion: false)
            }
            
            if info   == true ||
               qrCode == true {
                let allReceiptsData: Data = SMCSAllReceipts.generate(urlString, emulation: emulation, info: info, qrCode: qrCode)
                
//              builder.appendData   (allReceiptsData)
                builder.appendRawData(allReceiptsData)
            }
            
            builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
            
            builder.endDocument()
            
            return builder.commands.copy() as? Data
        }
        
        return nil
    }
    
    static func createScaleRasterReceiptData(_ emulation: StarIoExtEmulation, localizeReceipts: ILocalizeReceipts, width: Int, bothScale: Bool, receipt: Bool, info: Bool, qrCode: Bool, completion: @escaping ((Int, Error?) -> Void)) -> Data? {
        let image: UIImage = localizeReceipts.createScaleRasterReceiptImage()!
        
        let urlString: String = SMCSAllReceipts.uploadBitmap(image, completion: completion)
        
        if receipt == true ||
           info    == true ||
           qrCode  == true {
            let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
            
            builder.beginDocument()
            
            if receipt == true {
                builder.appendBitmap(image, diffusion: false, width: width, bothScale: bothScale)
            }
            
            if info   == true ||
               qrCode == true {
                let allReceiptsData: Data = SMCSAllReceipts.generate(urlString, emulation: emulation, info: info, qrCode: qrCode)
                
//              builder.appendData   (allReceiptsData)
                builder.appendRawData(allReceiptsData)
            }
            
            builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
            
            builder.endDocument()
            
            return builder.commands.copy() as? Data
        }
        
        return nil
    }
}
