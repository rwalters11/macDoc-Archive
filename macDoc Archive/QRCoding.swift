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

    // Get the data from the string
    let data = string.data(using: String.Encoding.ascii)
    
    // Get a QR CIFilter
    guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil}
    
    // Input the data
    qrFilter.setValue(data, forKey: "inputMessage")
    
    // Get the output image
    guard let qrImage = qrFilter.outputImage else { return nil}
    
    // Scale the image
    let transform = CGAffineTransform(scaleX: 10, y: 10)
    let scaledQrImage = qrImage.transformed(by: transform)
    
    // Do some processing to get the UIImage
    let context = CIContext()
    guard let cgImage = context.createCGImage(scaledQrImage, from: scaledQrImage.extent) else { return nil}
    
    return UIImage(cgImage: cgImage, size: NSSizeFromString("10,10"))
    
}



