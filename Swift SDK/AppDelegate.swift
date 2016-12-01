//
//  AppDelegate.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import UIKit

enum LanguageIndex: Int {
    case english = 0
    case japanese
    case french
    case portuguese
    case spanish
    case german
    case russian
    case simplifiedChinese
    case traditionalChinese
}

enum PaperSizeIndex: Int {
    case twoInch = 384
    case threeInch = 576
    case fourInch = 832
    case escPosThreeInch = 512
    case dotImpactThreeInch = 210
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    static func isSystemVersionEqualTo(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: NSString.CompareOptions.numeric) == ComparisonResult.orderedSame
    }
    
    static func isSystemVersionGreaterThan(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: NSString.CompareOptions.numeric) == ComparisonResult.orderedDescending
    }
    
    static func isSystemVersionGreaterThanOrEqualTo(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: NSString.CompareOptions.numeric) != ComparisonResult.orderedAscending
    }
    
    static func isSystemVersionLessThan(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: NSString.CompareOptions.numeric) == ComparisonResult.orderedAscending
    }
    
    static func isSystemVersionLessThanOrEqualTo(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: NSString.CompareOptions.numeric) != ComparisonResult.orderedDescending
    }
    
    static func isIPhone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    }
    
    static func isIPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }
    
    var window: UIWindow?
    
    var portName:     String!
    var portSettings: String!
    var modelName:    String!
    var macAddress:   String!
    
    var emulation:                StarIoExtEmulation!
    var cashDrawerOpenActiveHigh: Bool!
    var allReceiptsSettings:      Int!
    var selectedIndex:            Int!
    var selectedLanguage:         LanguageIndex!
    var selectedPaperSize:        PaperSizeIndex!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Thread.sleep(forTimeInterval: 1.0)     // 1000mS!!!
        
        self.loadParam()
        
        self.selectedIndex     = 0
        self.selectedLanguage  = LanguageIndex.english
        self.selectedPaperSize = PaperSizeIndex.twoInch
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    fileprivate func loadParam() {
        let userDefaults: UserDefaults = UserDefaults.standard
        
        userDefaults.register(defaults: ["portName"                 : ""])
        userDefaults.register(defaults: ["portSettings"             : ""])
        userDefaults.register(defaults: ["modelName"                : ""])
        userDefaults.register(defaults: ["macAddress"               : ""])
        userDefaults.register(defaults: ["emulation"                : StarIoExtEmulation.starPRNT.rawValue])
        userDefaults.register(defaults: ["cashDrawerOpenActiveHigh" : true])
        userDefaults.register(defaults: ["allReceiptsSettings"      : 0x00000007])
        
        self.portName                 =                              userDefaults.string (forKey: "portName")
        self.portSettings             =                              userDefaults.string (forKey: "portSettings")
        self.modelName                =                              userDefaults.string (forKey: "modelName")
        self.macAddress               =                              userDefaults.string (forKey: "macAddress")
        self.emulation                = StarIoExtEmulation(rawValue: userDefaults.integer(forKey: "emulation"))
        self.cashDrawerOpenActiveHigh =                              userDefaults.bool   (forKey: "cashDrawerOpenActiveHigh")
        self.allReceiptsSettings      =                              userDefaults.integer(forKey: "allReceiptsSettings")
    }
    
    static func getPortName() -> String {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return delegate.portName!
    }
    
    static func setPortName(_ portName: String) {
        let userDefaults: UserDefaults = UserDefaults.standard
        
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        delegate.portName = portName
        
        userDefaults.set(delegate.portName, forKey: "portName")
        
        userDefaults.synchronize()
    }
    
    static func getPortSettings() -> String {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return delegate.portSettings!
    }
    
    static func setPortSettings(_ portSettings: String) {
        let userDefaults: UserDefaults = UserDefaults.standard
        
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        delegate.portSettings = portSettings
        
        userDefaults.set(delegate.portSettings, forKey: "portSettings")
        
        userDefaults.synchronize()
    }
    
    static func getModelName() -> String {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return delegate.modelName!
    }
    
    static func setModelName(_ modelName: String) {
        let userDefaults: UserDefaults = UserDefaults.standard
        
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        delegate.modelName = modelName
        
        userDefaults.set(delegate.modelName, forKey:"modelName")
        
        userDefaults.synchronize()
    }
    
    static func getMacAddress() -> String {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return delegate.macAddress!
    }
    
    static func setMacAddress(_ macAddress: String) {
        let userDefaults: UserDefaults = UserDefaults.standard
        
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        delegate.macAddress = macAddress
        
        userDefaults.set(delegate.macAddress, forKey:"macAddress")
        
        userDefaults.synchronize()
    }
    
    static func getEmulation() -> StarIoExtEmulation {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return delegate.emulation!
    }
    
    static func setEmulation(_ emulation: StarIoExtEmulation) {
        let userDefaults: UserDefaults = UserDefaults.standard
        
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        delegate.emulation = emulation
        
        userDefaults.set(delegate.emulation.rawValue, forKey:"emulation")
        
        userDefaults.synchronize()
    }
    
    static func getCashDrawerOpenActiveHigh() -> Bool {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return delegate.cashDrawerOpenActiveHigh!
    }
    
    static func setCashDrawerOpenActiveHigh(_ activeHigh: Bool) {
        let userDefaults: UserDefaults = UserDefaults.standard
        
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        delegate.cashDrawerOpenActiveHigh = activeHigh
        
        userDefaults.set(delegate.cashDrawerOpenActiveHigh, forKey:"cashDrawerOpenActiveHigh")
        
        userDefaults.synchronize()
    }
    
    static func getAllReceiptsSettings() -> Int {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return delegate.allReceiptsSettings!
    }
    
    static func setAllReceiptsSettings(_ allReceiptsSettings: Int) {
        let userDefaults: UserDefaults = UserDefaults.standard
        
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        delegate.allReceiptsSettings = allReceiptsSettings
        
        userDefaults.set(delegate.allReceiptsSettings, forKey:"allReceiptsSettings")
        
        userDefaults.synchronize()
    }
    
    static func getSelectedIndex() -> Int {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return delegate.selectedIndex!
    }
    
    static func setSelectedIndex(_ index: Int) {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        delegate.selectedIndex = index
    }
    
    static func getSelectedLanguage() -> LanguageIndex {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return delegate.selectedLanguage!
    }
    
    static func setSelectedLanguage(_ index: LanguageIndex) {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        delegate.selectedLanguage = index
    }
    
    static func getSelectedPaperSize() -> PaperSizeIndex {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return delegate.selectedPaperSize!
    }
    
    static func setSelectedPaperSize(_ index: PaperSizeIndex) {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        delegate.selectedPaperSize = index
    }
}
