//
//  ApiFunctions.swift
//  Swift SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

import Foundation

class ApiFunctions {
    static func createGenericData(_ emulation: StarIoExtEmulation) -> Data {
        let otherData: Data = "Hello World.".data(using: String.Encoding.ascii)!
        
        let bytes: [UInt8] = [0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e]
        
        let length: UInt = UInt(bytes.count)
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.append(otherData)
        builder.appendByte(0x0a)
        
        builder.appendBytes(bytes, length: length)
        builder.appendByte(0x0a)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createFontStyleData(_ emulation: StarIoExtEmulation) -> Data {
        let otherData: Data = "Hello World.\n".data(using: String.Encoding.ascii)!
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.append(otherData)
        builder.append(SCBFontStyleType.B)
        builder.append(otherData)
        builder.append(SCBFontStyleType.A)
        builder.append(otherData)
        builder.append(SCBFontStyleType.B)
        builder.append(otherData)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createInitializationData(_ emulation: StarIoExtEmulation) -> Data {
        let otherData: Data = "Hello World.\n".data(using: String.Encoding.ascii)!
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.append(otherData)
        builder.appendMultiple(2, height: 2)
        builder.append(otherData)
        builder.append(SCBFontStyleType.B)
        builder.append(otherData)
        builder.append(SCBInitializationType.command)
        builder.append(otherData)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createCodePageData(_ emulation: StarIoExtEmulation) -> Data {
        let bytes2: [UInt8] = [0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 0x0a]
        let bytes3: [UInt8] = [0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f, 0x0a]
        let bytes4: [UInt8] = [0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, 0x0a]
        let bytes5: [UInt8] = [0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f, 0x0a]
        let bytes6: [UInt8] = [0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, 0x0a]
        let bytes7: [UInt8] = [0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f, 0x0a]
        let bytes8: [UInt8] = [0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f, 0x0a]
        let bytes9: [UInt8] = [0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f, 0x0a]
        let bytesA: [UInt8] = [0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7, 0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf, 0x0a]
        let bytesB: [UInt8] = [0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7, 0xb8, 0xb9, 0xba, 0xbb, 0xbc, 0xbd, 0xbe, 0xbf, 0x0a]
        let bytesC: [UInt8] = [0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7, 0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd, 0xce, 0xcf, 0x0a]
        let bytesD: [UInt8] = [0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7, 0xd8, 0xd9, 0xda, 0xdb, 0xdc, 0xdd, 0xde, 0xdf, 0x0a]
        let bytesE: [UInt8] = [0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7, 0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0xef, 0x0a]
        let bytesF: [UInt8] = [0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff, 0x0a]
        
        let length: UInt = UInt(bytes2.count)
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.append(SCBCodePageType.CP998);  builder.append("*CP998*\n".data(using: String.Encoding.ascii))
        
        builder.appendBytes(bytes2, length: length)
        builder.appendBytes(bytes3, length: length)
        builder.appendBytes(bytes4, length: length)
        builder.appendBytes(bytes5, length: length)
        builder.appendBytes(bytes6, length: length)
        builder.appendBytes(bytes7, length: length)
        builder.appendBytes(bytes8, length: length)
        builder.appendBytes(bytes9, length: length)
        builder.appendBytes(bytesA, length: length)
        builder.appendBytes(bytesB, length: length)
        builder.appendBytes(bytesC, length: length)
        builder.appendBytes(bytesD, length: length)
        builder.appendBytes(bytesE, length: length)
        builder.appendBytes(bytesF, length: length)
        
        builder.append("\n".data(using: String.Encoding.ascii))
        
//      builder.appendCodePage(SCBCodePageType.CP437);  builder.appendData("*CP437*\n" .dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP737);  builder.appendData("*CP737*\n" .dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP772);  builder.appendData("*CP772*\n" .dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP774);  builder.appendData("*CP774*\n" .dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP851);  builder.appendData("*CP851*\n" .dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP852);  builder.appendData("*CP852*\n" .dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP855);  builder.appendData("*CP855*\n" .dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP857);  builder.appendData("*CP857*\n" .dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP858);  builder.appendData("*CP858*\n" .dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP860);  builder.appendData("*CP860*\n" .dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP861);  builder.appendData("*CP861*\n" .dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP862);  builder.appendData("*CP862*\n" .dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP863);  builder.appendData("*CP863*\n" .dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP864);  builder.appendData("*CP864*\n" .dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP865);  builder.appendData("*CP865*\n" .dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP866);  builder.appendData("*CP866*\n" .dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP869);  builder.appendData("*CP869*\n" .dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP874);  builder.appendData("*CP874*\n" .dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP928);  builder.appendData("*CP928*\n" .dataUsingEncoding(NSASCIIStringEncoding))
        builder.append(SCBCodePageType.CP932);  builder.append("*CP932*\n" .data(using: String.Encoding.ascii))
//      builder.appendCodePage(SCBCodePageType.CP998);  builder.appendData("*CP998*\n" .dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP999);  builder.appendData("*CP999*\n" .dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP1001); builder.appendData("*CP1001*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP1250); builder.appendData("*CP1250*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP1251); builder.appendData("*CP1251*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP1252); builder.appendData("*CP1252*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP2001); builder.appendData("*CP2001*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP3001); builder.appendData("*CP3001*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP3002); builder.appendData("*CP3002*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP3011); builder.appendData("*CP3011*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP3012); builder.appendData("*CP3012*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP3021); builder.appendData("*CP3021*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP3041); builder.appendData("*CP3041*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP3840); builder.appendData("*CP3840*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP3841); builder.appendData("*CP3841*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP3843); builder.appendData("*CP3843*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP3844); builder.appendData("*CP3844*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP3845); builder.appendData("*CP3845*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP3846); builder.appendData("*CP3846*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP3847); builder.appendData("*CP3847*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.CP3848); builder.appendData("*CP3848*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendCodePage(SCBCodePageType.Blank);  builder.appendData("*Blank*\n" .dataUsingEncoding(NSASCIIStringEncoding))
        
        builder.appendBytes(bytes2, length: length)
        builder.appendBytes(bytes3, length: length)
        builder.appendBytes(bytes4, length: length)
        builder.appendBytes(bytes5, length: length)
        builder.appendBytes(bytes6, length: length)
        builder.appendBytes(bytes7, length: length)
        builder.appendBytes(bytes8, length: length)
        builder.appendBytes(bytes9, length: length)
        builder.appendBytes(bytesA, length: length)
        builder.appendBytes(bytesB, length: length)
        builder.appendBytes(bytesC, length: length)
        builder.appendBytes(bytesD, length: length)
        builder.appendBytes(bytesE, length: length)
        builder.appendBytes(bytesF, length: length)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createInternationalData(_ emulation: StarIoExtEmulation) -> Data {
        let bytes: [UInt8] = [0x23, 0x24, 0x40, 0x58, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x60, 0x7b, 0x7c, 0x7d, 0x7e, 0x0a]
        
        let length: UInt = UInt(bytes.count)
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.append("*USA*\n".data(using: String.Encoding.ascii))
        builder.append(SCBInternationalType.USA)
        builder.appendBytes(bytes, length: length)
        
        builder.append("*France*\n".data(using: String.Encoding.ascii))
        builder.append(SCBInternationalType.france)
        builder.appendBytes(bytes, length: length)
        
        builder.append("*Germany*\n".data(using: String.Encoding.ascii))
        builder.append(SCBInternationalType.germany)
        builder.appendBytes(bytes, length: length)
        
        builder.append("*UK*\n".data(using: String.Encoding.ascii))
        builder.append(SCBInternationalType.UK)
        builder.appendBytes(bytes, length: length)
        
        builder.append("*Denmark*\n".data(using: String.Encoding.ascii))
        builder.append(SCBInternationalType.denmark)
        builder.appendBytes(bytes, length: length)
        
        builder.append("*Sweden*\n".data(using: String.Encoding.ascii))
        builder.append(SCBInternationalType.sweden)
        builder.appendBytes(bytes, length: length)
        
        builder.append("*Italy*\n".data(using: String.Encoding.ascii))
        builder.append(SCBInternationalType.italy)
        builder.appendBytes(bytes, length: length)
        
        builder.append("*Spain*\n".data(using: String.Encoding.ascii))
        builder.append(SCBInternationalType.spain)
        builder.appendBytes(bytes, length: length)
        
        builder.append("*Japan*\n".data(using: String.Encoding.ascii))
        builder.append(SCBInternationalType.japan)
        builder.appendBytes(bytes, length: length)
        
        builder.append("*Norway*\n".data(using: String.Encoding.ascii))
        builder.append(SCBInternationalType.norway)
        builder.appendBytes(bytes, length: length)
        
        builder.append("*Denmark2*\n".data(using: String.Encoding.ascii))
        builder.append(SCBInternationalType.denmark2)
        builder.appendBytes(bytes, length: length)
        
        builder.append("*Spain2*\n".data(using: String.Encoding.ascii))
        builder.append(SCBInternationalType.spain2)
        builder.appendBytes(bytes, length: length)
        
        builder.append("*LatinAmerica*\n".data(using: String.Encoding.ascii))
        builder.append(SCBInternationalType.latinAmerica)
        builder.appendBytes(bytes, length: length)
        
        builder.append("*Korea*\n".data(using: String.Encoding.ascii))
        builder.append(SCBInternationalType.korea)
        builder.appendBytes(bytes, length: length)
        
        builder.append("*Ireland*\n".data(using: String.Encoding.ascii))
        builder.append(SCBInternationalType.ireland)
        builder.appendBytes(bytes, length: length)
        
        builder.append("*Legal*\n".data(using: String.Encoding.ascii))
        builder.append(SCBInternationalType.legal)
        builder.appendBytes(bytes, length: length)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createFeedData(_ emulation: StarIoExtEmulation) -> Data {
        let otherData:       Data = "Hello World."  .data(using: String.Encoding.ascii)!
        let otherDataWithLf: Data = "Hello World.\n".data(using: String.Encoding.ascii)!
        
        let bytes: [UInt8] = [0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e]
        
        let length: UInt = UInt(bytes.count)
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.append(otherData)
        builder.appendLineFeed()
        
        builder.appendData(withLineFeed: otherData)
        
        builder.appendBytes(withLineFeed: bytes, length: length)
        
        builder.append(otherData)
        builder.appendLineFeed(2)
        
        builder.appendData(withLineFeed: otherData, line: 2)
        
        builder.appendBytes(withLineFeed: bytes, length: length, line: 2)
        
        builder.append(otherData)
        builder.appendUnitFeed(64)
        
        builder.appendData(withUnitFeed: otherData, unit: 64)
        
        builder.appendBytes(withUnitFeed: bytes, length: length, unit: 64)
        
        builder.append(otherDataWithLf)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createCharacterSpaceData(_ emulation: StarIoExtEmulation) -> Data {
        let otherData: Data = "Hello World.".data(using: String.Encoding.ascii)!
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.appendCharacterSpace(0)
        builder.appendData(withLineFeed: otherData)
        builder.appendCharacterSpace(1)
        builder.appendData(withLineFeed: otherData)
        builder.appendCharacterSpace(2)
        builder.appendData(withLineFeed: otherData)
        builder.appendCharacterSpace(3)
        builder.appendData(withLineFeed: otherData)
        builder.appendCharacterSpace(4)
        builder.appendData(withLineFeed: otherData)
        builder.appendCharacterSpace(5)
        builder.appendData(withLineFeed: otherData)
        builder.appendCharacterSpace(6)
        builder.appendData(withLineFeed: otherData)
        builder.appendCharacterSpace(7)
        builder.appendData(withLineFeed: otherData)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createLineSpaceData(_ emulation: StarIoExtEmulation) -> Data {
        let otherData: Data = "Hello World.".data(using: String.Encoding.ascii)!
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.appendLineSpace(32)
        builder.appendData(withLineFeed: otherData)
        builder.appendData(withLineFeed: otherData)
        builder.appendData(withLineFeed: otherData)
        builder.appendLineSpace(24)
        builder.appendData(withLineFeed: otherData)
        builder.appendData(withLineFeed: otherData)
        builder.appendData(withLineFeed: otherData)
        builder.appendLineSpace(32)
        builder.appendData(withLineFeed: otherData)
        builder.appendData(withLineFeed: otherData)
        builder.appendData(withLineFeed: otherData)
        builder.appendLineSpace(24)
        builder.appendData(withLineFeed: otherData)
        builder.appendData(withLineFeed: otherData)
        builder.appendData(withLineFeed: otherData)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createEmphasisData(_ emulation: StarIoExtEmulation) -> Data {
        let otherData:      Data = "Hello World.\n".data(using: String.Encoding.ascii)!
        let otherDataHalf0: Data = "Hello "        .data(using: String.Encoding.ascii)!
        let otherDataHalf1: Data =       "World.\n".data(using: String.Encoding.ascii)!
        
        let bytes:      [UInt8] = [0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e, 0x0a]
        let bytesHalf0: [UInt8] = [0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20]
        let bytesHalf1: [UInt8] =                                     [0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e, 0x0a]
        
        let length:      UInt = UInt(bytes     .count)
        let lengthHalf0: UInt = UInt(bytesHalf0.count)
        let lengthHalf1: UInt = UInt(bytesHalf1.count)
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.append(otherData)
        
        builder.appendEmphasis(true)
        builder.append(otherData)
        builder.appendEmphasis(false)
        builder.append(otherData)
        
        builder.appendData(withEmphasis: otherData)
        builder.append            (otherData)
        
        builder.appendBytes(withEmphasis: bytes, length: length)
        builder.appendBytes            (bytes, length: length)
        
        builder.appendData(withEmphasis: otherDataHalf0)
        builder.append            (otherDataHalf1)
        
        builder.appendBytes            (bytesHalf0, length: lengthHalf0)
        builder.appendBytes(withEmphasis: bytesHalf1, length: lengthHalf1)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createInvertData(_ emulation: StarIoExtEmulation) -> Data {
        let otherData:      Data = "Hello World.\n".data(using: String.Encoding.ascii)!
        let otherDataHalf0: Data = "Hello "        .data(using: String.Encoding.ascii)!
        let otherDataHalf1: Data =       "World.\n".data(using: String.Encoding.ascii)!
        
        let bytes:      [UInt8] = [0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e, 0x0a]
        let bytesHalf0: [UInt8] = [0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20]
        let bytesHalf1: [UInt8] =                                     [0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e, 0x0a]
        
        let length:      UInt = UInt(bytes     .count)
        let lengthHalf0: UInt = UInt(bytesHalf0.count)
        let lengthHalf1: UInt = UInt(bytesHalf1.count)
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.append(otherData)
        
        builder.appendInvert(true)
        builder.append(otherData)
        builder.appendInvert(false)
        builder.append(otherData)
        
        builder.appendData(withInvert: otherData)
        builder.append          (otherData)
        
        builder.appendBytes(withInvert: bytes, length: length)
        builder.appendBytes          (bytes, length: length)
        
        builder.appendData(withInvert: otherDataHalf0)
        builder.append          (otherDataHalf1)
        
        builder.appendBytes          (bytesHalf0, length: lengthHalf0)
        builder.appendBytes(withInvert: bytesHalf1, length: lengthHalf1)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createUnderLineData(_ emulation: StarIoExtEmulation) -> Data {
        let otherData:      Data = "Hello World.\n".data(using: String.Encoding.ascii)!
        let otherDataHalf0: Data = "Hello "        .data(using: String.Encoding.ascii)!
        let otherDataHalf1: Data =       "World.\n".data(using: String.Encoding.ascii)!
        
        let bytes:      [UInt8] = [0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e, 0x0a]
        let bytesHalf0: [UInt8] = [0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20]
        let bytesHalf1: [UInt8] =                                     [0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e, 0x0a]
        
        let length:      UInt = UInt(bytes     .count)
        let lengthHalf0: UInt = UInt(bytesHalf0.count)
        let lengthHalf1: UInt = UInt(bytesHalf1.count)
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.append(otherData)
        
        builder.appendUnderLine(true)
        builder.append(otherData)
        builder.appendUnderLine(false)
        builder.append(otherData)
        
        builder.appendData(withUnderLine: otherData)
        builder.append             (otherData)
        
        builder.appendBytes(withUnderLine: bytes, length: length)
        builder.appendBytes             (bytes, length: length)
        
        builder.appendData(withUnderLine: otherDataHalf0)
        builder.append             (otherDataHalf1)
        
        builder.appendBytes             (bytesHalf0, length: lengthHalf0)
        builder.appendBytes(withUnderLine: bytesHalf1, length: lengthHalf1)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createMultipleData(_ emulation: StarIoExtEmulation) -> Data {
        let otherData:      Data = "Hello World.\n".data(using: String.Encoding.ascii)!
        let otherDataHalf0: Data = "Hello "        .data(using: String.Encoding.ascii)!
        let otherDataHalf1: Data =       "World.\n".data(using: String.Encoding.ascii)!
        
        let bytes:      [UInt8] = [0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e, 0x0a]
        let bytesHalf0: [UInt8] = [0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20]
        let bytesHalf1: [UInt8] =                                     [0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e, 0x0a]
        
        let length:      UInt = UInt(bytes     .count)
        let lengthHalf0: UInt = UInt(bytesHalf0.count)
        let lengthHalf1: UInt = UInt(bytesHalf1.count)
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.append(otherData)
        
        builder.appendMultiple(2, height: 2)
        builder.append(otherData)
        builder.appendMultiple(1, height: 1)
        builder.append(otherData)
        
        builder.appendData(withMultiple: otherData, width: 2, height: 2)
        builder.append            (otherData)
        
        builder.appendBytes(withMultiple: bytes, length: length, width: 2, height: 2)
        builder.appendBytes            (bytes, length: length)
        
        builder.appendData(withMultiple: otherDataHalf0, width: 2, height: 2)
        builder.append            (otherDataHalf1)
        
        builder.appendBytes            (bytesHalf0, length: lengthHalf0)
        builder.appendBytes(withMultiple: bytesHalf1, length: lengthHalf1, width: 2, height: 2)
        
        builder.appendMultipleHeight(2)
        builder.append(otherData)
        builder.appendMultipleHeight(1)
        builder.append(otherData)
        
        builder.appendData(withMultipleHeight: otherDataHalf0, height: 2)
        builder.append                  (otherDataHalf1)
        
        builder.appendBytes                  (bytesHalf0, length: lengthHalf0)
        builder.appendBytes(withMultipleHeight: bytesHalf1, length: lengthHalf1, height: 2)
        
        builder.appendMultipleWidth(2)
        builder.append(otherData)
        builder.appendMultipleWidth(1)
        builder.append(otherData)
        
        builder.appendData(withMultipleWidth: otherDataHalf0, width: 2)
        builder.append                 (otherDataHalf1)
        
        builder.appendBytes                 (bytesHalf0, length: lengthHalf0)
        builder.appendBytes(withMultipleWidth: bytesHalf1, length: lengthHalf1, width: 2)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createAbsolutePositionData(_ emulation: StarIoExtEmulation) -> Data {
        let otherData: Data = "Hello World.\n".data(using: String.Encoding.ascii)!
        
        let bytes: [UInt8] = [0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e, 0x0a]
        
        let length: UInt = UInt(bytes.count)
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.append(otherData)
        
        builder.appendAbsolutePosition(40)
        builder.append(otherData)
        builder.append(otherData)
        
        builder.appendData(withAbsolutePosition: otherData, position:40)
        builder.append                    (otherData)
        
        builder.appendBytes(withAbsolutePosition: bytes, length: length, position: 40)
        builder.appendBytes                    (bytes, length: length)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createAlignmentData(_ emulation: StarIoExtEmulation) -> Data {
        let otherData: Data = "Hello World.\n".data(using: String.Encoding.ascii)!
        
        let bytes: [UInt8] = [0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e, 0x0a]
        
        let length: UInt = UInt(bytes.count)
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.append(otherData)
        
        builder.appendAlignment(SCBAlignmentPosition.center)
        builder.append(otherData)
        builder.appendAlignment(SCBAlignmentPosition.right)
        builder.append(otherData)
        builder.appendAlignment(SCBAlignmentPosition.left)
        builder.append(otherData)
        
        builder.appendData(withAlignment: otherData, position:SCBAlignmentPosition.center)
        builder.appendData(withAlignment: otherData, position:SCBAlignmentPosition.right)
        builder.append             (otherData)
        
        builder.appendBytes(withAlignment: bytes, length: length, position:SCBAlignmentPosition.center)
        builder.appendBytes(withAlignment: bytes, length: length, position:SCBAlignmentPosition.right)
        builder.appendBytes             (bytes, length: length)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createLogoData(_ emulation: StarIoExtEmulation) -> Data {
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.append("*Normal*\n".data(using: String.Encoding.ascii))
        builder.appendLogo(SCBLogoSize.normal,                  number: 1)
        
        builder.append("\n*Double Width*\n".data(using: String.Encoding.ascii))
        builder.appendLogo(SCBLogoSize.doubleWidth,             number: 1)
        
        builder.append("\n*Double Height*\n".data(using: String.Encoding.ascii))
        builder.appendLogo(SCBLogoSize.doubleHeight,            number: 1)
        
        builder.append("\n*Double Width and Double Height*\n".data(using: String.Encoding.ascii))
        builder.appendLogo(SCBLogoSize.doubleWidthDoubleHeight, number: 1)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createCutPaperData(_ emulation: StarIoExtEmulation) -> Data {
        let otherData: Data = "Hello World.\n".data(using: String.Encoding.ascii)!
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        
        builder.appendCutPaper(SCBCutPaperAction.fullCut)
        
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCut)
        
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        
        builder.appendCutPaper(SCBCutPaperAction.fullCutWithFeed)
        
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        builder.append(otherData)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createPeripheralData(_ emulation: StarIoExtEmulation) -> Data {
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.appendPeripheral(SCBPeripheralChannel.no1)
        builder.appendPeripheral(SCBPeripheralChannel.no2)
        builder.appendPeripheral(SCBPeripheralChannel.no1, time: 2000)
        builder.appendPeripheral(SCBPeripheralChannel.no2, time: 2000)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createSoundData(_ emulation: StarIoExtEmulation) -> Data {
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.appendSound(SCBSoundChannel.no1)
        builder.appendSound(SCBSoundChannel.no2)
//      builder.appendSound(SCBSoundChannel.No1, 'repeat': 3)
        builder.appendSound(SCBSoundChannel.no1,  repeat : 3)
//      builder.appendSound(SCBSoundChannel.No2, 'repeat': 3)
        builder.appendSound(SCBSoundChannel.no2,  repeat : 3)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createBitmapData(_ emulation: StarIoExtEmulation, width: Int) -> Data {
        let sphereImage:   UIImage = UIImage(named: "SphereImage")!
        let starLogoImage: UIImage = UIImage(named: "StarLogoImage")!
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.append("*diffusion:true*\n"   .data(using: String.Encoding.ascii))
        builder.appendBitmap(sphereImage, diffusion: true)
        builder.append("\n*diffusion:false*\n".data(using: String.Encoding.ascii))
        builder.appendBitmap(sphereImage, diffusion: false)
        
        builder.append("\n*Normal*\n".data(using: String.Encoding.ascii))
        builder.appendBitmap(starLogoImage, diffusion: true)
        
        builder.append("\n*width:Full, bothScale:true*\n" .data(using: String.Encoding.ascii))
        builder.appendBitmap(starLogoImage, diffusion: true, width: width, bothScale: true)
        builder.append("\n*width:Full, bothScale:false*\n".data(using: String.Encoding.ascii))
        builder.appendBitmap(starLogoImage, diffusion: true, width: width, bothScale: false)
        
        builder.append("\n*Right90*\n"  .data(using: String.Encoding.ascii))
        builder.appendBitmap(starLogoImage, diffusion: true, rotation: SCBBitmapConverterRotation.right90)
        builder.append("\n*Rotate180*\n".data(using: String.Encoding.ascii))
        builder.appendBitmap(starLogoImage, diffusion: true, rotation: SCBBitmapConverterRotation.rotate180)
//      builder.appendData("\n*Left90*\n"   .dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBitmap(starLogoImage, diffusion: true, rotation: SCBBitmapConverterRotation.Left90)
        
        builder.append("\n*Normal,    AbsolutePosition:40*\n".data(using: String.Encoding.ascii))
        builder.appendBitmap(withAbsolutePosition: starLogoImage, diffusion: true, position: 40)
//      builder.appendData("\n*Right90,   AbsolutePosition:40*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBitmapWithAbsolutePosition(starLogoImage, diffusion: true, rotation: SCBBitmapConverterRotation.Right90,   position: 40)
//      builder.appendData("\n*Rotate180, AbsolutePosition:40*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBitmapWithAbsolutePosition(starLogoImage, diffusion: true, rotation: SCBBitmapConverterRotation.Rotate180, position: 40)
//      builder.appendData("\n*Left90,    AbsolutePosition:40*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBitmapWithAbsolutePosition(starLogoImage, diffusion: true, rotation: SCBBitmapConverterRotation.Left90,    position: 40)
        
        builder.append("\n*Normal,    Alignment:Center*\n".data(using: String.Encoding.ascii))
        builder.appendBitmap(withAlignment: starLogoImage, diffusion: true, position: SCBAlignmentPosition.center)
//      builder.appendData("\n*Right90,   Alignment:Center*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBitmapWithAlignment(starLogoImage, diffusion: true, rotation: SCBBitmapConverterRotation.Right90,   position: SCBAlignmentPosition.Center)
//      builder.appendData("\n*Rotate180, Alignment:Center*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBitmapWithAlignment(starLogoImage, diffusion: true, rotation: SCBBitmapConverterRotation.Rotate180, position: SCBAlignmentPosition.Center)
//      builder.appendData("\n*Left90,    Alignment:Center*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBitmapWithAlignment(starLogoImage, diffusion: true, rotation: SCBBitmapConverterRotation.Left90,    position: SCBAlignmentPosition.Center)
        
        builder.append("\n*Normal,    Alignment:Right*\n".data(using: String.Encoding.ascii))
        builder.appendBitmap(withAlignment: starLogoImage, diffusion: true, position: SCBAlignmentPosition.right)
//      builder.appendData("\n*Right90,   Alignment:Right*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBitmapWithAlignment(starLogoImage, diffusion: true, rotation: SCBBitmapConverterRotation.Right90,   position: SCBAlignmentPosition.Right)
//      builder.appendData("\n*Rotate180, Alignment:Right*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBitmapWithAlignment(starLogoImage, diffusion: true, rotation: SCBBitmapConverterRotation.Rotate180, position: SCBAlignmentPosition.Right)
//      builder.appendData("\n*Left90,    Alignment:Right*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBitmapWithAlignment(starLogoImage, diffusion: true, rotation: SCBBitmapConverterRotation.Left90,    position: SCBAlignmentPosition.Right)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createBarcodeData(_ emulation: StarIoExtEmulation) -> Data {
        let otherDataUpcE:    Data = "01234500006" .data(using: String.Encoding.ascii)!
        let otherDataUpcA:    Data = "01234567890" .data(using: String.Encoding.ascii)!
        let otherDataJan8:    Data = "0123456"     .data(using: String.Encoding.ascii)!
        let otherDataJan13:   Data = "012345678901".data(using: String.Encoding.ascii)!
        let otherDataCode39:  Data = "0123456789"  .data(using: String.Encoding.ascii)!
        let otherDataItf:     Data = "0123456789"  .data(using: String.Encoding.ascii)!
        let otherDataCode128: Data = "{B0123456789".data(using: String.Encoding.ascii)!
        let otherDataCode93:  Data = "0123456789"  .data(using: String.Encoding.ascii)!
        let otherDataNw7:     Data = "A0123456789B".data(using: String.Encoding.ascii)!
        
//      let bytesUpcE:    [UInt8] = [0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x30, 0x30, 0x30, 0x30, 0x36]
//      let bytesUpcA:    [UInt8] = [0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x30]
//      let bytesJan8:    [UInt8] = [0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36]
//      let bytesJan13:   [UInt8] = [0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x30, 0x31]
//      let bytesCode39:  [UInt8] = [0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39]
//      let bytesItf:     [UInt8] = [0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39]
//      let bytesCode128: [UInt8] = [0x7b, 0x42, 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39]
//      let bytesCode93:  [UInt8] = [0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39]
//      let bytesNw7:     [UInt8] = [0x41, 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x42]
//
//      let lengthUpcE:    UInt = UInt(bytesUpcE   .count)
//      let lengthUpcA:    UInt = UInt(bytesUpcA   .count)
//      let lengthJan8:    UInt = UInt(bytesJan8   .count)
//      let lengthJan13:   UInt = UInt(bytesJan13  .count)
//      let lengthCode39:  UInt = UInt(bytesCode39 .count)
//      let lengthItf:     UInt = UInt(bytesItf    .count)
//      let lengthCode128: UInt = UInt(bytesCode128.count)
//      let lengthCode93:  UInt = UInt(bytesCode93 .count)
//      let lengthNw7:     UInt = UInt(bytesNw7    .count)
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.append("*UPCE*\n".data(using: String.Encoding.ascii))
        builder.appendBarcodeData(otherDataUpcE,    symbology: SCBBarcodeSymbology.UPCE,    width: SCBBarcodeWidth.mode1, height: 40, hri: true)
        builder.appendUnitFeed(32)
        builder.append("\n*UPCA*\n".data(using: String.Encoding.ascii))
        builder.appendBarcodeData(otherDataUpcA,    symbology: SCBBarcodeSymbology.UPCA,    width: SCBBarcodeWidth.mode1, height: 40, hri: true)
        builder.appendUnitFeed(32)
        builder.append("\n*JAN8*\n".data(using: String.Encoding.ascii))
        builder.appendBarcodeData(otherDataJan8,    symbology: SCBBarcodeSymbology.JAN8,    width: SCBBarcodeWidth.mode1, height: 40, hri: true)
        builder.appendUnitFeed(32)
        builder.append("\n*JAN13*\n".data(using: String.Encoding.ascii))
        builder.appendBarcodeData(otherDataJan13,   symbology: SCBBarcodeSymbology.JAN13,   width: SCBBarcodeWidth.mode1, height: 40, hri: true)
        builder.appendUnitFeed(32)
        builder.append("\n*Code39*\n".data(using: String.Encoding.ascii))
        builder.appendBarcodeData(otherDataCode39,  symbology: SCBBarcodeSymbology.code39,  width: SCBBarcodeWidth.mode1, height: 40, hri: true)
        builder.appendUnitFeed(32)
        builder.append("\n*ITF*\n".data(using: String.Encoding.ascii))
        builder.appendBarcodeData(otherDataItf,     symbology: SCBBarcodeSymbology.ITF,     width: SCBBarcodeWidth.mode1, height: 40, hri: true)
        builder.appendUnitFeed(32)
        builder.append("\n*Code128*\n".data(using: String.Encoding.ascii))
        builder.appendBarcodeData(otherDataCode128, symbology: SCBBarcodeSymbology.code128, width: SCBBarcodeWidth.mode1, height: 40, hri: true)
        builder.appendUnitFeed(32)
        builder.append("\n*Code93*\n".data(using: String.Encoding.ascii))
        builder.appendBarcodeData(otherDataCode93,  symbology: SCBBarcodeSymbology.code93,  width: SCBBarcodeWidth.mode1, height: 40, hri: true)
        builder.appendUnitFeed(32)
        builder.append("\n*NW7*\n".data(using: String.Encoding.ascii))
        builder.appendBarcodeData(otherDataNw7,     symbology: SCBBarcodeSymbology.NW7,     width: SCBBarcodeWidth.mode1, height: 40, hri: true)
        builder.appendUnitFeed(32)
//      builder.appendData("*UPCE*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBarcodeBytes(bytesUpcE,    length: lengthUpcE,    symbology: SCBBarcodeSymbology.UPCE,    width: SCBBarcodeWidth.Mode1, height: 40, hri: true)
//      builder.appendUnitFeed(32)
//      builder.appendData("\n*UPCA*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBarcodeBytes(bytesUpcA,    length: lengthUpcA,    symbology: SCBBarcodeSymbology.UPCA,    width: SCBBarcodeWidth.Mode1, height: 40, hri: true)
//      builder.appendUnitFeed(32)
//      builder.appendData("\n*JAN8*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBarcodeBytes(bytesJan8,    length: lengthJan8,    symbology: SCBBarcodeSymbology.JAN8,    width: SCBBarcodeWidth.Mode1, height: 40, hri: true)
//      builder.appendUnitFeed(32)
//      builder.appendData("\n*JAN13*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBarcodeBytes(bytesJan13,   length: lengthJan13,   symbology: SCBBarcodeSymbology.JAN13,   width: SCBBarcodeWidth.Mode1, height: 40, hri: true)
//      builder.appendUnitFeed(32)
//      builder.appendData("\n*Code39*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBarcodeBytes(bytesCode39,  length: lengthCode39,  symbology: SCBBarcodeSymbology.Code39,  width: SCBBarcodeWidth.Mode1, height: 40, hri: true)
//      builder.appendUnitFeed(32)
//      builder.appendData("\n*ITF*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBarcodeBytes(bytesItf,     length: lengthItf,     symbology: SCBBarcodeSymbology.ITF,     width: SCBBarcodeWidth.Mode1, height: 40, hri: true)
//      builder.appendUnitFeed(32)
//      builder.appendData("\n*Code128*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBarcodeBytes(bytesCode128, length: lengthCode128, symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode1, height: 40, hri: true)
//      builder.appendUnitFeed(32)
//      builder.appendData("\n*Code93*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBarcodeBytes(bytesCode93,  length: lengthCode93,  symbology: SCBBarcodeSymbology.Code93,  width: SCBBarcodeWidth.Mode1, height: 40, hri: true)
//      builder.appendUnitFeed(32)
//      builder.appendData("\n*NW7*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBarcodeBytes(bytesNw7,     length: lengthNw7,     symbology: SCBBarcodeSymbology.NW7,     width: SCBBarcodeWidth.Mode1, height: 40, hri: true)
//      builder.appendUnitFeed(32)
        
        builder.append("*HRI:false*\n".data(using: String.Encoding.ascii))
        builder.appendBarcodeData(otherDataUpcE, symbology: SCBBarcodeSymbology.UPCE, width: SCBBarcodeWidth.mode1, height: 40, hri: false)
        builder.appendUnitFeed(32)
        builder.append("*Mode:1*\n".data(using: String.Encoding.ascii))
        builder.appendBarcodeData(otherDataUpcE, symbology: SCBBarcodeSymbology.UPCE, width: SCBBarcodeWidth.mode1, height: 40, hri: true)
        builder.appendUnitFeed(32)
        builder.append("*Mode:2*\n".data(using: String.Encoding.ascii))
        builder.appendBarcodeData(otherDataUpcE, symbology: SCBBarcodeSymbology.UPCE, width: SCBBarcodeWidth.mode2, height: 40, hri: true)
        builder.appendUnitFeed(32)
        builder.append("*Mode:3*\n".data(using: String.Encoding.ascii))
        builder.appendBarcodeData(otherDataUpcE, symbology: SCBBarcodeSymbology.UPCE, width: SCBBarcodeWidth.mode3, height: 40, hri: true)
        builder.appendUnitFeed(32)
//      builder.appendData("*HRI:false*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBarcodeBytes(bytesUpcE, length: lengthUpcE, symbology: SCBBarcodeSymbology.UPCE, width: SCBBarcodeWidth.Mode1, height: 40, hri: false)
//      builder.appendUnitFeed(32)
//      builder.appendData("*Mode:1*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBarcodeBytes(bytesUpcE, length: lengthUpcE, symbology: SCBBarcodeSymbology.UPCE, width: SCBBarcodeWidth.Mode1, height: 40, hri: true)
//      builder.appendUnitFeed(32)
//      builder.appendData("*Mode:2*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBarcodeBytes(bytesUpcE, length: lengthUpcE, symbology: SCBBarcodeSymbology.UPCE, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
//      builder.appendUnitFeed(32)
//      builder.appendData("*Mode:3*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBarcodeBytes(bytesUpcE, length: lengthUpcE, symbology: SCBBarcodeSymbology.UPCE, width: SCBBarcodeWidth.Mode3, height: 40, hri: true)
//      builder.appendUnitFeed(32)
        
        builder.append("\n*AbsolutePosition:40*\n".data(using: String.Encoding.ascii))
        builder.appendBarcodeData(withAbsolutePosition: otherDataUpcE, symbology: SCBBarcodeSymbology.UPCE, width: SCBBarcodeWidth.mode1, height: 40, hri: true, position: 40)
        builder.appendUnitFeed(32)
//      builder.appendData("\n*AbsolutePosition:40*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBarcodeBytesWithAbsolutePosition(bytesUpcE, length: lengthUpcE, symbology: SCBBarcodeSymbology.UPCE, width: SCBBarcodeWidth.Mode1, height: 40, hri: true, position: 40)
//      builder.appendUnitFeed(32)
        
        builder.append("\n*Alignment:Center*\n".data(using: String.Encoding.ascii))
        builder.appendBarcodeData(withAlignment: otherDataUpcE, symbology: SCBBarcodeSymbology.UPCE, width: SCBBarcodeWidth.mode1, height: 40, hri: true, position: SCBAlignmentPosition.center)
        builder.appendUnitFeed(32)
        builder.append("\n*Alignment:Right*\n" .data(using: String.Encoding.ascii))
        builder.appendBarcodeData(withAlignment: otherDataUpcE, symbology: SCBBarcodeSymbology.UPCE, width: SCBBarcodeWidth.mode1, height: 40, hri: true, position: SCBAlignmentPosition.right)
        builder.appendUnitFeed(32)
//      builder.appendData("\n*Alignment:Center*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBarcodeBytesWithAlignment(bytesUpcE, length: lengthUpcE, symbology: SCBBarcodeSymbology.UPCE, width: SCBBarcodeWidth.Mode1, height: 40, hri: true, position: SCBAlignmentPosition.Center)
//      builder.appendUnitFeed(32)
//      builder.appendData("\n*Alignment:Right*\n" .dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendBarcodeBytesWithAlignment(bytesUpcE, length: lengthUpcE, symbology: SCBBarcodeSymbology.UPCE, width: SCBBarcodeWidth.Mode1, height: 40, hri: true, position: SCBAlignmentPosition.Right)
//      builder.appendUnitFeed(32)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createPdf417Data(_ emulation: StarIoExtEmulation) -> Data {
        let otherData: Data = "Hello World.".data(using: String.Encoding.ascii)!
        
//      let bytes: [UInt8] = [0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e]
//
//      let length: UInt = UInt(bytes.count)
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.append("\n*Module:2*\n".data(using: String.Encoding.ascii))
        builder.appendPdf417Data(otherData, line: 0, column: 1, level: SCBPdf417Level.ECC0, module: 2, aspect: 2)
        builder.appendUnitFeed(32)
        builder.append("\n*Module:4*\n".data(using: String.Encoding.ascii))
        builder.appendPdf417Data(otherData, line: 0, column: 1, level: SCBPdf417Level.ECC0, module: 4, aspect: 2)
        builder.appendUnitFeed(32)
//      builder.appendData("\n*Module:2*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendPdf417Bytes(bytes, length: length, line :0, column: 1, level: SCBPdf417Level.ECC0, module: 2, aspect: 2)
//      builder.appendUnitFeed(32)
//      builder.appendData("\n*Module:4*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendPdf417Bytes(bytes, length: length, line: 0, column: 1, level: SCBPdf417Level.ECC0, module: 4, aspect: 2)
//      builder.appendUnitFeed(32)
        
        builder.append("\n*Column:2*\n".data(using: String.Encoding.ascii))
        builder.appendPdf417Data(otherData, line: 0, column: 2, level: SCBPdf417Level.ECC0, module: 2, aspect: 2)
        builder.appendUnitFeed(32)
        builder.append("\n*Column:4*\n".data(using: String.Encoding.ascii))
        builder.appendPdf417Data(otherData, line: 0, column: 4, level: SCBPdf417Level.ECC0, module: 2, aspect: 2)
        builder.appendUnitFeed(32)
//      builder.appendData("\n*Column:2*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendPdf417Bytes(bytes, length: length, line: 0, column: 2, level: SCBPdf417Level.ECC0, module: 2, aspect: 2)
//      builder.appendUnitFeed(32)
//      builder.appendData("\n*Column:4*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendPdf417Bytes(bytes, length: length, line: 0, column: 4, level: SCBPdf417Level.ECC0, module: 2, aspect: 2)
//      builder.appendUnitFeed(32)
        
        builder.append("\n*Line:10*\n".data(using: String.Encoding.ascii))
        builder.appendPdf417Data(otherData, line: 10, column: 0, level: SCBPdf417Level.ECC0, module: 2, aspect: 2)
        builder.appendUnitFeed(32)
        builder.append("\n*Line:40*\n".data(using: String.Encoding.ascii))
        builder.appendPdf417Data(otherData, line: 40, column: 0, level: SCBPdf417Level.ECC0, module: 2, aspect: 2)
        builder.appendUnitFeed(32)
//      builder.appendData("\n*Line:10*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendPdf417Bytes(bytes, length: length, line: 10, column: 0, level: SCBPdf417Level.ECC0, module: 2, aspect: 2)
//      builder.appendUnitFeed(32)
//      builder.appendData("\n*Line:40*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendPdf417Bytes(bytes, length: length, line: 40, column: 0, level: SCBPdf417Level.ECC0, module: 2, aspect: 2)
//      builder.appendUnitFeed(32)
        
        builder.append("\n*Level:ECC0*\n".data(using: String.Encoding.ascii))
        builder.appendPdf417Data(otherData, line: 0, column: 7, level: SCBPdf417Level.ECC0, module: 2, aspect: 2)
        builder.appendUnitFeed(32)
        builder.append("\n*Level:ECC8*\n".data(using: String.Encoding.ascii))
        builder.appendPdf417Data(otherData, line: 0, column: 7, level: SCBPdf417Level.ECC8, module: 2, aspect: 2)
        builder.appendUnitFeed(32)
//      builder.appendData("\n*Level:ECC0*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendPdf417Bytes(bytes, length: length, line: 0, column: 7, level: SCBPdf417Level.ECC0, module: 2, aspect: 2)
//      builder.appendUnitFeed(32)
//      builder.appendData("\n*Level:ECC8*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendPdf417Bytes(bytes, length: length, line: 0, column: 7, level: SCBPdf417Level.ECC8, module: 2, aspect: 2)
//      builder.appendUnitFeed(32)
        
        builder.append("\n*AbsolutePosition:40*\n".data(using: String.Encoding.ascii))
        builder.appendPdf417Data(withAbsolutePosition: otherData, line: 0, column: 1, level: SCBPdf417Level.ECC0, module: 2, aspect: 2, position: 40)
        builder.appendUnitFeed(32)
//      builder.appendData("\n*AbsolutePosition:40*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendPdf417BytesWithAbsolutePosition(bytes, length: length, line: 0, column: 1, level: SCBPdf417Level.ECC0, module: 2, aspect: 2, position: 40)
//      builder.appendUnitFeed(32)
        
        builder.append("\n*Alignment:Center*\n".data(using: String.Encoding.ascii))
        builder.appendPdf417Data(withAlignment: otherData, line: 0, column: 1, level: SCBPdf417Level.ECC0, module: 2, aspect: 2, position: SCBAlignmentPosition.center)
        builder.appendUnitFeed(32)
        builder.append("\n*Alignment:Right*\n" .data(using: String.Encoding.ascii))
        builder.appendPdf417Data(withAlignment: otherData, line: 0, column: 1, level: SCBPdf417Level.ECC0, module: 2, aspect: 2, position: SCBAlignmentPosition.right)
        builder.appendUnitFeed(32)
//      builder.appendData("\n*Alignment:Center*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendPdf417BytesWithAlignment(bytes, length: length, line: 0, column: 1, level: SCBPdf417Level.ECC0, module: 2, aspect: 2, position: SCBAlignmentPosition.Center)
//      builder.appendUnitFeed(32)
//      builder.appendData("\n*Alignment:Right*\n" .dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendPdf417BytesWithAlignment(bytes, length: length, line: 0, column: 1, level: SCBPdf417Level.ECC0, module: 2, aspect: 2, position: SCBAlignmentPosition.Right)
//      builder.appendUnitFeed(32)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
    
    static func createQrCodeData(_ emulation: StarIoExtEmulation) -> Data {
        let otherData: Data = "Hello World.".data(using: String.Encoding.ascii)!
        
//      let bytes: [UInt8] = [0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f, 0x72, 0x6c, 0x64, 0x2e]
//
//      let length: UInt = UInt(bytes.count)
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.append("*Cell:2*\n".data(using: String.Encoding.ascii))
        builder.appendQrCodeData(otherData, model: SCBQrCodeModel.no2, level: SCBQrCodeLevel.L, cell: 2)
        builder.appendUnitFeed(32)
        builder.append("*Cell:8*\n".data(using: String.Encoding.ascii))
        builder.appendQrCodeData(otherData, model: SCBQrCodeModel.no2, level: SCBQrCodeLevel.L, cell: 8)
        builder.appendUnitFeed(32)
//      builder.appendData("*Cell:2*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendQrCodeBytes(bytes, length: length, model: SCBQrCodeModel.No2, level: SCBQrCodeLevel.L, cell: 2)
//      builder.appendUnitFeed(32)
//      builder.appendData("*Cell:8*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendQrCodeBytes(bytes, length: length, model: SCBQrCodeModel.No2, level: SCBQrCodeLevel.L, cell: 8)
//      builder.appendUnitFeed(32)
        
        builder.append("*Level:L*\n".data(using: String.Encoding.ascii))
        builder.appendQrCodeData(otherData, model: SCBQrCodeModel.no2, level: SCBQrCodeLevel.L, cell: 4)
        builder.appendUnitFeed(32)
        builder.append("*Level:M*\n".data(using: String.Encoding.ascii))
        builder.appendQrCodeData(otherData, model: SCBQrCodeModel.no2, level: SCBQrCodeLevel.M, cell: 4)
        builder.appendUnitFeed(32)
        builder.append("*Level:Q*\n".data(using: String.Encoding.ascii))
        builder.appendQrCodeData(otherData, model: SCBQrCodeModel.no2, level: SCBQrCodeLevel.Q, cell: 4)
        builder.appendUnitFeed(32)
        builder.append("*Level:H*\n".data(using: String.Encoding.ascii))
        builder.appendQrCodeData(otherData, model: SCBQrCodeModel.no2, level: SCBQrCodeLevel.H, cell: 4)
        builder.appendUnitFeed(32)
//      builder.appendData("*Level:L*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendQrCodeBytes(bytes, length: length, model: SCBQrCodeModel.No2, level:SCBQrCodeLevel.L, cell: 4)
//      builder.appendUnitFeed(32)
//      builder.appendData("*Level:M*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendQrCodeBytes(bytes, length: length, model: SCBQrCodeModel.No2, level:SCBQrCodeLevel.M, cell: 4)
//      builder.appendUnitFeed(32)
//      builder.appendData("*Level:Q*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendQrCodeBytes(bytes, length: length, model: SCBQrCodeModel.No2, level:SCBQrCodeLevel.Q, cell: 4)
//      builder.appendUnitFeed(32)
//      builder.appendData("*Level:H*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendQrCodeBytes(bytes, length: length, model: SCBQrCodeModel.No2, level:SCBQrCodeLevel.H, cell: 4)
//      builder.appendUnitFeed(32)
        
        builder.append("\n*AbsolutePosition:40*\n".data(using: String.Encoding.ascii))
        builder.appendQrCodeData(withAbsolutePosition: otherData, model: SCBQrCodeModel.no2, level: SCBQrCodeLevel.L, cell: 4, position: 40)
        builder.appendUnitFeed(32)
//      builder.appendData("\n*AbsolutePosition:40*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendQrCodeBytesWithAbsolutePosition(bytes, length: length, model: SCBQrCodeModel.No2, level: SCBQrCodeLevel.L, cell: 4, position: 40)
//      builder.appendUnitFeed(32)
        
        builder.append("\n*Alignment:Center*\n".data(using: String.Encoding.ascii))
        builder.appendQrCodeData(withAlignment: otherData, model: SCBQrCodeModel.no2, level: SCBQrCodeLevel.L, cell: 4, position: SCBAlignmentPosition.center)
        builder.appendUnitFeed(32)
        builder.append("\n*Alignment:Right*\n" .data(using: String.Encoding.ascii))
        builder.appendQrCodeData(withAlignment: otherData, model: SCBQrCodeModel.no2, level: SCBQrCodeLevel.L, cell: 4, position: SCBAlignmentPosition.right)
        builder.appendUnitFeed(32)
//      builder.appendData("\n*Alignment:Center*\n".dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendQrCodeBytesWithAlignment(bytes, length: length, model: SCBQrCodeModel.No2, level: SCBQrCodeLevel.L, cell: 4, position: SCBAlignmentPosition.Center)
//      builder.appendUnitFeed(32)
//      builder.appendData("\n*Alignment:Right*\n" .dataUsingEncoding(NSASCIIStringEncoding))
//      builder.appendQrCodeBytesWithAlignment(bytes, length: length, model: SCBQrCodeModel.No2, level: SCBQrCodeLevel.L, cell: 4, position: SCBAlignmentPosition.Right)
//      builder.appendUnitFeed(32)
        
        builder.appendCutPaper(SCBCutPaperAction.partialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! Data
    }
}
