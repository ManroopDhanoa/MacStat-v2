//
//  displayChipType.swift
//  MacStat
//
//  Created by alex haidar on 8/15/24.
//

import Foundation


let ChipType = ProcessInfo.processInfo



class systemInfo {
    
    func displayModelAndChip() -> String {                              //display model and chip type for silicon macs on the top bar of the UI
        
        var byteSize: Int = 0
        
        sysctlbyname("hw.model", nil, &byteSize, nil, 0)
        var StoreResult = [CChar](repeating: 0, count: byteSize )
        sysctlbyname("hw.model", &StoreResult, &byteSize,nil, 0)
        
        let convertToString = String(cString: StoreResult)
        
        func siliconMacs() -> String {
            
            if convertToString == "Mac15,6" {
                return("Macbook Pro - Apple M3 Pro")
                
            } else if convertToString == "Mac15,9" {
                return("MacBook Pro - Apple M3 Max")
                
            } else if convertToString == "Mac14,2" {
                return("MacBook Air - Apple M2")
                
            } else if convertToString == "Mac15,3" {
                return("MacBook Pro - Apple M3")
                
            } else if convertToString == "Mac15,12" {
                return("MacBook Air - Apple M3")
                
            } else if convertToString == "Mac14,9" {
                return("MacBook Pro - Apple M2 Pro")
                
            } else if convertToString == "Mac14,5" {
                return("MacBook Pro - Apple M2 Max")
                
            } else if convertToString == "MacBookPro18,1" {
                return("MacBook Pro - Apple M1 Pro")
                
            } else if convertToString == "MacBookAir10,1" {
                return("MacBook Air - Apple M1")
                
            } else if convertToString == "MacBookPro17,1" {
                return("MacBook Pro(TouchBar) - Apple M1")
                
            } else if convertToString == "Mac14,7" {
                return("MacBook Pro(TouchBar) - Apple M2")
                
            } else if convertToString == "MacBookPro18,2" {
                return("MacBook Pro - Apple M1 Max")
                
            } else if convertToString == "Macmini9,1" {
                return("Mac Mini - Apple M1")
                
            } else if convertToString == "Mac14,3"{
                return("Mac Mini - Apple M2")
                
            } else if convertToString == "Mac14,12" {
                return("Mac Mini - Apple M2 Pro")
                
                
                //intel macs below here
                
            } else if convertToString == "MacBookPro14,2" {                //add more as we expand support later
               return("Intel mac ")
            } else if convertToString == "MacBookPro15,3" {
               return("Intel mac ")
            } else if convertToString == "MacBookPro15,4" {
               return("Intel mac ")
                
                
            } else {
                return("-- --")
            }
        }
       
        return (siliconMacs())
    }
}





//let memory = ChipType.physicalMemory       //work on this later
//print("GB:\(memory)")
