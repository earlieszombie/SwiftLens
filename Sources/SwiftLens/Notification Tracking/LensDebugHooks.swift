//
//  LensDebugHooks.swift
//  SwiftLens
//
//  The simulation hooks are test machinery: they let any in-process code tap
//  buttons and type into fields, and announce every interaction. They are
//  compiled into DEBUG builds only, so an app shipping SwiftLens modifiers
//  keeps its accessibility identifiers but none of the hooks.
//

import Foundation
import SwiftUI

extension View {
    /// Listens for a SwiftLens simulation notification (DEBUG builds only).
    func lensOnReceive(_ center: NotificationCenter,
                       _ name: Notification.Name,
                       perform action: @escaping (Notification) -> Void) -> some View {
        #if DEBUG
        onReceive(center.publisher(for: name), perform: action)
        #else
        self
        #endif
    }
}

extension NotificationCenter {
    /// Announces an interaction to SwiftLens observers (DEBUG builds only).
    func lensPost(name: Notification.Name, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
        #if DEBUG
        post(name: name, object: object, userInfo: userInfo)
        #endif
    }
}
