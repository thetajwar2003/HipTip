//
//  ContentView.swift
//  HipTip
//
//  Created by Tajwar Rahman on 7/2/21.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = ""
    @State private var ppl = ""
    @State private var tip: Double = 0
    @State private var currentTipIndex = 2
    @AppStorage("darkMode") private var darkMode = false
    
    let tipPercentages = [0, 10, 15, 20, 25]
    
    var total: Double {
        var tipPercent: Double
        if tip > 0{
            tipPercent = tip
        }
        
        else {
            tipPercent = Double(tipPercentages[currentTipIndex])/100
        }
        // converts amount to double if it exists otherwise it will be $0.00
        let amountNum = Double(amount) ?? 0
        
        return amountNum * (1 + tipPercent)
    }
    
    var totalPerPerson: Double {
        var tipPercent: Double
        if tip > 0{
            tipPercent = tip
        }
        
        else {
            tipPercent = Double(tipPercentages[currentTipIndex])/100
        }
        let numOfPeople = Double(ppl) ?? 1
        // converts amount to double if it exists otherwise it will be $0.00
        let amountNum = Double(amount) ?? 0
       
        let total = amountNum * (1 + tipPercent)
        let perPerson = total / numOfPeople
       
        return perPerson

    }
    
    var body: some View {
        NavigationView{
            Form {
                // section to enter amount and number of people to split with
                Section {
                    TextField("Amount", text: $amount).keyboardType(.decimalPad)
                    TextField("Number of people", text: $ppl).keyboardType(.numberPad)
                }
                
                // section to select tip amount
                Section(header: Text("Tip Percentage")){
                    HStack {
                        Slider(value: $tip, in: 0...100)
                        Text("\(tip, specifier: "%.0f")%")
                    }
                    Picker("Tip percentage", selection: $currentTipIndex){
                        ForEach(0 ..< tipPercentages.count){
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                // section that displays total amount with tip
                Section(header: Text("Total Amount")) {
                    Text("$\(total, specifier: "%.2f")")
                }
                // section that displays total amount with tip per person
                Section(header: Text("Total Amount Per Person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }.navigationTitle(Text("HipTip"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: Settings()) {
                        Image(systemName: "gearshape.fill")
                    }
                }
            }
        }.preferredColorScheme(darkMode ? .dark : .light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
