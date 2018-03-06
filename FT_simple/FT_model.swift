//
//  FT_model.swift
//  FT_simple
//
//  Created by Mats Hammarqvist on 2018-03-03.
//  Copyright © 2018 Mats Hammarqvist. All rights reserved.
//

import Foundation

struct cycle {
    var realValue = 0.0
    var imaginaryValue = 0.0
    var frequency:Double = 0.0  // (frequencystep ?)
    
    //TODO: if amplitude or phase shifts -> change real/imag/freq
    var amplitude: Double{
        get{  return sqrt(realValue*realValue + imaginaryValue*imaginaryValue)}
        set{}
    }
    var phase: Double {
        get{ return atan2(imaginaryValue, realValue) * 180 / Double.pi}
        set{ }//In degrees !!
    }
    
    init(){
        self.realValue = 0
        self.imaginaryValue = 0
        self.frequency = 0
        self.amplitude = 0
        self.phase = 0
    }
    
    init(amplitude:Double, phase:Double) {
        self.init()
        self.realValue = 0 //TODO calculate
        self.imaginaryValue = 0 //TODO calculate
        self.frequency = 0
        self.amplitude = amplitude
        self.phase = phase
    }
}


class Fourier {
    
 
    
    var timeSignal = [Double]()
    
    func invTransform() {
            var tempTimeSignal = [Double]()
            
            let N_Samples: Int = transform.count
            
            var totalRealPart: Double = 0
            var pos: Double = 0
            
            for cycleNumber in 0..<N_Samples {
                pos = Double(cycleNumber)/Double(N_Samples)*2*Double.pi
                
                for frequence in transform {
                totalRealPart += frequence.amplitude * cos(pos * frequence.frequency + frequence.phase * Double.pi/180)
                //real += cycle.amp * Math.cos(x * cycle.freq + cycle.phase * Math.PI/180)
                }
                //Close to zero -> you are zero
                if abs(totalRealPart) < 1e-10 {totalRealPart = 0}
                
                
                //total = totalValue(position: pos)
                print(totalRealPart)
                tempTimeSignal.append(totalRealPart)
                totalRealPart = 0
            }
            timeSignal = tempTimeSignal
        }
    
    
    
    var transform:[cycle]{
        get{
            let N_Samples = timeSignal.count
            
            // for every frequency...
            var tempCycles = [cycle]()
            
            for cycleNumber in 0..<N_Samples {
                var realValue:Double = 0
                var imaginaryValue: Double = 0
                
                // for every point in time...
                for timeStep in 0..<N_Samples {
                    // Spin the signal backwards_ at each frequency as radian/s,
                    let rate = -1 * (2*Double.pi) * Double(cycleNumber)
                    // How far around the circle have we gone at time= t?
                    let time = Double(timeStep)/Double(N_Samples)
                    let distance = rate * Double(time)
                    // datapoint * e^(-i*2*pi*f) is complex, store each part
                    let real_Part = timeSignal[timeStep] * cos(distance)
                    let imaginary_part = timeSignal[timeStep] * sin(distance)
                    // add this datapoints contribution
                    realValue += real_Part
                    imaginaryValue += imaginary_part
                    
                } //Stop for every timestep
                
                //Close to zero -> you are zero
                if abs(realValue) < 1e-10 {realValue = 0}
                if abs(imaginaryValue) < 1e-10 {imaginaryValue = 0}
                
                
                //Average contribution at this frequency
                realValue /= Double(N_Samples)
                imaginaryValue /= Double(N_Samples)
                
                tempCycles.append(cycle()) //lägg till en tom frekvenspunkt att fylla i
                tempCycles[cycleNumber].realValue = realValue
                tempCycles[cycleNumber].imaginaryValue = imaginaryValue
                tempCycles[cycleNumber].frequency = Double(cycleNumber)
            } // Stop for every frequency
            return tempCycles
        }
       
        set{
            var tempTimeSignal = [Double]()
            
            let N_Samples: Int = newValue.count
            
            var totalReal: Double = 0
            var totalImaginary: Double = 0
            
            var pos: Double = 0
            
            for cycleNumber in 0..<N_Samples {
                pos = Double(cycleNumber)/Double(N_Samples)*2*Double.pi
                
                for frequence in newValue {
                    totalReal += frequence.amplitude * cos(pos * frequence.frequency + frequence.phase * Double.pi/180) //Just calculates the real part
                    //real += cycle.amp * Math.cos(x * cycle.freq + cycle.phase * Math.PI/180)
                    totalImaginary += frequence.amplitude * sin(pos * frequence.frequency + frequence.phase * Double.pi/180) //Just calculates the real part
                }
                //Close to zero -> you are zero
                if abs(totalReal) < 1e-10 {totalReal = 0}
                if abs(totalImaginary) < 1e-10 {totalImaginary = 0}
                
                
                //total = totalValue(position: pos)
                print(totalReal)
                tempTimeSignal.append(totalReal)
                totalReal = 0
            }
            timeSignal = tempTimeSignal
        }
        
    }
}
    
   




