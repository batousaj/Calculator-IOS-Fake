//
//  Calculator.swift
//  Calculator
//
//  Created by Mac Mini 2021_1 on 06/04/2022.
//

import Foundation

class Calculation {
     
    private var lastNumber:Float32!
    
    func reset() {
        self.lastNumber = 0
    }
    
    func addition( numFrist:Float32 ) {
        self.lastNumber = numFrist + self.lastNumber
    }
    
    func subtraction( numFrist:Float32 ) {
        if self.lastNumber == 0 {
            self.lastNumber =  numFrist
        } else {
            self.lastNumber =  self.lastNumber - numFrist
        }
    }
    
    func multiplication( numFrist:Float32 ) {
        if self.lastNumber == 0 {
            self.lastNumber =  numFrist
        } else {
            self.lastNumber = numFrist*self.lastNumber
        }
    }

    func divide( numFrist:Float32 ) {
        if self.lastNumber == 0 {
            self.lastNumber =  numFrist
        } else {
            self.lastNumber = Float32(self.lastNumber/numFrist)
        }
    }
    
    func percent( numFrist:Float32 ) {
        self.lastNumber =  numFrist
        self.lastNumber = Float32(self.lastNumber/100)
    }
    
    func toggle( numFrist:Float32 ) {
        self.lastNumber =  numFrist
        self.lastNumber = 0 - self.lastNumber
    }
    
    func equal() -> Float32 {
        return self.lastNumber
    }
    
    func setRound(_ num:Float32) -> Float32 {
        let numberOfPlace:Float32 = 2.0
        let multiplier = powf(10.0, numberOfPlace)
        let rounded = round(num * multiplier) / multiplier
        return rounded
    }
}
