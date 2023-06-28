//
//  CreateSpendingCategoryView.swift
//  Budget
//
//  Created by Ethan Pippin on 6/28/23.
//

import SwiftData
import SwiftUI

struct CreateSpendingCategoryView: View {
    
    @Environment(\.dismiss)
    private var dismiss
    @Environment(\.modelContext)
    private var modelContext
    
    @State
    private var title: String = ""
    
    private func createSpendingCategory() {
        withAnimation {
            let newSpendingCategory = MoneyCategory(title: title, type: .spending)
            modelContext.insert(newSpendingCategory)
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Title") {
                    TextField("Title", text: $title, prompt: Text("Wants, Needs"))
                }
                
                Section {
                    Button(action: {
                        createSpendingCategory()
                        dismiss()
                    }, label: {
                        Text("Create")
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                    })
                    .listRowBackground(Color.blue)
                }
            }
            .navigationTitle("Create")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    Text("")
        .sheet(isPresented: .constant(true), content: {
            CreateSpendingCategoryView()
        })
}
