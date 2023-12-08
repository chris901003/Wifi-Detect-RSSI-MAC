//
//  WifiData.swift
//  Wifi-Detect-RSSI-Mac
//
//  Created by 黃弘諺 on 2023/12/8.
//

import CoreWLAN

struct WifiData {
    let name: String
    let rssi: Int
    let type: WifiType

    static func fromNetwork(network: CWNetwork) -> WifiData {
        let name = network.ssid ?? "未知"
        let rssi = network.rssiValue
        let channel = network.wlanChannel?.channelBand
        let type: WifiType = channel == .band2GHz ? .G2_4 : .G5
        return WifiData(name: name, rssi: rssi, type: type)
    }
}

enum WifiType {
    case G2_4, G5
}
