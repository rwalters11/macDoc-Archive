//
//  WatermarkPDFPage.swift
//  macDoc Archive
//
//  Created by Richard Walters on 15/01/2020.
//  Copyright © 2020 Richard Walters. All rights reserved.
//
//  Custom class to implement watermarking a PDF page

import Cocoa
import Quartz

// Typealiases to port IOS code to macOS
typealias UIColor = NSColor
typealias UIFont = NSFont

class WatermarkPDFPage: PDFPage {
    
    var arcDocument: ARCDocument?
    
    // Override the default drawing func with one to add the watermark in addition to the original content
    override func draw(with box: PDFDisplayBox, to context: CGContext) {
        
        // Draw the original content
        super.draw(with: box, to: context)

        // Configure watermark text
        let string: NSString = "FREE SAMPLE"
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.red, .font: UIFont.boldSystemFont(ofSize: 32)]
        let stringSize = string.size(withAttributes: attributes)

        // Save current graphics drawing state
        context.saveGState()

        // Get the page boundarys
        let pageBounds = bounds(for: box)
        
        // Position drawing frame to centre the text at the base of the page
        context.translateBy(x: (pageBounds.size.width - stringSize.width) / 2, y: 0)
        
        // Draw the string at bottom left corner of frame
        string.draw(at: CGPoint(x: 0, y: 0), withAttributes: attributes)

        // Return the graphics drawing state
        context.restoreGState()
    }

}
