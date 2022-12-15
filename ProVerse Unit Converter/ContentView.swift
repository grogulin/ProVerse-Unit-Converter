//
//  ContentView.swift
//  ProVerse Unit Converter
//
//  Created by Ярослав Грогуль on 15.12.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue: Double = 100
    @State private var unitFrom = "C°"
    @State private var unitTo = "K°"
    @State private var unitChosen = "Temperature"
    
    @FocusState private var isInputActive: Bool
    
    let units = ["Temperature", "Length", "Time", "Volume"]
    
    let unitsFrom = [
        "Temperature": ["C°", "K°", "F°"],
        "Length": ["m", "km", "mi", "ft", "yd"],
        "Time": ["sec", "min", "hr", "d"],
        "Volume": ["ml", "l", "cup", "pt", "gal"]
        ]
    
    let unitsTo = [
        "Temperature": ["C°", "K°", "F°"],
        "Length": ["m", "km", "mi", "ft", "yd"],
        "Time": ["sec", "min", "hr", "d"],
        "Volume": ["ml", "l", "cup", "pt", "gal"]
        ]
    
    var inputValueInBase: Double {
        switch unitChosen {
        case "Temperature": do {
            //Base unit - C°
            switch unitFrom {
            case "F°":  return (inputValue - 32) * 5 / 9
            case "K°":  return inputValue - 273.15
            default:    return inputValue
            }
        }
        case "Length": do {
            switch unitFrom {
            //Base unit - meters
            case "km":  return inputValue * 1000
            case "mi":  return inputValue * 1609.34
            case "ft":  return inputValue / 3.281
            case "yd":  return inputValue / 1.094
            default:    return inputValue
            }
        }
        case "Time": do {
            //Base unit - seconds
            switch unitFrom {
            case "min": return inputValue * 60
            case "hr":  return inputValue * 60 * 60
            case "d":   return inputValue * 60 * 60 * 24
            default:    return inputValue
            }
        }
        case "Volume": do {
            //Base unit - liters
            switch unitFrom {
            case "ml":  return inputValue / 1000
            case "cup": return inputValue / 3.52
            case "pt":  return inputValue / 1.76
            case "gal": return inputValue * 4.546
            default:    return inputValue
            }
        }
        default: do {
            switch unitFrom {
            case "F°":  return (inputValue - 32) * 5 / 9
            case "K°":  return inputValue - 273.15
            default:    return inputValue
            }
        }
        }
        
    }
    
    var resultValue: Double {
        switch unitChosen {
        case "Temperature": do {
            //Base unit - C°
            switch unitTo {
            case "F°":  return (inputValueInBase * 9 / 5) + 32
            case "K°":  return inputValueInBase + 273.15
            default:    return inputValueInBase
            }
        }
        case "Length": do {
            switch unitTo {
            //Base unit - meters
            case "km":  return inputValueInBase / 1000
            case "mi":  return inputValueInBase / 1609.34
            case "ft":  return inputValueInBase * 3.281
            case "yd":  return inputValueInBase * 1.094
            default:    return inputValueInBase
            }
        }
        case "Time": do {
            //Base unit - seconds
            switch unitTo {
            case "min": return inputValueInBase / 60
            case "hr":  return inputValueInBase / 60 / 60
            case "d":   return inputValueInBase / 60 / 60 / 24
            default:    return inputValueInBase
            }
        }
        case "Volume": do {
            //Base unit - liters
            switch unitTo {
            case "ml":  return inputValueInBase * 1000
            case "cup": return inputValueInBase * 3.52
            case "pt":  return inputValueInBase * 1.76
            case "gal": return inputValueInBase / 4.546
            default:    return inputValueInBase
            }
        }
        default: do {
            switch unitTo {
            case "F°":  return (inputValueInBase * 9 / 5) + 32
            case "K°":  return inputValueInBase + 273.15
            default:    return inputValueInBase
            }
        }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select", selection: $unitChosen) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("What are we converting?")
                }
                
                Section {
                    TextField("Enter your value here", value: $inputValue, format: .number)
                        .focused($isInputActive)
                        .keyboardType(.decimalPad)
                    Picker("Select initial unit", selection: $unitFrom) {
                        ForEach(unitsFrom[unitChosen] ?? ["n/a"], id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("Enter your value here")
                }

                Section {
                    Picker("Select result unit", selection: $unitTo) {
                        ForEach(unitsTo[unitChosen] ?? ["n/a"], id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("Select result units")
                }

                Section {
                    Text(resultValue.formatted())
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
