//
//  WatermarkPDFPage.swift
//  macDoc Archive
//
//  Created by Richard Walters on 15/01/2020.
//  Copyright © 2020 Richard Walters. All rights reserved.
//
//  Custom class to implement watermarking a PDF page

import Cocoa
import PDFKit

// Typealiases to port IOS code to macOS
typealias UIColor = NSColor
typealias UIFont = NSFont

class WatermarkPDFPage: PDFPage {
    
    override func draw(with box: PDFDisplayBox, to context: CGContext) {
        super.draw(with: box, to: context)

        let string: NSString = "FREE SAMPLE"
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.red, .font: UIFont.boldSystemFont(ofSize: 32)]
        let stringSize = string.size(withAttributes: attributes)

        UIGraphicsPushContext(context)
        context.saveGState()

        let pageBounds = bounds(for: box)
        context.translateBy(x: (pageBounds.size.width - stringSize.width) / 2, y: pageBounds.size.height)
        context.scaleBy(x: 1.0, y: -1.0)

        string.draw(at: CGPoint(x: 0, y: 55), withAttributes: attributes)

        context.restoreGState()
        UIGraphicsPopContext()
    }

}
