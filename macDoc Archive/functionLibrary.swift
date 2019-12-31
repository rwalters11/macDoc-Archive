//
//  functionLibrary.swift
//  macDoc Archive
//
//  Created by Richard Walters on 31/12/2019.
//  Copyright © 2019 Richard Walters. All rights reserved.
//

import Cocoa
import Foundation

func showInFinder(url: URL?){
    
    guard let url = url else { return }
    NSWorkspace.shared.activateFileViewerSelecting([url])
}

func showFolderInFinder(folderName : String = "")
{
    
    let home = FileManager.default.homeDirectoryForCurrentUser
    let dataPath = home.appendingPathComponent("Documents/" + folderName)
    NSWorkspace.shared.activateFileViewerSelecting([dataPath])
    
}

func openFile() {
    
    let dialog = NSOpenPanel();
    
    dialog.title                   = "Choose a .pdf file";
    dialog.showsResizeIndicator    = true;
    dialog.showsHiddenFiles        = false;
    dialog.canChooseDirectories    = true;
    //dialog.canCreateDirectories    = true;
    dialog.allowsMultipleSelection = false;
    dialog.allowedFileTypes        = ["pdf"];

    if (dialog.runModal() == NSApplication.ModalResponse.OK) {
        let result = dialog.url // Pathname of the file
        
        if (result != nil) {
            let path = result!.path
            //filename_field.stringValue = path
        }
    } else {
        // User clicked on "Cancel"
        return
    }
    
}
