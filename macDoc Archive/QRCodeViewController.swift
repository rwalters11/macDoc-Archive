//
//  QRCodeViewController.swift
//  macDoc Archive
//
//  Created by Richard Walters on 14/01/2020.
//  Copyright © 2020 Richard Walters. All rights reserved.
//

import Cocoa

class QRCodeViewController: NSViewController {

    // Storyboard connections
    @IBOutlet weak var imgViewQRCode: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let qrImage = generateQRCode(from: "Document Archive ID: 000123")
        
        imgViewQRCode.image = qrImage
    }
    
}
