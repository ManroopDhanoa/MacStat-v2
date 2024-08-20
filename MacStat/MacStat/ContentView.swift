//
//  ContentView.swift
//  MacStat
//
//  Created by alex haidar on 8/9/24.
//

import SwiftUI
import AppKit



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
    
    @State private var fanRotation: Double = 0
    @State private var fanOn = false                    //dynamic boolean to change fan button color when fan is on
    
     let sysInfo = systemInfo()
    
    
    var body: some View {
    
     
        VStack(alignment: .leading) {
                   Text("MacStat")
                       .font(.system(size: 17.7, weight: .semibold, design: .default))
                       .foregroundColor(Color.primary.opacity(0.8))
                   Divider()
                       .frame(maxWidth: .infinity)
                       .opacity(2.0)
            
            Text(sysInfo.displayModelAndChip())
                .padding(.top, 3)
                .font(.system(size: 17.7, weight: .semibold, design: .default))
                .foregroundColor(Color.primary.opacity(0.8))
                  
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
                               .foregroundStyle(fanOn ? Color.green: Color.primary.opacity(0.8))
                               .rotationEffect(Angle(degrees: fanRotation))
                       }
                       .buttonStyle(.plain)
                   }
                   .padding()
               }
        .foregroundColor(Color.primary)
               .padding()
               .frame(width: 388, height: 430)
               .background(EffectView(material: NSVisualEffectView.Material.contentBackground, blendUI: NSVisualEffectView.BlendingMode.behindWindow))
               
               //add Mac device/chip type detection here later - under top Divider
           }
       }

#Preview {
    ContentView()
}
