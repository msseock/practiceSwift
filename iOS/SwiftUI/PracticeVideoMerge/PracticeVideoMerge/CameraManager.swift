//
//  CameraManager.swift
//  PracticeVideoMerge
//
//  Created by 석민솔 on 7/15/25.
//

import Foundation
import AVFoundation

// MARK: - 카메라 매니저
class CameraManager: NSObject, ObservableObject {
    @Published var recordedVideos: [URL] = []
    @Published var isRecording = false
    @Published var hasPermission = false
    
    private var captureSession: AVCaptureSession?
    private var videoOutput: AVCaptureMovieFileOutput?
    private var currentVideoURL: URL?
    
    override init() {
        super.init()
        setupCamera()
    }
    
    // 카메라 권한 요청
    func requestPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            hasPermission = true
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    self.hasPermission = granted
                }
            }
        default:
            hasPermission = false
        }
    }
    
    // 카메라 설정
    private func setupCamera() {
        captureSession = AVCaptureSession()
        
        guard let captureSession = captureSession else { return }
        
        // 비디오 입력 설정
        guard let videoDevice = AVCaptureDevice.default(for: .video),
              let videoInput = try? AVCaptureDeviceInput(device: videoDevice) else { return }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        }
        
        // 비디오 출력 설정
        videoOutput = AVCaptureMovieFileOutput()
        if let videoOutput = videoOutput,
           captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        }
        
        captureSession.startRunning()
    }
    
    // 녹화 시작
    func startRecording() {
        guard let videoOutput = videoOutput else { return }
        
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        // Date()를 timeIntervalSince1970으로 변경하여 고유하고 안전한 파일 이름 생성
        let videoURL = documentsPath.appendingPathComponent("video_\(Date().timeIntervalSince1970).mp4")
        
        currentVideoURL = videoURL
        videoOutput.startRecording(to: videoURL, recordingDelegate: self)
        isRecording = true
    }
    
    // 녹화 중지
    func stopRecording() {
        videoOutput?.stopRecording()
        isRecording = false
    }
    
    // 녹화된 영상 목록 초기화
    func clearVideos() {
        // 파일 시스템에서 삭제
        for url in recordedVideos {
            try? FileManager.default.removeItem(at: url)
        }
        recordedVideos.removeAll()
    }
    
    // 세션 가져오기
    func getSession() -> AVCaptureSession? {
        return captureSession
    }
}

// MARK: - AVCaptureFileOutputRecordingDelegate
extension CameraManager: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if let error = error {
            print("Recording error: \(error.localizedDescription)")
            return
        }
        
        // 녹화 완료 후 배열에 추가
        DispatchQueue.main.async {
            self.recordedVideos.append(outputFileURL)
        }
    }
}
