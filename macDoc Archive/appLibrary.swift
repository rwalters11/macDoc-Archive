//
//  appLibrary.swift
//  macDoc Archive Libray
//
//  Created by Richard Walters on 12/01/2020.
//  Copyright © 2020 Richard Walters. All rights reserved.
//

import Foundation
import Cocoa

// MARK: - Document class
// Class definition for a document
class Document {
    
    // Variables & constants
    var name:       String?
    
    var scan:       Scan?
}

// MARK: - Scan class
// Class definition for a scan
class Scan {
    
    // Enums
    // Types of scan returned from scanner
    enum scanType {
        case overview
        case detail
    }
    
    // Variables & constants
    var filename:   String?
    var fURL:       URL?
    
    var type:       scanType = .overview
    
}
