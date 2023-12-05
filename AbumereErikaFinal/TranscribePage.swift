//
//  TranscribePage.swift
//  AbumereErikaFinal
//
//  Created by Student on 12/4/23.
//
//

import Foundation
import SwiftUI
import PhotosUI

struct TranscribePage: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: TranscribePage

        init(parent: TranscribePage) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.presentationMode.wrappedValue.dismiss()

            guard let selectedImage = results.first?.itemProvider.loadObject(ofClass: UIImage.self) as? UIImage else {
                return
            }

            parent.selectedImage = selectedImage
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selection = .limit(1)

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator

        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
}


struct FlashcardPage_Previews: PreviewProvider {
    static var previews: some View {
        TranscribePage()
    }
}
