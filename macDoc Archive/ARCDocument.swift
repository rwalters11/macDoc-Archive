//
//  Document.swift
//  macDoc Archive
//
//  Created by Richard Walters on 16/01/2020.
//  Copyright © 2020 Richard Walters. All rights reserved.
//
//  Archive Document Model

import Foundation
import Quartz

class ARCDocument {
    
    // Enums
    // Status
    enum DocumentStatus {
        
        case new
        case scanned
        case saved
        case archived
    }
    
    // Constants & variables
    var title:      String?
    var QRImage:    NSImage?
    var reference:  String = ""
    var status:     DocumentStatus = .new
    var waterMark:  String = ""
    var url:        URL?
    
    // Initialisers
    
    
    // Private Methods
    
    // Function to get a QR code when a document ref is assigned
    private func getQRCode() {
        self.QRImage = generateQRCode(from: self.title!)
    }
    
}
