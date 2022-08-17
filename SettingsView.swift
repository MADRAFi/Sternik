//
//  SettingsView.swift
//  Sternik
//
//  Created by MADRAFi on 08/08/2022.
//

import SwiftUI

extension Bundle {
    var appName: String? {
        return infoDictionary?["CFBundleDisplayName"] as? String
    }
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }

}
struct SettingsView: View {
    @AppStorage("Show_Correct_Answer") private var ShowCorrect : Bool = true
    @AppStorage("Show_Next_Question") private var ShowNextQuestion : Bool = false
    
    let about = Bundle.main.infoDictionary?["About"] as? String
    //    else {return print("About not found")}
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Pytania"))  {
                    HStack {
                        Toggle(isOn: $ShowCorrect) {
                            Text("Pokaż prawidłowe odpowiedzi")
                        }
                    }
                    HStack {
                        Toggle(isOn: $ShowNextQuestion) {
                            Text("Pokaż następne pytanie")
                        }
                    }
                }
                
                Section(header: Text("Informacja")) {
                    VStack {
                        HStack {
                            Image("About")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(20)
                                .padding()
                            Text(Bundle.main.appName ?? "")
                                .fontWeight(.medium)
                                .font(.largeTitle)
                        }
                        .frame(height: 150)
                        
                        VStack(alignment: .leading){
                            Text(about ?? "")
                                .padding(.vertical)
//                            Spacer()
                            Text("Pytania w aplikacji pochodzą z udostępionych w internecie materiałów do nauki.")
                        }
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                    }
                    .padding(.vertical)
                }
                Section {
                    HStack {
                        Text("Wersja:")
                        Spacer()
                        Text(Bundle.main.releaseVersionNumber ?? "1.0")
                        
                    }
                }
                
                
            }
//            .listStyle(GroupedListStyle())
            .navigationTitle("Ustawienia")
            .navigationBarTitleDisplayMode(.large)

        }
        .navigationViewStyle(.stack)
        
    }
}
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
