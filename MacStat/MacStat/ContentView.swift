//
//  ContentView.swift
//  MacStat
//
//  Created by alex haidar on 8/9/24.
//

import SwiftUI
import AppKit


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}



struct EffectView: NSViewRepresentable  {
    
    var material: NSVisualEffectView.Material = .fullScreenUI        //blurry background to cover the whole UI
    var blendUI: NSVisualEffectView.BlendingMode = .behindWindow          // applying the blurry background to the UI window itself
    var allowsVibrancy: Bool = true
    
    func makeNSView(context: Context) -> NSVisualEffectView {
        let blurryEffectView = NSVisualEffectView()
        
        blurryEffectView.material = material
        blurryEffectView.blendingMode = blendUI
        
        return NSVisualEffectView()
    }
        
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {    // _ added, no argument label needed
        nsView.material = .contentBackground
        nsView.blendingMode = blendUI
    }
}

struct ContentView: View {
    
    @State private var fanOn = false          //dynamic boolean to change fan button color when fan is on
    @State private var fanRotation: Double = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("MacStat")
                .font(.system(size: 17.7, weight: .regular, design: .default))
            Divider()
                .frame(maxWidth: .infinity)
                .opacity(2.0)
            
            Spacer()
            
            HStack {
                Group {
                    Image(systemName: "thermometer.medium")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .opacity(0.8)
                }
                .frame(width: 60)

                Text("CPU Temperature :")
                    .font(.system(size: 15.17, weight: .regular, design: .default ))
                    .opacity(0.8)
            }
            
            Divider()
                .frame(maxWidth: .infinity)
                .opacity(2.0)
                .padding(.vertical, 4)
            
            HStack {
                Group {
                    Image(systemName: "cpu.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .opacity(0.8)
                }
                .frame(width: 60)

                
                Text("Memory Usage :")
                    .font(.system(size: 15.17, weight: .regular, design: .default))
                    .opacity(0.8)
            }
            
            Spacer()
            
            Divider()
                .frame(maxWidth: .infinity)
                .opacity(1.3)
            
            HStack {
                Spacer()
                Text("Fan spin")
                    .font(.system(size: 15.17, weight: .light, design: .default))
                    .opacity(0.8)
                
                Button(action: {
                    fanOn.toggle()
                    if fanOn {
                        withAnimation(.linear(duration: 0.3).repeatForever(autoreverses: false)) {
                            fanRotation = 90
                        }
                    } else {
                        withAnimation {
                            fanRotation = 0
                        }
                    }
                }) {
                    Image(systemName: fanOn ? "fanblades.fill" : "fanblades")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 26)
                        .foregroundStyle(fanOn ? Color.green: Color(hex: "D7D7D7").opacity(0.8))
                        .rotationEffect(Angle(degrees: fanRotation))
                }
                .buttonStyle(.plain)
            }
            .padding()
        }
        .foregroundColor(Color(hex: "D7D7D7"))
        .padding()
        .frame(width: 388, height: 430)
        .background(EffectView(material: NSVisualEffectView.Material.contentBackground, blendUI: NSVisualEffectView.BlendingMode.behindWindow))
        
        //add Mac device/chip type detection here later - under top Divider
    }
}

#Preview {
    ContentView()
}

