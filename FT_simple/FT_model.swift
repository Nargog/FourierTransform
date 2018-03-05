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
    var amplitude: Double{
        get{  return sqrt(realValue*realValue + imaginaryValue*imaginaryValue)}
    }
    var phase: Double {
        get{ return atan2(imaginaryValue, realValue) * 180 / Double.pi} //In degrees !!
    }
}


class Fourier {
    
    var timeSignal = [Double]()
    
    var cycles:[cycle]{
        get{
            let N_Samples: Int = timeSignal.count
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
        
    }
   
    
    
    
    
    
 
    

}
    
   




