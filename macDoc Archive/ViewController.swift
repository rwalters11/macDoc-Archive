//
//  ViewController.swift
//  macDoc Archive
//
//  Created by Richard Walters on 29/12/2019.
//  Copyright © 2019 Richard Walters. All rights reserved.
//

import Cocoa
import Foundation
import PDFKit

class ViewController: NSViewController {

    @IBOutlet weak var pdfFileView: PDFView!
    @IBOutlet weak var pdfFileThumbnailView: PDFThumbnailView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let home = FileManager.default.homeDirectoryForCurrentUser
        let pdfFilePath = "Barnsbury Estate Greenspace Improvements.pdf"
        let pdfFileUrl = home.appendingPathComponent(pdfFilePath)

    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

