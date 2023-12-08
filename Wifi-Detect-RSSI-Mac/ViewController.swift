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
    let tableView = NSTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutView()
        setDelegate()
        tableViewColumn()
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
        view.addSubview(tableView)

        // translate false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        // auto layout constrain
        NSLayoutConstraint.activate([
            .init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 8),
            .init(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 8)
        ])
        NSLayoutConstraint.activate([
            .init(item: copyrightLabel, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -8),
            .init(item: copyrightLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        ])
        NSLayoutConstraint.activate([
            .init(item: tableView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 16),
            .init(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: copyrightLabel, attribute: .top, multiplier: 1, constant: -16),
            .init(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 8),
            .init(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -8)
        ])

        // others
        titleLabel.stringValue = "Wifi-Detece-RSSI-MAC"
        titleLabel.font = NSFont.systemFont(ofSize: 20, weight: .bold)
        copyrightLabel.stringValue = "Copyright © 2023 HongYan-Huang. All rights reserved."
        copyrightLabel.font = NSFont.systemFont(ofSize: 12, weight: .semibold)
        copyrightLabel.textColor = NSColor.lightGray
        copyrightLabel.alignment = .center
        tableView.focusRingType = .none
    }

    func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableViewColumn() {
        let nameColumn = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "Wifi"))
        nameColumn.headerCell.title = "Wifi"
        nameColumn.headerCell.stringValue = "Wifi2"
        nameColumn.headerCell.textColor = NSColor.black
        nameColumn.headerCell.isHighlighted = true
        nameColumn.width = 100
        let rssiColumn = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "RSSI"))
        rssiColumn.headerCell.title = "RSSI"
        rssiColumn.width = 200
        tableView.addTableColumn(nameColumn)
        tableView.addTableColumn(rssiColumn)
    }
}

// MARK: - Table view delegate
extension ViewController: NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 10
    }

    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return "aaaa"
    }

    func selectionShouldChange(in tableView: NSTableView) -> Bool {
        false
    }
}
