//
//  ViewController.swift
//  Wifi-Detect-RSSI-Mac
//
//  Created by 黃弘諺 on 2023/12/7.
//

import Cocoa

class ViewController: NSViewController {
    let titleLabel = WILabel(frame: NSRect.zero)
    let copyrightLabel = WILabel(frame: NSRect.zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutView()
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

// MARK: - Init function
private extension ViewController {
    func layoutView() {
        // add subview
        view.addSubview(titleLabel)
        view.addSubview(copyrightLabel)

        // translate false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        copyrightLabel.translatesAutoresizingMaskIntoConstraints = false

        // auto layout constrain
        NSLayoutConstraint.activate([
            .init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 8),
            .init(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 8)
        ])
        NSLayoutConstraint.activate([
            .init(item: copyrightLabel, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -8),
            .init(item: copyrightLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        ])

        // others
        titleLabel.stringValue = "Wifi-Detece-RSSI-MAC"
        titleLabel.font = NSFont.systemFont(ofSize: 20, weight: .bold)
        copyrightLabel.stringValue = "Copyright © 2023 HongYan-Huang. All rights reserved."
        copyrightLabel.font = NSFont.systemFont(ofSize: 12, weight: .semibold)
        copyrightLabel.textColor = NSColor.lightGray
        copyrightLabel.alignment = .center
    }
}
