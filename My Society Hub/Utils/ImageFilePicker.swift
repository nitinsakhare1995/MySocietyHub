//
//  ImageFilePicker.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 27/05/21.
//

import Foundation
import UIKit
import PhotosUI
import MobileCoreServices
import AssetsLibrary

public let MimeType = ["pdf": "application/pdf",
                       "doc": "application/msword",
                       "jpeg": "image/jpeg",
                       "jpg": "image/jpeg",
                       "png": "image/png"]

enum FilePickerMode {
    case camera
    case gallery
    case document
}

struct ImageAttachment {
    let name: String
    let image: UIImage
    let fileExtension: String
}

struct DocumentAttachment {
    let name: String
    let document: Data
    let documentURL: URL
    let fileExtension: String
}

class FilePicker: UIViewController, UIImagePickerControllerDelegate, UIDocumentPickerDelegate, UINavigationControllerDelegate {
    
    var didSelectImageAttachment: ((ImageAttachment) -> ()) = { _ in }
    var didSelectDocumentAttachment: ((DocumentAttachment) -> ()) = { _ in }
    
    //  var didSelect: ((Country) -> ()) = { _ in }
    
    var selectionTypes = [FilePickerMode]()
    
    class func instantiate(with type: [FilePickerMode]) -> FilePicker {
        let vc = FilePicker()
        vc.selectionTypes = type
        return vc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        attachFiles()
    }
    
    func attachFiles() {
        let types = Array(Set(selectionTypes))
        let alertController = UIAlertController(title: "Choose File Source", message: "", preferredStyle: .actionSheet)
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        if types.contains(.gallery) {
            let library = UIAlertAction(title: "Photo Library", style: .default, handler: { (action) -> Void in
                self.uploadProfileImageFromLibrary()
            })
            alertController.addAction(library)
        }
        
        if types.contains(.camera) {
            let camera = UIAlertAction(title: "Camera", style: .default, handler: { (action) -> Void in
                self.uploadProfileImageFromCamera()
            })
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                alertController.addAction(camera)
            }
        }
        
        if types.contains(.document) {
            let fileBrowser = UIAlertAction(title: "Browse", style: .default, handler: { (action) -> Void in
                self.uploadDocumentFromBrowser()
            })
            alertController.addAction(fileBrowser)
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(cancelButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    public func uploadProfileImageFromLibrary() {
            PHPhotoLibrary.requestAuthorization({status in
                switch status{
                case .authorized: DispatchQueue.main.async { self.openGallery() }
                    print("Authorized")
                case .limited:
                    print("Limited")
                case .denied, .notDetermined, .restricted:
                    DispatchQueue.main.async {
                        openDeviceSettings(title: "Settings", message: "Allow \(appName) to access your gallery")
                    }
                    self.dismiss(animated: true, completion: nil)
                }
            })
    }
    
    func openGallery() {
        //Photos
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.modalPresentationStyle = .overFullScreen
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    public func uploadProfileImageFromCamera() {
        //Camera
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                //access granted
                DispatchQueue.main.async {
                    self.openCamera() }
            } else {
                DispatchQueue.main.async {
                    openDeviceSettings(title: "Settings", message: "Allow \(appName) to access your camera")
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.modalPresentationStyle = .overFullScreen
            picker.sourceType = .camera
            picker.cameraCaptureMode = .photo
            self.present(picker,animated: true,completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        guard let pickedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage,
            let imageExtension = (info[UIImagePickerController.InfoKey.imageURL] as? URL)?.pathExtension ?? "jpeg" as? String else {
                picker.dismiss(animated: true) {
                    self.dismiss(animated: true, completion: nil)
                }
                
                return
        }
        
        print(imageExtension)
        
        var fileName = "image001"
        
        if #available(iOS 11.0, *) {
            if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset {
                let assetResources = PHAssetResource.assetResources(for: asset)
                fileName = assetResources.first?.originalFilename ?? ""
            }
        }
        //let attachment = AttachmentElements(name: fileName, image: pickedImage)
        let attachment = ImageAttachment(name: fileName, image: pickedImage, fileExtension: imageExtension)
        didSelectImageAttachment(attachment)
        picker.dismiss(animated: true) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func uploadDocumentFromBrowser(){
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeCompositeContent)], in: .import)
        documentPicker.delegate = self
        self.present(documentPicker, animated: true)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        print(url)
        guard let fileData = try? Data(contentsOf: url),
            let fileName = url.lastPathComponent as? String,
            let fileExtension = url.pathExtension as? String else {
                controller.dismiss(animated: true) {
                    self.dismiss(animated: true, completion: nil)
                }
                return
        }
        let attachment = DocumentAttachment(name: fileName, document: fileData, documentURL: url, fileExtension: fileExtension)
        didSelectDocumentAttachment(attachment)
        controller.dismiss(animated: true) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
