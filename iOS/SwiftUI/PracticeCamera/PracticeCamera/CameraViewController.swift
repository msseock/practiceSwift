//
//  CameraViewController.swift
//  PracticeCamera
//
//  Created by 석민솔 on 7/1/25.
//


import UIKit
import AVFoundation

// MARK: - CameraViewController (UIKit 기반)

class CameraViewController: UIViewController {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCameraSession()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 기기 회전 시 미리보기 레이어 프레임 업데이트
        previewLayer?.frame = view.bounds
    }

    func setupCameraSession() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .hd4K3840x2160 // 미리보기 화질

        // 비디오 입력 설정
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("비디오 장치를 찾을 수 없습니다.")
            return
        }
        guard let videoInput = try? AVCaptureDeviceInput(device: videoDevice) else {
            print("비디오 입력 설정 실패")
            return
        }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        }

        // 미리보기 레이어 설정
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        // 세션 시작 (백그라운드 스레드에서)
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
    }

    // 카메라 권한 요청 (앱 시작 시 또는 필요 시점에)
    func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if granted {
                print("카메라 권한 허용됨")
            } else {
                print("카메라 권한 거부됨")
                // 사용자에게 설정에서 권한을 부여하도록 안내
            }
        }
    }

    // 앱 비활성화 시 세션 중지, 활성화 시 다시 시작
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if captureSession.isRunning {
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession.stopRunning()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !captureSession.isRunning {
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession.startRunning()
            }
        }
    }
}
