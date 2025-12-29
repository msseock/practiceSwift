//
//  PatternHapticTestView.swift
//  HapticPlayer
//
//  Created by 석민솔 on 11/11/25.
//

import SwiftUI
import CoreHaptics

struct HapticEvent: Identifiable {
    let id = UUID()
    var intensity: Float
    var sharpness: Float
    var relativeTime: Double
    var duration: Double
}

struct PatternHapticTestView: View {
    @State private var events: [HapticEvent] = []
    @State private var showingAddSheet = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("햅틱 패턴 테스트")
                .font(.title)
                .fontWeight(.bold)
            
            List {
                ForEach(Array(events.enumerated()), id: \.element.id) { index, event in
                    VStack(alignment: .leading, spacing: 5) {
                        Text("이벤트 #\(index + 1)")
                            .font(.headline)
                        Text("Intensity: \(String(format: "%.2f", event.intensity)), Sharpness: \(String(format: "%.2f", event.sharpness))")
                        Text("Time: \(String(format: "%.2f", event.relativeTime))s, Duration: \(String(format: "%.2f", event.duration))s")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 4)
                }
                .onDelete(perform: deleteEvent)
            }
            .listStyle(.plain)
            
            HStack(spacing: 15) {
                // 이벤트 추가 버튼
                Button {
                    showingAddSheet = true
                } label: {
                    Label("추가", systemImage: "plus")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                // 패턴 재생 버튼
                Button {
                    let hapticEvents = events.map { event in
                        HapticManager.shared.makeHaptic(
                            intensity: event.intensity,
                            sharpness: event.sharpness,
                            relativeTime: event.relativeTime,
                            duration: event.duration
                        )
                    }
                    HapticManager.shared.playHapticPattern(hapticEvents: hapticEvents)
                } label: {
                    Label("재생", systemImage: "play.fill")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
        }
        .padding()
        .sheet(isPresented: $showingAddSheet) {
            AddHapticEventSheet(events: $events)
        }
    }
    
    private func deleteEvent(at offsets: IndexSet) {
        events.remove(atOffsets: offsets)
    }
}

// MARK: - Add Haptic Event Sheet
struct AddHapticEventSheet: View {
    @Binding var events: [HapticEvent]
    @Environment(\.dismiss) var dismiss
    
    @State private var intensity: Float = 0.7
    @State private var sharpness: Float = 0.5
    @State private var duration: Double = 0.5
    @State private var relativeTime: Double = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("새 햅틱 이벤트 추가")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top)
                
                // HapticVariablesSliders 재사용
                HapticVariablesSliders(
                    intensity: $intensity,
                    sharpness: $sharpness,
                    duration: $duration
                )
                
                // Relative Time 슬라이더 (패턴 전용)
                VStack(alignment: .leading, spacing: 5) {
                    Text("시작지연 시간: \(String(format: "%.2f", relativeTime))s")
                    Slider(value: $relativeTime, in: 0...5.0)
                }
                .padding(.horizontal)
                
                Divider()
                    .padding(.vertical)
                
                // 미리보기 버튼
                Button {
                    HapticManager.shared.playHaptic(
                        intensity: intensity,
                        sharpness: sharpness,
                        relativeTime: relativeTime,
                        duration: duration
                    )
                } label: {
                    Text("미리보기")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("취소") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("추가") {
                        let newEvent = HapticEvent(
                            intensity: intensity,
                            sharpness: sharpness,
                            relativeTime: relativeTime,
                            duration: duration
                        )
                        events.append(newEvent)
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
        .onAppear {
            // 마지막 이벤트 시간 기준으로 초기값 설정
            if let lastEvent = events.last {
                relativeTime = lastEvent.relativeTime + lastEvent.duration + 0.3
            }
        }
    }
}

#Preview {
    PatternHapticTestView()
}
