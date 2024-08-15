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
    
    
var body: some View {
    
        ZStack{
           
            
            EffectView(material: NSVisualEffectView.Material.fullScreenUI, blendUI: NSVisualEffectView.BlendingMode.behindWindow,allowsVibrancy: true)
                .frame(width: 380, height: 430)
             
               
            
            VStack(alignment: .leading, spacing: 50) {
                Text("MacStat")
                    .offset(x:-135, y: -184)
                    .font(.system(size: 17.7, weight: .semibold, design: .default))
                    .foregroundColor(Color(hex: "D7D7D7").opacity(0.8))
                   
            }
            
            Divider()
                .offset(x:1, y: -160)
             .frame(width: 340)
             .foregroundColor(Color(hex: "D7D7D7").opacity(2.0))
            
            //add Mac device/chip type detection here later - under top Divider
            
            VStack {
               Image(systemName: "thermometer.medium")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16.06, height: 29.29)
                    .offset(x:-147, y: -15)
                    .foregroundColor(Color(hex: "D7D7D7").opacity(0.8))
                
                HStack {
                    Text("CPU Temperature :")
                        .offset(x:-45, y: -45)
                        .font(.system(size: 15.17, weight: .regular, design: .default ))
                        .foregroundColor(Color(hex: "D7D7D7").opacity(0.8))
                }
    
            }
              
               Divider()
            
                .frame(width: 340)
                .foregroundColor(Color(hex: "D7D7D7").opacity(2.0))
                
            VStack {
                    Image(systemName: "cpu.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 29.07, height: 28.93)
                    .offset(x: -148,y: 40)
                    .foregroundColor(Color(hex: "D7D7D7").opacity(0.8))
                
                HStack {
                    Text("Memory Usage :")
                        .offset(x: -53, y: 11)
                        .font(.system(size: 15.17, weight: .regular, design: .default ))
                        .foregroundColor(Color(hex: "D7D7D7").opacity(0.8))
                }
            }
           
            Divider()
             .offset(x:1,y: 150)
             .frame(width: 340)
             .foregroundColor(Color(hex: "D7D7D7").opacity(1.3))
          
            VStack {
              
                Button(action: {
                    
                    fanOn.toggle()
                    
                    
                }) {
                
                if fanOn {
                    
                    Image(systemName: "fanblades.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 26)
                    .offset(x: 4, y: -2)  //fanblade image
                    .foregroundStyle(fanOn ? Color.green: Color(hex: "D7D7D7").opacity(0.8))
              
                        
                       
                        
                    
                } else {
                    Image(systemName: "fanblades")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 26)
                        .offset(x: 4, y: -2)  //fanblade image
                        .foregroundStyle(fanOn ? Color.green: Color(hex: "D7D7D7").opacity(0.8))
                  }
                }
                .offset(x:151, y: 198)  //button container
                .buttonStyle(PlainButtonStyle())
                
               
                HStack {
                    Text("Fan spin")
                        .offset(x: 97,y: 167)
                        .font(.system(size: 15.17, weight: .light, design: .default ))
                        .foregroundColor(Color(hex: "D7D7D7").opacity(0.8))
                }
            }
        }
        .background(Color(hex: "373737").opacity(1.0))
    }
       
}

    
    #Preview {
        ContentView()
    }

