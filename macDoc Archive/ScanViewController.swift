//
//  ScanViewController.swift
//  macDoc Archive
//
//  Created by Richard Walters on 31/12/2019.
//  Copyright © 2019 Richard Walters. All rights reserved.
//

import Cocoa
import Quartz
import AppKit

class ScanViewController: NSViewController, IKScannerDeviceViewDelegate, ICScannerDeviceDelegate, ICDeviceBrowserDelegate {
    
    // Storyboard Connections
    @IBOutlet weak var scannerView: IKScannerDeviceView!
    
    // Variables and Constants
    var deviceBrowser:ICDeviceBrowser!
    var myScanner:ICScannerDevice!
    
    let appDelegate = NSApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scannerView.delegate = self

        // Setup Device Browser
        deviceBrowser = ICDeviceBrowser()
        deviceBrowser.delegate = self
        deviceBrowser.browsedDeviceTypeMask = ICDeviceTypeMask(rawValue:
                ICDeviceTypeMask.scanner.rawValue |
                ICDeviceLocationTypeMask.local.rawValue |
                ICDeviceLocationTypeMask.shared.rawValue |
                ICDeviceLocationTypeMask.bonjour.rawValue |
                ICDeviceLocationTypeMask.remote.rawValue |
                ICDeviceLocationTypeMask.bluetooth.rawValue)!

        deviceBrowser.start()
        print(deviceBrowser.isBrowsing)
        
    }
    
    // MARK: - Delegate Functions
    
    func scannerDeviceDidBecomeAvailable(_ scanner: ICScannerDevice) {
        print("scannerDevice ready")
    }
    
    func scannerDevice(_ scanner: ICScannerDevice, didCompleteOverviewScanWithError error: Error?) {
        print("ScanViewController: Device Completed Overview Scan - " + scanner.name!)
    }
    
    func scannerDevice(_ scanner: ICScannerDevice, didCompleteScanWithError error: Error?) {
        print("ScanViewController: Device Completed Scan - " + scanner.name!)
    }
    
    func scannerDeviceView(_ scannerDeviceView: IKScannerDeviceView!, didScanTo url: URL!, fileData data: Data!, error: Error!) {
        print("ScanViewController: Scanned to: " + url.absoluteString + " - " + myScanner.name!)
    }
    
    func scannerDeviceView(_ scannerDeviceView: IKScannerDeviceView!, didEncounterError error: Error!) {
        print("ScanViewController: Error - " + error.debugDescription)
    }
    
    func deviceBrowser(_ browser: ICDeviceBrowser, didAdd device: ICDevice, moreComing: Bool) {
        
        print("ScanViewController: Device Added - " + device.name!)
        print(device)
        
        scannerView.scannerDevice = device as? ICScannerDevice
        myScanner = scannerView.scannerDevice
        myScanner.delegate = self
        
    }
    
    func deviceBrowser(_ browser: ICDeviceBrowser, didRemove device: ICDevice, moreGoing: Bool) {
        device.requestCloseSession()
    }
    
    func device(_ device: ICDevice, didCloseSessionWithError error: Error) {
        print("Device Close session error")
        print(error.localizedDescription)
    }
    
    func didRemove(_ device: ICDevice) {
        device.requestCloseSession()
        
    }
    
    func device(_ device: ICDevice, didOpenSessionWithError error: Error?) {
        print("Device Open session: " + (error?.localizedDescription ?? "") )
    }
    
    func deviceDidBecomeReady(_ device: ICDevice) {
        print("Device ready")

    }
    
}
