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
    @State var questionTotal: Int
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
                Button(action: {
                    showStats = false
                }) {
                  HStack {
                    Text("Zamknij")
                        .padding()
                  }
                  .frame(maxWidth: .infinity)
                }
                .contentShape(Rectangle())
                .background(Color("AccentColor"))
                .foregroundColor(Color.primary)
                .clipShape(Capsule())
                .padding()
                
            }
            
        }
        .navigationTitle("Statystyki")
        .navigationViewStyle(.stack)
    }

}


struct StatsView_Previews: PreviewProvider {
    
    static var previews: some View {
        StatsView(showStats: .constant(true), startTime: .constant(Date().addingTimeInterval(12)),endTime: .constant(Date()), questionTotal: 75, answersCorrect: .constant(65), answersWrong: .constant(10))
    }
}
