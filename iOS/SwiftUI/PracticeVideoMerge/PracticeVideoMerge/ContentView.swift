//
//  ContentView.swift
//  PracticeVideoMerge
//
//  Created by 석민솔 on 7/15/25.
//

import Foundation
import SwiftUI
import AVFoundation

// MARK: - 메인 뷰
struct ContentView: View {
    @StateObject private var cameraManager = CameraManager()
    @StateObject private var videoMerger = VideoMerger()
    @State private var showingVideoRecorder = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // 제목
                Text("영상 촬영 및 합치기")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                // 촬영된 영상 개수 표시
                Text("촬영된 영상: \(cameraManager.recordedVideos.count)개")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                // 촬영된 영상 목록
                if !cameraManager.recordedVideos.isEmpty {
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(Array(cameraManager.recordedVideos.enumerated()), id: \.offset) { index, videoURL in
                                VideoThumbnailView(videoURL: videoURL, index: index + 1)
                            }
                        }
                    }
                    .frame(maxHeight: 200)
                }
                
                Spacer()
                
                // 버튼들
                VStack(spacing: 15) {
                    // 영상 촬영 버튼
                    Button(action: {
                        showingVideoRecorder = true
                    }) {
                        HStack {
                            Image(systemName: "video.fill")
                            Text("영상 촬영")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    
                    // 영상 합치기 버튼
                    Button(action: {
                        Task {
                            await mergeVideos()
                        }
                    }) {
                        HStack {
                            Image(systemName: "square.stack.3d.down.dottedline")
                            Text("영상 합치기")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(cameraManager.recordedVideos.count >= 2 ? Color.green : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .disabled(cameraManager.recordedVideos.count < 2)
                    
                    // 영상 초기화 버튼
                    Button(action: {
                        cameraManager.clearVideos()
                        videoMerger.cleanupTemporaryFiles()
                    }) {
                        HStack {
                            Image(systemName: "trash")
                            Text("모두 삭제")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .disabled(cameraManager.recordedVideos.isEmpty)
                }
                
                // 합쳐진 영상 프리뷰
                if let mergedVideoURL = videoMerger.finalVideoURL {
                    VStack {
                        Text("합쳐진 영상 프리뷰")
                            .font(.headline)
                            .padding(.top)
                        
                        VideoPlayerView(videoURL: mergedVideoURL)
                            .frame(height: 200)
                            .cornerRadius(10)
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showingVideoRecorder) {
            VideoRecorderView(cameraManager: cameraManager)
        }
        .alert("알림", isPresented: $showingAlert) {
            Button("확인", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
        .onAppear {
            cameraManager.requestPermission()
        }
    }
    
    // 영상 합치기 함수 - 새로운 async/await 방식 사용
    private func mergeVideos() async {
        guard cameraManager.recordedVideos.count >= 2 else {
            alertMessage = "최소 2개의 영상이 필요합니다."
            showingAlert = true
            return
        }
        
        print("영상 합치기 시작 - 영상 개수: \(cameraManager.recordedVideos.count)")
        
        videoMerger.mergeVideos(from: cameraManager.recordedVideos) { finalURL in
            if let mergedURL = finalURL {
                self.alertMessage = "영상 합치기가 완료되었습니다!"
                self.showingAlert = true
                print("합쳐진 영상 URL: \(mergedURL)")
            }
        }
    }
}
