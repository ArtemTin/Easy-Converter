//
//  ContentView.swift
//  Easy Converter
//
//  Created by Артём Тихоненко on 04.06.2020.
//  Copyright © 2020 Артём Тихоненко. All rights reserved.
//


import SwiftUI


struct ContentView: View {
    let input_dict: [String:Double]
    let input_list: [String]
    let updateDate: String
    
    let popularRates: [Int:(String, String)] = [0:("USD", "RUB"), 1:("RUB", "USD"), 2:("EUR", "RUB"), 3:("RUB", "EUR"), 4:("TRY", "RUB"), 5:("GBP", "TRY"), 6:("GBP", "RUB")]
    
    @State private var selectedCurr1 = "USD"
    @State private var selectedCurr2 = "RUB"
    
    @State private var currentAmountIn = ""
    
    private var currentAmountOut: Double {
        let enteredAm = Double(currentAmountIn) ?? 0
        let nowRate = (input_dict[selectedCurr2] ?? 0) / (input_dict[selectedCurr1] ?? 0)
        return enteredAm * nowRate
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Дата обновления курсов - \(updateDate)")) {
                    Picker(selection: $selectedCurr1, label: TextField("Сумма в \(selectedCurr1)", text: $currentAmountIn, onCommit: {})
                        .keyboardType(.asciiCapableNumberPad)) {
                            ForEach(input_list, id: \.self) {
                                Text($0)
                            }
                    }
                    Picker(selection: $selectedCurr2, label: Text(String(format: "%.2f", currentAmountOut))) {
                        ForEach(input_list, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section {
                    Button(action: {
                        swap(&self.selectedCurr1, &self.selectedCurr2)
                        
                    }) {
                        Text("Поменять валюты местами")
                    }
                }
                // USD - 31 RUB - 26 TRY - 30 GBP - 9 EUR - 8
                Section(header: Text("Популярные обмены")) {
                    ForEach(0 ..< popularRates.count) {
                        rateNum in
                        Button(action: {
                            self.selectedCurr1 = self.popularRates[rateNum]?.0 ?? "USD"
                            self.selectedCurr2 = self.popularRates[rateNum]?.1 ?? "RUB"
                        })
                        {
                            Text("\(self.popularRates[rateNum]?.0 ?? "error") -> \(self.popularRates[rateNum]?.1 ?? "error")")
                        }
                    }
                }
                .navigationBarTitle("Easy Converter")
            }
        }
    }
}


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(input_dict: ["EUR":1, "RUB": 15, "USD": 1.2], input_list: ["EUR", "RUB", "USD"], updateDate: "2020-20-20")
    }
}
