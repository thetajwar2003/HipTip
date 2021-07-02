//
//  ContentView.swift
//  HipTip
//
//  Created by Tajwar Rahman on 7/2/21.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = ""
    @State private var currentTipIndex = 2
    
    let tipPercentages = [0, 10, 15, 20, 25]
    
    var total: Double {
        let tipPercent = Double(tipPercentages[currentTipIndex])/100
        // converts amount to double if it exists otherwise it will be $0.00
        let amountNum = Double(amount) ?? 0
        
        return amountNum * (1 + tipPercent)
    }
    
    var body: some View {
        NavigationView{
            Form {
                // section to enter amount
                Section {
                    TextField("Amount", text: $amount).keyboardType(.decimalPad)
                }
                
                // section to select tip amount
                Section(header: Text("Tip Percentage")){
                    Picker("Tip percentage", selection: $currentTipIndex){
                        ForEach(0 ..< tipPercentages.count){
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                // section that displays total amount with tip
                Section(header: Text("Total Amount")) {
                    Text("$\(total, specifier: "%.2f")").foregroundColor(tipPercentages[currentTipIndex] == 0 ? .red : .black)
                }
            }.navigationTitle(Text("HipTip"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
