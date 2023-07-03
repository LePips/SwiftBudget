//
//  SplitText.swift
//  Budget
//
//  Created by Ethan Pippin on 6/28/23.
//

import SwiftUI

// TODO: Rename to HSpacerView
struct SplitText: View {
    
    let leading: () -> any View
    let trailing: () -> any View
    
    var body: some View {
        HStack {
            AnyView(leading())
            
            Spacer()
            
            AnyView(trailing())
        }
    }
}
