//
//  QRCoding.swift
//  macDoc Archive
//
//  Created by Richard Walters on 13/01/2020.
//  Copyright © 2020 Richard Walters. All rights reserved.
//
//  QR Code Library

import Foundation
import Cocoa
import AVFoundation
import AppKit

// Typealias & extension to port IOS code to macOS
// Step 1: Typealias UIImage to NSImage
typealias UIImage = NSImage

// Step 2: You might want to add these APIs that UIImage has but NSImage doesn't.
extension NSImage {
    var cgImage: CGImage? {
        var proposedRect = CGRect(origin: .zero, size: size)

        return cgImage(forProposedRect: &proposedRect,
                       context: nil,
                       hints: nil)
    }

}

// Function to create a QR code from a given string
func generateQRCode(from string: String) -> UIImage? {
    let data = string.data(using: String.Encoding.ascii)

    if let filter = CIFilter(name: "CIQRCodeGenerator") {
        
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 3, y: 3)

        if let output = filter.outputImage?.transformed(by: transform) {
            //return UIImage(ciImage: output)
            return UIImage(cgImage: output as! CGImage, size: NSSizeFromString("10,10"))
        }
    }

    return nil
}

let image = generateQRCode(from: "Hacking with Swift is the best iOS coding tutorial I've ever read!")


