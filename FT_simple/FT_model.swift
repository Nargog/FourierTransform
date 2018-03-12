//
//  FT_model.swift
//  FT_simple
//
//  Created by Mats Hammarqvist on 2018-03-03.
//  Copyright © 2018 Mats Hammarqvist. All rights reserved.
//

import Foundation

struct timePoint {
    var realValue = 0.0
    var imaginaryValue = 0.0
    var timeStep:Double = 0.0  // (timestep ?)
    
    //TODO: if amplitude or phase shifts -> change real/imag/freq
    var amplitude: Double = 0.0
}


struct cycle {
    var realValue = 0.0
    var imaginaryValue = 0.0
    var frequencyStep:Double = 0.0  // (frequencystep ?)
    
    //TODO: if amplitude or phase shifts -> change real/imag/freq
    var amplitude: Double{
        get{  return sqrt(realValue*realValue + imaginaryValue*imaginaryValue)}
        set{
            realValue = newValue * cos(phase*Double.pi/180)
            imaginaryValue = newValue * sin(phase*Double.pi/180)
        }
    }
    var phase: Double {
        get{ return atan2(imaginaryValue, realValue) * 180 / Double.pi}
        set{ realValue = amplitude * cos(newValue*Double.pi/180)
            imaginaryValue = amplitude * sin(newValue*Double.pi/180)}//In degrees !!
    }
    
    init(){
        self.realValue = 0
        self.imaginaryValue = 0
        self.frequencyStep = 0
        self.amplitude = 0
        self.phase = 0
    }
    
    init(amplitude:Double, phase:Double) {
        self.init()
        self.realValue = amplitude * cos(phase*Double.pi/180)
        self.imaginaryValue = amplitude * sin(phase*Double.pi/180)
        self.frequencyStep = 0
        self.amplitude = amplitude
        self.phase = phase
    }
}


class Fourier {
    
 
    
    var timeSignal = [timePoint]()
    
    func invTransform() {
            var tempTimeSignal = [timePoint]()
            
            let N_Samples: Int = transform.count
            
            var totalPart = timePoint()
            var pos: Double = 0
            
            for cycleNumber in 0..<N_Samples {
                pos = Double(cycleNumber)/Double(N_Samples)*2*Double.pi
                
                for frequence in transform {
                totalPart.realValue += frequence.amplitude * cos(pos * frequence.frequencyStep + frequence.phase * Double.pi/180)
                totalPart.imaginaryValue += frequence.amplitude * sin(pos * frequence.frequencyStep + frequence.phase * Double.pi/180)
                totalPart.timeStep = pos
                //real += cycle.amp * Math.cos(x * cycle.freq + cycle.phase * Math.PI/180)
                }
                //Close to zero -> you are zero
                if abs(totalPart.realValue) < 1e-10 {totalPart.realValue = 0}
                
                
                //total = totalValue(position: pos)
                //print(String(format: "%.2f", totalRealPart))
                tempTimeSignal.append(totalPart)
                
            }
            timeSignal = tempTimeSignal
        }
    
    
    
    var transform:[cycle]{
        get{
            let N_Samples = timeSignal.count
            
            // for every frequency...
            var tempCycles = [cycle]()
            
            for cycleNumber in 0..<N_Samples {
               // var realValue:Double = 0
                //var imaginaryValue: Double = 0
                
                var value = timePoint()
                
                // for every point in time...
                for timeStep in 0..<N_Samples {
                    // Spin the signal backwards_ at each frequency as radian/s,
                    let rate = -1 * (2*Double.pi) * Double(cycleNumber)
                    // How far around the circle have we gone at time= t?
                    let time = Double(timeStep)/Double(N_Samples)
                    let distance = rate * Double(time)
                    // datapoint * e^(-i*2*pi*f) is complex, store each part
                    let real_Part = timeSignal[timeStep].timeStep * cos(distance)
                    let imaginary_part = timeSignal[timeStep].timeStep * sin(distance)
                    // add this datapoints contribution
                    value.realValue += real_Part
                    value.imaginaryValue += imaginary_part
                    
                } //Stop for every timestep
                
                //Close to zero -> you are zero
                if abs(value.realValue) < 1e-10 {value.realValue = 0}
                if abs(value.imaginaryValue) < 1e-10 {value.imaginaryValue = 0}
                
                
                //Average contribution at this frequency
                value.realValue /= Double(N_Samples)
                value.imaginaryValue /= Double(N_Samples)
                
                tempCycles.append(cycle()) //lägg till en tom frekvenspunkt att fylla i
                tempCycles[cycleNumber].realValue = value.realValue
                tempCycles[cycleNumber].imaginaryValue = value.imaginaryValue
                tempCycles[cycleNumber].frequencyStep = Double(cycleNumber)
            } // Stop for every frequency
            return tempCycles
        }
       
        set{
            var tempTimeSignal = [timePoint]()
            
            let N_Samples: Int = newValue.count
            
           // var totalReal: Double = 0
            //var totalImaginary: Double = 0
            
            var totalSumValue = timePoint()
            
            //var total = timePoint()
            
            var pos: Double = 0
            
            for cycleNumber in 0..<N_Samples {
                
                
                pos = Double(cycleNumber)/Double(N_Samples)*2*Double.pi
                
                for frequence in newValue {
                    totalSumValue.realValue += frequence.amplitude * cos(pos * frequence.frequencyStep + frequence.phase * Double.pi/180) //Just calculates the real part
                    //real += cycle.amp * Math.cos(x * cycle.freq + cycle.phase * Math.PI/180)
                    totalSumValue.imaginaryValue += frequence.amplitude * sin(pos * frequence.frequencyStep + frequence.phase * Double.pi/180)
                }
                //Close to zero -> you are zero
                if abs(totalSumValue.realValue) < 1e-10 {totalSumValue.realValue = 0}
                if abs(totalSumValue.imaginaryValue) < 1e-10 {totalSumValue.imaginaryValue = 0}

                
                tempTimeSignal.append(totalSumValue)
                
            }
            timeSignal = tempTimeSignal
        }
        
    }
}
    
   




