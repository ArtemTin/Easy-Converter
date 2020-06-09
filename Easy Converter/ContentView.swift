//
//  ContentView.swift
//  Easy Converter
//
//  Created by Артём Тихоненко on 04.06.2020.
//  Copyright © 2020 Артём Тихоненко. All rights reserved.
//


import SwiftUI


struct ContentView: View {
    let currencies1: [Currency]
    let currencies2: [Currency]
    @State private var selectedCurr1 = 0
    @State private var selectedCurr2 = 0
    @State private var currentAmountIn = ""
    private var currentAmountOut: Double { (Double(currentAmountIn) ?? 0) * ExchangePair(from_curr: currencies1[selectedCurr1], to_curr: currencies2[selectedCurr2], exchangesDict: exchangeDict).exchangeRate}
    var body: some View {
        VStack {
            Text("Easy Converter")
                .font(.largeTitle)
            HStack {
                Text("Enter in \(currencies1[selectedCurr1].rawValue)")
                TextField("", text: $currentAmountIn)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            }
            HStack {
                
                Text("Result in \(currencies2[selectedCurr2].rawValue)")
                Text(String(format: "%.2f", currentAmountOut))
                Spacer()
            }
            VStack {
                Button(action: {
                    let tmp = self.selectedCurr1
                    self.selectedCurr1 = self.selectedCurr2
                    self.selectedCurr2 = tmp
                    
                }) {
                    Text("Swap")
                }
                Picker(selection: $selectedCurr1, label: Text("FROM") .bold()) {
                    ForEach(0 ..< currencies1.count) {
                        Text(self.currencies1[$0].rawValue)
                    }
                }
                
                Picker(selection: $selectedCurr2, label: Text("TO") .bold()) {
                    ForEach(0 ..< currencies2.count) {
                        Text(self.currencies2[$0].rawValue)
                    }
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(currencies1: [.ron, .aud, .brl], currencies2: [.bgn, .cad, .cny])
    }
}
