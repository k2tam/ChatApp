//
//  ImagePicker.swift
//  Image Picker Demo
//
//  Created by k2 tam on 16/08/2022.
//

import Foundation
import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable{
    @Binding var selectedImage: UIImage?
    @Binding var isPickerShowing: Bool
    
    var source: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = source
        
        // Object that can receive UIImagePickerController events
        imagePicker.delegate = context.coordinator
        
        return imagePicker
        
    
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var parent: ImagePicker
    
    init(_ picker: ImagePicker){
        self.parent = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //Run code when the user has selected an image
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            //Able to get image
            
            DispatchQueue.main.async {
                self.parent.selectedImage = image
            }
        }
        //Dismiss the picker
        parent.isPickerShowing = false
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Run the code when the user has cancelled the picker UI
        
        parent.isPickerShowing = false

    }
}
