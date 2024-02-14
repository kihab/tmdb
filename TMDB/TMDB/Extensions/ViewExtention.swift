//
//  ViewExtention.swift
//  TMDB
//
//  Created by Karim Ihab on 14/02/2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    func redacted(when condition: Bool) -> some View {
        if !condition {
            unredacted()
        } else {
            redacted(reason: .placeholder)
        }
    }
}

