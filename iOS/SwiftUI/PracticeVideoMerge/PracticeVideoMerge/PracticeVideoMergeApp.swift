import SwiftUI
import AVFoundation
import Photos

// MARK: - 앱 시작점
@main
struct VideoRecorderApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// MARK: - 영상 촬영 뷰
struct VideoRecorderView: View {
    @ObservedObject var cameraManager: CameraManager
    @Environment(\.presentationMode) var presentationMode
    @State private var recordingTime: TimeInterval = 0
    @State private var timer: Timer?
    
    var body: some View {
        ZStack {
            // 카메라 프리뷰
            CameraPreview(session: cameraManager.getSession())
                .ignoresSafeArea()
            
            // 오버레이 UI
            VStack {
                // 상단 버튼
                HStack {
                    Button("취소") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.white)
                    .padding()
                    
                    Spacer()
                    
                    // 녹화 시간 표시
                    if cameraManager.isRecording {
                        Text(formatTime(recordingTime))
                            .foregroundColor(.red)
                            .font(.headline)
                            .padding()
                    }
                }
                
                Spacer()
                
                // 하단 녹화 버튼
                HStack {
                    Spacer()
                    
                    Button(action: {
                        if cameraManager.isRecording {
                            stopRecording()
                        } else {
                            startRecording()
                        }
                    }) {
                        Circle()
                            .fill(cameraManager.isRecording ? Color.red : Color.white)
                            .frame(width: 80, height: 80)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 4)
                            )
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 50)
            }
        }
    }
    
    private func startRecording() {
        cameraManager.startRecording()
        recordingTime = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            recordingTime += 1
        }
    }
    
    private func stopRecording() {
        cameraManager.stopRecording()
        timer?.invalidate()
        timer = nil
        recordingTime = 0
        
        // 녹화 완료 후 뷰 닫기
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

// MARK: - 카메라 프리뷰
struct CameraPreview: UIViewRepresentable {
    let session: AVCaptureSession?
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        guard let session = session else { return view }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.frame
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

// MARK: - 영상 플레이어 뷰
struct VideoPlayerView: UIViewRepresentable {
    let videoURL: URL
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        
        let asset = AVURLAsset(url: videoURL)
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)
        
        // 자동 재생 및 반복
        player.play()
        
        // 재생 완료 시 다시 시작
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
            player.seek(to: .zero)
            player.play()
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

// MARK: - 영상 썸네일 뷰
struct VideoThumbnailView: View {
    let videoURL: URL
    let index: Int
    @State private var thumbnail: UIImage?
    
    var body: some View {
        HStack {
            // 썸네일 이미지
            if let thumbnail = thumbnail {
                Image(uiImage: thumbnail)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipped()
                    .cornerRadius(8)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
            }
            
            // 영상 정보
            VStack(alignment: .leading) {
                Text("영상 \(index)")
                    .font(.headline)
                Text(videoURL.lastPathComponent)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .onAppear {
            generateThumbnail()
        }
    }
    
    private func generateThumbnail() {
        let asset = AVURLAsset(url: videoURL)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        
        let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 600)
        
        imageGenerator.generateCGImagesAsynchronously(forTimes: [NSValue(time: time)]) { _, image, _, _, _ in
            if let image = image {
                DispatchQueue.main.async {
                    self.thumbnail = UIImage(cgImage: image)
                }
            }
        }
    }
}

