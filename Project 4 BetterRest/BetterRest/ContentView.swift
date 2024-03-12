//
//  ContentView.swift
//  BetterRest
//
//  Created by Nidhi Pabbathi on 3/12/24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    static var defaultWakeTime : Date {
        var dateComponents = DateComponents()
        dateComponents.hour = 7
        dateComponents.minute = 0
        
        return Calendar.current.date(from: dateComponents) ?? Date.now
    }
    
    var estimatedTime : Date {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            
            //hour and minute in seconds
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Int64(hour + minute), estimatedSleep: sleepAmount, coffee: Int64(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            return sleepTime
        } catch {
            return Date.now
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section{
                    HStack {
                        Text("Wake up time:")
                            .font(.headline)
                        Spacer()
                        DatePicker("please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Desired amount of sleep:")
                            .font(.headline)
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 0...24, step: 0.25)
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Coffee intake:")
                            .font(.headline)
                        Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 0...20, step: 1)
                    }
                }
                Section {
                    Text("You should sleep at \(estimatedTime.formatted(date: .omitted, time: .shortened))")
                        .font(.headline)
                }
            }
            .navigationTitle("Better Rest")
        }
    }
}

#Preview {
    ContentView()
}
