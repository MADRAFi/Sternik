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
//    var buildVersionNumber: String? {
//        return infoDictionary?["CFBundleVersion"] as? String
//    }
//    var releaseVersionNumberPretty: String {
//        return "v\(releaseVersionNumber ?? "1.0.0")"
//    }
}
struct SettingsView: View {
    @AppStorage("Show_Correct_Answer") private var ShowCorrect : Bool = true

    let about = Bundle.main.infoDictionary?["About"] as? String
//    else {return print("About not found")}
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Pytania"))  {
                    HStack {
                        Toggle(isOn: $ShowCorrect) {
                            Text("Pokaż dobre odpowiedzi")
                        }
                    }
//                    .foregroundColor(.primary)
                }
                
                Section(header: Text("Informacja")) {
                    VStack {
                        HStack {
                            Image("About")
                                .resizable()
                                .scaledToFit()
//                                .frame(height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding()
                            Text(Bundle.main.appName ?? "")
                                .fontWeight(.medium)
                                .font(.largeTitle)
                        }
                        .frame(height: 150)
                        VStack{
                            Text(about ?? "")
                            Text("Pytania w aplikacji pochodzą z udostępionych w internecie materiałów do nauki.")
                                .frame(width: 350, height: 100)
                        }
                        .frame(width: 350, height: 200)
                    }
                    .padding(.vertical)
                    
                    HStack {
                        Text("Wersja:")
                        Spacer()
                        Text(Bundle.main.releaseVersionNumber ?? "1.0")

                    }
                
                    
                }
                
                
                
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Ustawienia")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                        Button("Wróć", action: {
                            print("wroc")
                        })
                }
            }
            
        }
    }
}
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
