//
//  MacStatApp.swift
//  MacStat
//
//  Created by alex haidar on 8/9/24.
//

import SwiftUI


@main
struct MacStatApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            





                .frame(width: 380, height: 430)
                .fixedSize()
                
                .onAppear {
                    
                  
                    let chip = systemInfo()
                    print(chip)
                    
                    NSApp.appearance = NSAppearance(named: .vibrantDark)
                
                    if let WindowSize = NSApplication.shared.windows.first {
                       
                        WindowSize.minSize = NSSize(width: 388, height: 410)
                        WindowSize.maxSize = NSSize(width: 388, height: 410)
                        WindowSize.center()
                    }
                    
                }
             }
            
        .commands {
            CommandGroup(replacing: .windowSize) {}
            
        }
        
         
        
        
    }
    
}
