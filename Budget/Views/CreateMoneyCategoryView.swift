//
//  CreateMoneyCategoryView.swift
//  Budget
//
//  Created by Ethan Pippin on 6/28/23.
//

import SwiftData
import SwiftUI

struct CreateMoneyCategoryView: View {
    
    @Environment(\.dismiss)
    private var dismiss
    @Environment(\.modelContext)
    private var modelContext
    
    @State
    private var color: Color = .blue
    @State
    private var title: String = ""
    
    private func createSpendingCategory() {
        withAnimation {
            let newSpendingCategory = MoneyCategory(title: title, color: color)
            modelContext.insert(newSpendingCategory)
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Title") {
                    TextField("Title", text: $title, prompt: Text("Wants, Needs"))
                    
                    ColorPicker("Color", selection: $color, supportsOpacity: false)
                }
                
                Section {
                    Button {
                        createSpendingCategory()
                        dismiss()
                    } label: {
                        Text("Create")
                            .foregroundStyle(title.isEmpty ? Color.black : .white)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                    }
                    .disabled(title.isEmpty)
                    .listRowBackground(title.isEmpty ? Color.secondary : .blue)
                }
            }
            .closeTopBarButton()
            .navigationTitle("Create")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    Text("")
        .sheet(isPresented: .constant(true), content: {
            CreateMoneyCategoryView()
        })
}
