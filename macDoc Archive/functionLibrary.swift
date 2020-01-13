//
//  functionLibrary.swift
//  macOS Function Library
//
//  Created by Richard Walters on 31/12/2019.
//  Copyright © 2019 Richard Walters. All rights reserved.
//

import Cocoa
import Foundation

func showMessagePopover(sender: AnyObject, message: String) {
    let controller = NSViewController()
    controller.view = NSView(frame: CGRect(x: CGFloat(100), y: CGFloat(50), width: CGFloat(100), height: CGFloat(50)))

    let popover = NSPopover()
    popover.contentViewController = controller
    popover.contentSize = controller.view.frame.size

    popover.behavior = .transient
    popover.animates = true

    // let txt = NSTextField(frame: NSMakeRect(100,50,50,22))
    let txt = NSTextField(frame: NSMakeRect(10,10,50,22))
    //let txt = NSTextField(frame: controller.view.frame)
    txt.stringValue = message
    txt.textColor = NSColor.white.withAlphaComponent(0.95)
    controller.view.addSubview(txt)
    txt.sizeToFit()
    popover.show(relativeTo: sender.bounds, of: sender as! NSView, preferredEdge: NSRectEdge.maxY)
}

func showInFinder(url: URL?){
    
    guard let url = url else { return }
    NSWorkspace.shared.activateFileViewerSelecting([url])
}

// Function to show a Folder in a Finder View
func showFolderInFinder(folderName : String = "")
{
    
    let home = FileManager.default.homeDirectoryForCurrentUser
    let dataPath = home.appendingPathComponent("Documents/" + folderName)
    NSWorkspace.shared.activateFileViewerSelecting([dataPath])
    
}

// Function to open a Modal File Selection Panel
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
            //let path = result!.path
            //filename_field.stringValue = path
        }
    } else {
        // User clicked on "Cancel"
        return
    }
    
}
