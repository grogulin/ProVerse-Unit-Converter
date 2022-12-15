//
//  ContentView.swift
//  ProVerse Unit Converter
//
//  Created by Ярослав Грогуль on 15.12.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue: Double = 100
    @State private var temperatureUnitFrom = "C°"
    @State private var temperatureUnitTo = "K°"
    
    @FocusState private var isInputActive: Bool
    
//    let temperatureUnits = ["C°", "K°", "F°"]
    let temperatureUnitsFrom = ["C°", "K°", "F°"]
    let temperatureUnitsTo = ["C°", "K°", "F°"]
    
    var resultValue: Double {
        return convertTemperature(from: temperatureUnitFrom, to: temperatureUnitTo)
    }
    
    func convertTemperature(from fromUnit: String, to toUnit: String) -> Double {
        switch temperatureUnitFrom {
        case "C°": do {
            switch temperatureUnitTo {
            case "K°": return inputValue + 273.15
            case "F°": return (inputValue * 9 / 5) + 32
            default: return inputValue
            }
        }
        case "K°": do {
            switch temperatureUnitTo {
            case "C°": return inputValue - 273.15
            case "F°": return (inputValue - 273.15) * (9 / 5) + 32
            default: return inputValue
            }
        }
        case "F°": do {
            switch temperatureUnitTo {
            case "C°": return (inputValue - 32) * 5 / 9
            case "K°": return (inputValue - 32) * (5 / 9) + 273.15
            default: return inputValue
            }
        }
        default: return inputValue
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter your value here", value: $inputValue, format: .number)
                        .focused($isInputActive)
                        .keyboardType(.decimalPad)
                    Picker("Select initial unit", selection: $temperatureUnitFrom) {
                        ForEach(temperatureUnitsFrom, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("Enter your value here")
                }
                
                Section {
                    Picker("Select result unit", selection: $temperatureUnitTo) {
                        ForEach(temperatureUnitsTo, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("Select result units")
                }
                
                Section {
                    Text(resultValue, format: .number)
                } header: {
                    Text("Resulting value")
                }
                
            }
            .navigationTitle("ProVerse")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isInputActive = false
                    }
                }
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
