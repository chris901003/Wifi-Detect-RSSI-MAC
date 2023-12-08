//
//  AppDelegate.swift
//  Wifi-Detect-RSSI-Mac
//
//  Created by 黃弘諺 on 2023/12/7.
//

import Cocoa
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {

    private var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 270),
            styleMask: [.miniaturizable, .closable, .resizable, .titled],
            backing: .buffered,
            defer: false
        )
        window.center()
        window.title = "Wifi-Detect-RSSI-MAC"
        window.contentViewController = ViewController()
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

