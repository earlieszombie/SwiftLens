//
//  SwiftUIView.swift
//  SwiftLens
//
//  Created by Karin Prater on 29/04/2025.
//

import SwiftUI

extension View {
    /// Reports the view to SwiftLens observers (DEBUG builds only: the
    /// captured info can hold field values) and sets its accessibility identifier.
    public func lensTracked(id: String,
                            info: [String: AnyHashable] = [:]) -> some View {
        #if DEBUG
        self.preference(key: LensCaptureKey.self,
                        value: [LensCapture(viewType: String(describing: Self.self),
                                             identifier: id,
                                             info: info)])
        .accessibilityIdentifier(id)
        #else
        self.accessibilityIdentifier(id)
        #endif
    }
    
    /// Groups the tracked children for SwiftLens observers (DEBUG builds only)
    /// and makes the group an accessibility container with an identifier.
    public func lensGroup(id: String,
                          info: [String: AnyHashable] = [:]) -> some View  {
        #if DEBUG
        self.transformPreference(LensCaptureKey.self) { metadata in
            metadata = [
                LensCapture(viewType: String(describing: Self.self),
                             identifier: id,
                             info: info,
                             children: metadata)
            ]
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier(id)
        #else
        self.accessibilityElement(children: .contain)
            .accessibilityIdentifier(id)
        #endif
    }
}
