//
//  Burn2Disc.swift
//  macDoc Archive
//
//  Created by Richard Walters on 02/01/2020.
//  Copyright © 2020 Richard Walters. All rights reserved.
//
//  Extension to Main View Controller to add disc burning capability

import Cocoa
import DiscRecording
import DiscRecordingUI

extension MainViewController {
    
    // Storyboard Connections
    @IBAction func menuBurn2Disc(_ sender: NSMenuItem) {
        
        Burn2Disc()
    }

    // Function to handle disc burning
    func Burn2Disc() {
        
        print("MVC: Burn2Disc entered")
        
        let track4Data = setData4Disc()
        
        openDiscBurnSetup(track: track4Data)
        
    }
    
    // Function to assemble data to be written to disc
    func setData4Disc() -> DRTrack
    {
        var trackData: DRTrack
        
        // Gather file information for Archive to be burned
        let home = FileManager.default.homeDirectoryForCurrentUser
        let path2Archive = "begsi.pdf"
        let archiveURL:URL = home.appendingPathComponent(path2Archive)
        
        // Set the root folder for disc as the top level folder for the Archive
        let rFolder = DRFolder(path: archiveURL.absoluteString)
        // Create the disc track
        trackData = DRTrack(forRootFolder: rFolder)
        
        return trackData
    }
    
    // Function to open a disc burning dialog
    func openDiscBurnSetup(track: DRTrack) {
        
        let dialog = DRBurnSetupPanel()
        
        dialog.title                   = "Burn an Archive to Disc";
        dialog.showsResizeIndicator    = true;

        // Show the disc burning setup panel
        let retVal = dialog.run()

        // Test for user clicked cancel
        if (retVal == NSApplication.ModalResponse.cancel.rawValue)
        {
            return
        }
        
        // Get configuration data from setup panel
        let burnData = dialog.burnObject()
        // Instaniate Burn Progress Panel
        let burnPnlProgress = DRBurnProgressPanel()
        // Start the burn and display progress
        burnPnlProgress.begin(for: burnData, layout: track)
        
    }
    
}
