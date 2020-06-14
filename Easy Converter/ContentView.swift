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
    @State private var selectedCurr1 = 31
    @State private var selectedCurr2 = 26
    @State private var currentAmountIn = ""
    private var currentAmountOut: Double { (Double(currentAmountIn) ?? 0) * ExchangePair(from_curr: currencies1[selectedCurr1], to_curr: currencies2[selectedCurr2], exchangesDict: exchangeDict).exchangeRate}
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $selectedCurr1, label: TextField("Сумма в \(currencies1[selectedCurr1].rawValue)", text: $currentAmountIn, onCommit: {})
                    .keyboardType(.asciiCapableNumberPad)) {
                        ForEach(0 ..< currencies1.count) {
                            Text(self.currencies1[$0].rawValue)
                        }
                    }
                    Picker(selection: $selectedCurr2, label: Text(String(format: "%.g", currentAmountOut))) {
                        ForEach(0 ..< currencies2.count) {
                            Text(self.currencies2[$0].rawValue)
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
                    Group {
                        Button(action: {
                            self.selectedCurr1 = 31
                            self.selectedCurr2 = 26
                        }) {
                            Text("USD -> RUB")
                        }
                        Button(action: {
                            self.selectedCurr1 = 8
                            self.selectedCurr2 = 26
                        }) {
                            Text("EUR -> RUB")
                        }
                        Button(action: {
                            self.selectedCurr1 = 30
                            self.selectedCurr2 = 26
                        }) {
                            Text("TRY -> RUB")
                        }
                        Button(action: {
                            self.selectedCurr1 = 26
                            self.selectedCurr2 = 31
                        }) {
                            Text("RUB -> USD")
                        }
                        
                        Button(action: {
                            self.selectedCurr1 = 26
                            self.selectedCurr2 = 8
                        }) {
                            Text("RUB -> EUR")
                        }
                        
                        Button(action: {
                            self.selectedCurr1 = 26
                            self.selectedCurr2 = 30
                        }) {
                            Text("RUB -> TRY")
                        }
                        Button(action: {
                            self.selectedCurr1 = 8
                            self.selectedCurr2 = 26
                        }) {
                            Text("EUR -> TRY")
                        }
                    }
                    Button(action: {
                        self.selectedCurr1 = 26
                        self.selectedCurr2 = 8
                    }) {
                        Text("TRY -> EUR")
                    }
                    Button(action: {
                        self.selectedCurr1 = 9
                        self.selectedCurr2 = 30
                    }) {
                        Text("GBP -> TRY")
                    }
                    Button(action: {
                        self.selectedCurr1 = 30
                        self.selectedCurr2 = 9
                    }) {
                        Text("TRY -> GBP")
                    }
                }
                
            }
            .navigationBarTitle(Text("Easy Converter"))
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
        ContentView(currencies1: [.ron, .aud, .brl, .ron, .aud, .brl, .ron, .aud, .brl, .ron, .aud, .brl, .ron, .aud, .brl, .ron, .aud, .brl, .ron, .aud, .brl, .ron, .aud, .brl, .ron, .aud, .brl, .ron, .aud, .brl, .ron, .aud, .brl, .ron, .aud, .brl], currencies2: [.bgn, .cad, .cny, .bgn, .cad, .cny, .bgn, .cad, .cny, .bgn, .cad, .cny, .bgn, .cad, .cny, .bgn, .cad, .cny, .bgn, .cad, .cny, .bgn, .cad, .cny, .bgn, .cad, .cny, .bgn, .cad, .cny, .bgn, .cad, .cny, .bgn, .cad, .cny, .bgn, .cad, .cny])
    }
}
