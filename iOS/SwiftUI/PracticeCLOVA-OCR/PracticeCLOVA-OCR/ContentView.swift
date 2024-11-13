//
//  ContentView.swift
//  PracticeCLOVA-OCR
//
//  Created by 석민솔 on 8/23/24.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented = false

    var body: some View {
        VStack {
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            } else {
                Text("Select an image")
                    .foregroundColor(.gray)
            }

            Button(action: {
                isImagePickerPresented = true
            }) {
                Text("Choose Image")
            }
            .padding()

            if selectedImage != nil {
                Button(action: {
                    performOCR(image: selectedImage!)
                }) {
                    Text("Upload Image")
                }
                .padding()
            }
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $selectedImage)
        }
    }

    // 이미지를 Alamofire로 전송하여 OCR 수행
    func performOCR(image: UIImage) {
        // 네이버 클라우드 API 엔드포인트 URL
        let apiUrl = "https://06744arwr6.apigw.ntruss.com/custom/v1/33707/12bf38a54f5388c9aaeeed33bdfc9504a65dc7026c17c76de2e391901e7fd0a2/general"
        
        // 네이버 클라우드에서 발급받은 API Key와 Secret Key
        
        // 요청 헤더 설정
        let headers: HTTPHeaders = [
            "X-OCR-SECRET": secretKey,
            "Content-Type": "application/json"
        ]
        
        // UIImage를 JPEG Data로 변환
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Failed to convert image to data.")
            return
        }

        // 요청 바디 설정
        let parameters: [String: Any] = [
            "version": "V2",
            "requestId": UUID().uuidString,
            "timestamp": Int(Date().timeIntervalSince1970 * 1000),
            "images": [
                [
                    "format": "jpg",
                    "name": "sample",
                    "data": imageData.base64EncodedString()
                ]
            ]
        ]
        
        print("parameters: \(parameters)")

        // Alamofire를 사용한 API 호출
        AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print("OCR Result: \(value)")
                case .failure(let error):
                    print("OCR Request failed with error: \(error)")
                }
            }
    }
}

// UIImagePickerController를 SwiftUI에서 사용하기 위한 UIViewControllerRepresentable
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}
#Preview {
    ContentView()
}
