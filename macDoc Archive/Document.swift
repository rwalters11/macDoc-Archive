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
    
    // Constants & variables
    var title:String?
    var QRImage:NSImage?
    
    // Initialisers
    
    
    // Private Methods
    
    // Function to get a QR code when a document ref is assigned
    private func getQRCode() {
        self.QRImage = generateQRCode(from: self.title!)
    }
    
}
