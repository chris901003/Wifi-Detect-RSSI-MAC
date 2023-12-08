//
//  ViewController.swift
//  Wifi-Detect-RSSI-Mac
//
//  Created by 黃弘諺 on 2023/12/7.
//

import Cocoa

class ViewController: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func loadView() {
       let rect = NSRect(x: 0, y: 0, width: 480, height: 240)
       view = NSView(frame: rect)
       view.wantsLayer = true
       view.layer?.backgroundColor = NSColor.white.cgColor
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

