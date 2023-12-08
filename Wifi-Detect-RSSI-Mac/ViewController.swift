//
//  ViewController.swift
//  Wifi-Detect-RSSI-Mac
//
//  Created by 黃弘諺 on 2023/12/7.
//

import Cocoa
import CoreWLAN

class ViewController: NSViewController {
    let titleLabel = WILabel(frame: NSRect.zero)
    let label2_4 = WILabel(frame: NSRect.zero)
    let tableView2_4 = NSTableView()
    let label5 = WILabel(frame: NSRect.zero)
    let tableView5 = NSTableView()
    let copyrightLabel = WILabel(frame: NSRect.zero)
    let interface = CWWiFiClient.shared().interface()
    var wifiInfo: [WifiData] = [] {
        willSet {
            wifi2_4Info = newValue.filter { $0.type == .G2_4 }
            wifi5Info = newValue.filter { $0.type == .G5 }
        }
    }
    var wifi2_4Info: [WifiData] = []
    var wifi5Info: [WifiData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutView()
        setDelegate()
        tableViewColumn()
        scanWifi()
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
        view.addSubview(label2_4)
        view.addSubview(tableView2_4)
        view.addSubview(label5)
        view.addSubview(tableView5)
        view.addSubview(copyrightLabel)

        // translate false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        label2_4.translatesAutoresizingMaskIntoConstraints = false
        tableView2_4.translatesAutoresizingMaskIntoConstraints = false
        label5.translatesAutoresizingMaskIntoConstraints = false
        tableView5.translatesAutoresizingMaskIntoConstraints = false
        copyrightLabel.translatesAutoresizingMaskIntoConstraints = false

        // auto layout constrain
        NSLayoutConstraint.activate([
            .init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 8),
            .init(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 8)
        ])
        NSLayoutConstraint.activate([
            .init(item: label2_4, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 16),
            .init(item: label2_4, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 16)
        ])
        NSLayoutConstraint.activate([
            .init(item: tableView2_4, attribute: .top, relatedBy: .equal, toItem: label2_4, attribute: .bottom, multiplier: 1, constant: 8),
            .init(item: tableView2_4, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 8),
            .init(item: tableView2_4, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -8)
        ])
        NSLayoutConstraint.activate([
            .init(item: label5, attribute: .top, relatedBy: .equal, toItem: tableView2_4, attribute: .bottom, multiplier: 1, constant: 16),
            .init(item: label5, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 16)
        ])
        NSLayoutConstraint.activate([
            .init(item: tableView5, attribute: .top, relatedBy: .equal, toItem: label5, attribute: .bottom, multiplier: 1, constant: 8),
            .init(item: tableView5, attribute: .bottom, relatedBy: .equal, toItem: copyrightLabel, attribute: .top, multiplier: 1, constant: -16),
            .init(item: tableView5, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 8),
            .init(item: tableView5, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -8)
        ])
        NSLayoutConstraint.activate([
            .init(item: copyrightLabel, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -8),
            .init(item: copyrightLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        ])

        // others
        titleLabel.stringValue = "Wifi-Detece-RSSI-MAC"
        titleLabel.font = NSFont.systemFont(ofSize: 20, weight: .bold)
        label2_4.stringValue = "Wifi 2.4G"
        label2_4.font = NSFont.systemFont(ofSize: 16, weight: .semibold)
        tableView2_4.focusRingType = .none
        tableView2_4.tag = 0
        label5.stringValue = "Wifi 5G"
        label5.font = NSFont.systemFont(ofSize: 16, weight: .semibold)
        tableView5.focusRingType = .none
        tableView5.tag = 1
        copyrightLabel.stringValue = "Copyright © 2023 HongYan-Huang. All rights reserved."
        copyrightLabel.font = NSFont.systemFont(ofSize: 12, weight: .semibold)
        copyrightLabel.textColor = NSColor.lightGray
        copyrightLabel.alignment = .center
    }

    func setDelegate() {
        tableView2_4.delegate = self
        tableView2_4.dataSource = self
        tableView5.delegate = self
        tableView5.dataSource = self
    }

    func tableViewColumn() {
        let nameColumn = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "Wifi"))
        nameColumn.width = 200
        let rssiColumn = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "RSSI"))
        rssiColumn.width = 100
        tableView2_4.addTableColumn(nameColumn)
        tableView2_4.addTableColumn(rssiColumn)
        tableView5.addTableColumn(nameColumn)
        tableView5.addTableColumn(rssiColumn)
    }
}

// MARK: - Table view delegate
extension ViewController: NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        tableView.tag == 0 ? wifi2_4Info.count : wifi5Info.count
    }

    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        if tableColumn?.identifier.rawValue == "Wifi" {
            return tableView.tag == 0 ? wifi2_4Info[row].name : wifi5Info[row].name
        } else if tableColumn?.identifier.rawValue == "RSSI" {
            return "\(tableView.tag == 0 ? wifi2_4Info[row].rssi : wifi5Info[row].rssi) dBm"
        }
        return "N/A"
    }

    func selectionShouldChange(in tableView: NSTableView) -> Bool {
        false
    }
}

private extension ViewController {
    func scanWifi() {
        guard let network = try? interface?.scanForNetworks(withSSID: nil) else { return }
        wifiInfo = network.compactMap {
            WifiData.fromNetwork(network: $0)
        }
        wifiInfo = wifiInfo.sorted {
            $0.rssi > $1.rssi
        }
        tableView2_4.reloadData()
        tableView5.reloadData()
    }
}
