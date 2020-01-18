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
    
    // MARK: - Main Menu Actions
    @IBAction func menuGenerateCode(_ sender: NSMenuItem) {
        
        showMessagePopover(sender: self, message: "Testing")
    }
    
    // Variables and Constants
    var deviceBrowser:ICDeviceBrowser!
    var myScanner:ICScannerDevice?
    
    let appDelegate = NSApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //scannerView.delegate = self

        // Setup Device Browser
        deviceBrowser = ICDeviceBrowser()
        // Set Delegate
        deviceBrowser.delegate = self
        // Set options mask for device browser to search for
        deviceBrowser.browsedDeviceTypeMask = ICDeviceTypeMask(rawValue:
                ICDeviceTypeMask.scanner.rawValue |
                ICDeviceLocationTypeMask.local.rawValue |
                ICDeviceLocationTypeMask.shared.rawValue |
                ICDeviceLocationTypeMask.bonjour.rawValue |
                ICDeviceLocationTypeMask.remote.rawValue |
                ICDeviceLocationTypeMask.bluetooth.rawValue)!

        // Start the device browser
        deviceBrowser.start()
        // Console
        print("Device Browser running: " + deviceBrowser.isBrowsing.description)
        
    }
    
    override func viewWillDisappear() {
        
        // Close scanner session if one exists
        if let _ = myScanner {
            myScanner?.requestCloseSession()
        }
        
        deviceBrowser.stop()
    }
    
    // MARK: - Delegate Functions
    
    // Scanner device delegate functions
    func scannerDeviceDidBecomeAvailable(_ scanner: ICScannerDevice) {
        print("Previous scanner session for " + scanner.name! + "has ended.")
    }
    
    func scannerDevice(_ scanner: ICScannerDevice, didCompleteOverviewScanWithError error: Error?) {
        print("ScanViewController: Device" + scanner.name! + " completed Overview Scan")
    }
    
    func scannerDevice(_ scanner: ICScannerDevice, didCompleteScanWithError error: Error?) {
        print("ScanViewController: Device " + scanner.name! + " completed Detail Scan")
    }
    
    // Scanner Device View delegate functions
    func scannerDeviceView(_ scannerDeviceView: IKScannerDeviceView!, didScanTo url: URL!, fileData data: Data!, error: Error!) {
        print("ScanViewController: Scanned to: " + url.absoluteString + " - " + (myScanner?.name!)!)
    }
    
    func scannerDeviceView(_ scannerDeviceView: IKScannerDeviceView!, didEncounterError error: Error!) {
        print("ScanViewController: Error - " + error.debugDescription)
    }
    
    // Device browser delegate functions
    func deviceBrowser(_ browser: ICDeviceBrowser, didAdd device: ICDevice, moreComing: Bool) {
        
        print("ScanViewController: Device Added - " + device.name!)
        
        // Set device as ICScanner type and assign device delegate
        myScanner = device as? ICScannerDevice
        myScanner!.delegate = self
        
        // Assign added scanner to ScannerView and assign delegate
        scannerView.delegate = self
        scannerView.scannerDevice = myScanner
        
    }
    
    func deviceBrowser(_ browser: ICDeviceBrowser, didRemove device: ICDevice, moreGoing: Bool) {
        device.requestCloseSession()
    }
    
    // Device delegate functions
    func device(_ device: ICDevice, didCloseSessionWithError error: Error) {
        print("Device Closed session" + (error.localizedDescription) )
        print(error.localizedDescription)
    }
    
    func didRemove(_ device: ICDevice) {
        device.requestCloseSession()
        
    }
    
    func device(_ device: ICDevice, didOpenSessionWithError error: Error?) {
        print("Device Opened session: " + (error?.localizedDescription ?? "") )
    }
    
    func deviceDidBecomeReady(_ device: ICDevice) {
        
        print("Device reports ready")
        //print(device)
        
    }
    
    func device(_ device: ICDevice, didReceiveStatusInformation status: [ICDeviceStatus : Any]) {
        print(status)
    }
    
}
