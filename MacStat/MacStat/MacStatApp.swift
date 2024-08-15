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
            
                .frame(width: 388, height: 430)
            
            
                .fixedSize()
                .onAppear {
                    
                    if let WindowSize = NSApplication.shared.windows.first {
                        WindowSize.title = "MacStat"
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
