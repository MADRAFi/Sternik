//
//  StatsView.swift
//  Sternik
//
//  Created by MADRAFi on 17/08/2022.
//

import SwiftUI

struct StatsView: View {

    @Binding var showStats: Bool
    
    @Binding var startTime: Date
    @Binding var endTime: Date
    @Binding var questionTotal: Int
    @Binding var answersCorrect: Int
    @Binding var answersWrong: Int
    
    var body: some View {
        
        let diffComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: startTime, to: endTime)
        let hours = diffComponents.hour
        let minutes = diffComponents.minute
        let seconds = diffComponents.second

        
        NavigationView {
            VStack {
                List {
                    Section {
                        HStack {
                            Text("Czas")
                            Spacer()
                            Text("\(hours!, specifier: "%.2d"):\(minutes!, specifier: "%.2d"):\(seconds!, specifier: "%.2d")" )

                        }
                    }
                    Section {
                        HStack {
                            Text("Ilość pytań")
                            Spacer()
                            Text(String(questionTotal))
                        }
                        HStack {
                            Text("Odpowiedzi prawidłowe")
                            Spacer()
                            Text(String(answersCorrect))
                        }
                        HStack {
                            Text("Odpowiedzi błędne")
                            Spacer()
                            Text(String(answersWrong))
                        }
                    }
                    Section {
                        HStack {
                            Text("Wynik")
                            Spacer()
                            Text("\(Float(answersCorrect) / Float(questionTotal) * 100, specifier: "%.0f %%")")
                        }
                    }
                }
                HStack {
                    Spacer()
                    Button("Zamknij") {
//                        presentationMode.wrappedValue.dismiss()
                        showStats = false
                    }

                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("AccentColor"))
                    .foregroundColor(Color.primary)
                    .clipShape(Capsule())
                    Spacer()
                }
            }
            .navigationTitle("Statystyki")
        }
        .navigationViewStyle(.stack)
    }
}

struct StatsView_Previews: PreviewProvider {
    
    static var previews: some View {
        StatsView(showStats: .constant(true), startTime: .constant(Date()),endTime: .constant(Date().addingTimeInterval(12)), questionTotal: .constant(75), answersCorrect: .constant(65), answersWrong: .constant(10))
    }
}
