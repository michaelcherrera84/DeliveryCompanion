//
//  AddEditService.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/7/25.
//

import PhotosUI
import SwiftData
import SwiftUI

struct AddEditService: View {
    @Environment(\.modelContext) var modelContext
    @Binding var navigationPath: NavigationPath
    @Bindable var service: Service
    @State private var showPhotoPicker = false
    @State private var selectedImage: PhotosPickerItem?

    var body: some View {

        VStack {

            if let logo = service.logo,
                let uiImage = UIImage(data: logo)
            {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .padding(.top, 50)
                    .onTapGesture {
                        showPhotoPicker = true
                    }
            }

            Form {
                Section {
                    TextField("Name", text: $service.name)
                        .textContentType(.name)

                    TextField(
                        "Phone (optional)",
                        text: Binding(
                            get: { service.phoneNumber ?? "" },
                            set: { service.phoneNumber = $0.isEmpty ? nil : $0 }
                        )
                    )
                    .textContentType(.telephoneNumber)
                    .keyboardType(.phonePad)

                    TextField(
                        "Email (optional)",
                        text: Binding(
                            get: { service.email ?? "" },
                            set: { service.email = $0.isEmpty ? nil : $0 }
                        )
                    )
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
                }
                .padding(10)

                Section {
                    if service.logo == nil {
                        HStack {
                            Label("Add Logo", systemImage: "plus")
                            Image(systemName: "building.2.crop.circle")
                        }
                        .foregroundColor(.blue)
                    }
                }
                .onTapGesture {
                    showPhotoPicker = true
                }
            }
            .photosPicker(
                isPresented: $showPhotoPicker,
                selection: $selectedImage,
                matching: .images
            )
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Edit Service")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selectedImage, loadImage)
    }

    func loadImage() {
        Task { @MainActor in
            service.logo = try await selectedImage?.loadTransferable(
                type: Data.self
            )
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return AddEditService(
            navigationPath: .constant(NavigationPath()),
            service: previewer.service
        )
            .modelContainer(previewer.modelContainer)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
