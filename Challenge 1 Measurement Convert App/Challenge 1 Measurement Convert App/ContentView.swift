//
//  ContentView.swift
//  Challenge 1 Measurement Convert App
//
//  Created by Nidhi Pabbathi on 6/2/23.
//

import SwiftUI

struct ContentView: View {
    @State private var firstValue = 0.0
    @State private var firstMeasurementType = "Teaspoon"
    
    @State private var secondMeasurementType = "Teaspoon"
    
    private var finalConvertion: Double {
        var first = 1.0
        var second = 1.0
        
        if (firstMeasurementType == "Tablespoon") {
            first = 3.0
        } else if (firstMeasurementType == "Cup") {
            first = 3.0 * 16.0
        }
        
        if (secondMeasurementType == "Tablespoon") {
            second = 3.0
        } else if (secondMeasurementType == "Cup") {
            second = 3.0 * 16.0
        }
        
        
        return (first * firstValue) / (second)
    }
    
    let measurements = ["Teaspoon", "Tablespoon", "Cup"]
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter value here", value: $firstValue, format: .number)
                        .multilineTextAlignment(.center)
                    
                    Picker("Measurement", selection: $firstMeasurementType) {
                        ForEach(measurements, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Enter amount of \(firstMeasurementType)s")
                }
                
                Section {
                    Picker("Measurement", selection: $secondMeasurementType) {
                        ForEach(measurements, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert to:")
                }
                
                Section {
                    Text("\(firstValue) \(firstMeasurementType)(s) are \(finalConvertion) \(secondMeasurementType)(s)")
                    Text(Subject, formatter: <#T##Foundation.Formatter#>)
                }
            }
            .navigationTitle(Text("Measurment Converter"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
