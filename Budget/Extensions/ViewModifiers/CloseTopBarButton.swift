//
//  CloseTopBarButton.swift
//  Budget
//
//  Created by Ethan Pippin on 7/3/23.
//

import SwiftUI

struct CloseTopBarButton: ViewModifier {
    
    @Environment(\.dismiss)
    private var dismiss
    
    func body(content: Content) -> some View {
        content.toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
            }
        }
    }
}
