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
    @AppStorage("Show_Next_Question") private var ShowNextQuestion : Bool = true
    
    let about = Bundle.main.infoDictionary?["About"] as? String
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Informacja")) {
                    VStack {
                        HStack {
                            Image("About")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(20)
                                .padding()
                                .frame(height: 150)
                            Text(Bundle.main.appName ?? "")
                                .fontWeight(.medium)
                                .font(.title)
                                .multilineTextAlignment(.leading)
                        }

                        
                        VStack(alignment: .leading){
                            Text(about ?? "")
//                                .padding(.vertical)
//                            Spacer()
                            Text("Pytania w aplikacji pochodzą z udostępionych w internecie materiałów do nauki.")
                                .padding(.vertical, 8)
                        }
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.vertical)
                }
                
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
