//
//  WifiData.swift
//  Wifi-Detect-RSSI-Mac
//
//  Created by 黃弘諺 on 2023/12/8.
//

struct WifiData {
    let name: String
    let rssi: Int
    let type: WifiType
}

enum WifiType {
    case G2_4, G5
}
