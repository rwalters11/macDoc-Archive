//
//  MainViewController.swift
//  macDoc Archive
//
//  Created by Richard Walters on 29/12/2019.
//  Copyright © 2019 Richard Walters. All rights reserved.
//

import Cocoa
import Foundation
import Quartz

//  PDFDocument delegate required for watermarking
class MainViewController: NSViewController, PDFDocumentDelegate {

    // Storyboard Connections
    @IBOutlet weak var pdfFileView: PDFView!
    @IBOutlet weak var pdfFileThumbnailView: PDFThumbnailView!
    
    // MARK: - Main Menu Actions
       @IBAction func menuFileOpen(_ sender: NSMenuItem) {
        
            // Console output
            print("ViewController:actionMenuItemSelected")
           
            // Open select file panel
            openFile()
       }
    
    // Variables and Constants
    let pdfThumbnailDimension = 120
    
    var deviceBrowser:ICDeviceBrowser!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let home = FileManager.default.homeDirectoryForCurrentUser
        let pdfFile = "begsi.pdf"
        let pdfFileURL:URL = home.appendingPathComponent(pdfFile)
        
        // Debug console
        print(pdfFileURL.absoluteString)
        
        // Setup the main PDF file view
        setupPDFView()
        // Setup the PDF thumbnail view
        setupThumbnailView()
        
        // Load the initial PDFfile
        loadPDF(pdfFileURL: pdfFileURL)
        

    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func setupPDFView() {
        pdfFileView.autoScales = true
    }

    func setupThumbnailView() {
        pdfFileThumbnailView.pdfView = pdfFileView
        pdfFileThumbnailView.thumbnailSize = CGSize(width: pdfThumbnailDimension, height: pdfThumbnailDimension)
        //pdfFileThumbnailView.backgroundColor = sidebarBackgroundColor
    }

    func loadPDF(pdfFileURL: URL) {
        // Create a `PDFDocument` object and set it as `PDFView`'s document to load the document in that view.
        let document = PDFDocument(url: pdfFileURL)
        
        // Set delegate for PDFDocument
        document?.delegate = self
        
        pdfFileView.document = document
    }
    
    // Watermarking sublass of PDFPage to use for PDF document
    func classForPage() -> AnyClass {
        return WatermarkPDFPage.self
    }

}

