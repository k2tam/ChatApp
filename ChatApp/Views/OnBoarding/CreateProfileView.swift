//
//  CreateProfileView.swift
//  ChatApp
//
//  Created by k2 tam on 12/08/2022.
//

import SwiftUI

struct CreateProfileView: View {
    
    @Binding var currentStep: OnboardingStep
    @State var firstName:String = ""
    @State var lastName:String = ""
    
    @State var selectedImage: UIImage?
    @State var isPickerShowing = false
    
    @State var isSourceMenuShowing = false
    @State var source: UIImagePickerController.SourceType = .photoLibrary
    
    @State var isSaveButtonDisabled = false
    
    var body: some View {
        VStack{
            Text("Setup Your Profile")
                .font(Font.titleText)
                .padding(.top, 52)
            
            Text("Just a few more details to get started")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            Spacer()
            
            //Image profile button

            Button {
                //Show actions sheet
                isSourceMenuShowing = true
            } label: {
                
                ZStack{
                    
                    if selectedImage != nil{
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                    }else{
                        Circle()
                            .foregroundColor(.white)
                        
                        Image(systemName: "camera.fill")
                            .foregroundColor(Color("icons-input"))
                    }
                    
                    Circle()
                        .stroke(Color("create-profile-border"), lineWidth: 2)
                    
                    
                    
                }
                .frame(width: 134, height: 134)

            }
            
            Spacer()
            
            //First name
            TextField("Given Name", text: $firstName)
                .textFieldStyle(ProfileTextFieldStyle())
            
            //Last name
            TextField("Last Name", text: $lastName)
                .textFieldStyle(ProfileTextFieldStyle())
            
            Spacer()
            
            Button {
                //TODO: Check that firstname/lastname fields are filled before allowing save
                //Prevent double tabs
                isSaveButtonDisabled = true
                //Save profile data
                DatabaseService().setUserProfile(firstName: firstName,
                                                 lastName: lastName,
                                                 image: selectedImage) { isSuccess in
                    
                    if isSuccess{
                        currentStep = .contacts
                    }else{
                        //TODO: Show error message to the user
                    }
                    
                    isSaveButtonDisabled = false

                }
            } label: {
                Text(isSaveButtonDisabled ? "Uploading..." : "Save")
            }
            .buttonStyle(OnboardingButtonStyle())
            .disabled(isSaveButtonDisabled)
            .padding(.bottom, 87)

        }
        .padding(.horizontal)
        .confirmationDialog("From where ?", isPresented: $isSourceMenuShowing, actions: {
            
            Button {
                //Set source to photo library
                self.source = .photoLibrary
                
                //Show image picker
                isPickerShowing = true
            } label: {
                Text("Photo Library")
            }
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                Button {
                    //Set source to photo library
                    self.source = .camera
                    
                    //Show image picker
                    isPickerShowing = true
                } label: {
                    Text("Take camera")
                }
            }
            
            
            

        })
        .sheet(isPresented: $isPickerShowing) {
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing, source: source)
        }
    }
}

struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView(currentStep: Binding.constant(.contacts)
        )
    }
}
