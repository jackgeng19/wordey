//
//  ContentView.swift
//  mp04-wordey
//
//  Created by Qicheng Geng on 2/28/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var newSentence = ""
    @State private var color = Color.black
    @State private var size: Float = 35
    @State private var isBold = true
    @State private var isItalic = false
    @State private var alignment: TextAlignment = .leading
    
    var body: some View {
        NavigationView{
            VStack{
                Section{
                    Spacer()
                    TextDisplayView(newSentence: newSentence, color: color, size: CGFloat(size), isBold: isBold, isItalic: isItalic, alignment: alignment)
                }
                Spacer()
                Section{
                    TextField("Enter you sentence", text: $newSentence)
                        .padding()
                }
                .padding()
                HStack{
                    Spacer()
                    NavigationLink(destination: SettingsView(color: $color, size: $size, isBold: $isBold, isItalic: $isItalic, alignment: $alignment)){
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    .padding()
                }
            }
            .navigationTitle("Wordey - App Team ")

        }
    }
}

struct TextDisplayView: View {
    var newSentence: String
    var color: Color
    var size: CGFloat
    var isBold: Bool
    var isItalic: Bool
    var alignment: TextAlignment
    
    var body: some View {
            Text(newSentence)
                .foregroundColor(color)
                .font(isBold && isItalic ? .system(size: size).bold().italic() :
                      isBold ? .system(size: size).bold() :
                      isItalic ? .system(size: size).italic() :
                      .system(size: size))
                .multilineTextAlignment(alignment)
                .padding()
        
    }
}

struct SettingsView: View {
    @Binding var color: Color
    @Binding var size: Float
    @Binding var isBold: Bool
    @Binding var isItalic: Bool
    @Binding var alignment: TextAlignment
    
    var body: some View {
        Form {
            Section(header: Text("Text Color")) {
                ColorPicker("Select a color", selection: $color)
            }
            Section(header: Text("Font Size")) {
                Slider(value: $size, in: 12...48, step: 1)
            }
            Section(header: Text("Text Style")) {
                Toggle("Bold", isOn: $isBold)
                Toggle("Italic", isOn: $isItalic)
            }
            Section(header: Text("Alignment")) {
                Picker("Pick one.", selection: $alignment) {
                    Text("Left").tag(TextAlignment.leading)
                    Text("Center").tag(TextAlignment.center)
                    Text("Right").tag(TextAlignment.trailing)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
        .navigationTitle("Settings")
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
