//
//  ContentView.swift
//  ddui
//
//  Created by lakshita sodhi on 20/12/23.
//

//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

import SwiftUI

extension Color {
    init(hex: String, opacity: Double = 1.0) {
        var hexSanitized = hex
        if hexSanitized.hasPrefix("#") {
            hexSanitized = String(hexSanitized.dropFirst())
        }

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb & 0xff0000) >> 16) / 255.0
        let green = Double((rgb & 0x00ff00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000ff) / 255.0

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}


struct ContentView: View {
    let jsonData = """
        {
          "screen": {
            "title": "Welcome Screen",
            "backgroundColor": "#FFC0CB"
           
          },
          "components": [
            {
              "type": "button",
              "id": "btnSubmit",
              "title": "Submit",
              "backgroundColor": "#4CAF50",
              "textColor": "#800080",
             
            },
            {
              "type": "label",
              "id": "lblMessage",
              "text": "Hello, Server!",
              "textColor": "#333333",
              "font": {
                "size": 18,
                "style": "bold"
              },
    
             
            }
          ]
        }
    """
 
    var body: some View {
        
        if let uiModel = try? JSONDecoder().decode(UIModel.self, from: Data(jsonData.utf8)) {
            ScreenView(uiModel: uiModel)
                .background(Color(hex: uiModel.screen.backgroundColor))
                .navigationTitle(uiModel.screen.title)
        } else {
            Text("Failed to load UI data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ContentView()
    }
}

struct UIModel: Decodable {
    let screen: Screen
    let components: [UIComponent]
}

struct Screen: Decodable {
    let title: String
    let backgroundColor: String
}

struct UIComponent: Decodable {
    let type: String
    let id: String
    let title: String?
    let text: String?
    let backgroundColor: String?
    let textColor: String?
   
   
}





struct ScreenView: View {
    let uiModel: UIModel
 
    var body: some View {
        VStack {
            ForEach(uiModel.components, id: \.id) { component in
                switch component.type {
                case "button":
                    ButtonView(component: component)
                case "label":
                    LabelView(component: component)
                default:
                    EmptyView()
                }
            }
        }
    }
}

struct ButtonView: View {
    let component: UIComponent

    var body: some View {
        Button(action: {
            // Button action
        }) {
            Text(component.title ?? "")
                .foregroundColor(Color(hex: component.textColor ?? ""))
                .padding()
                .background(Color(hex: component.backgroundColor ?? ""))
                .cornerRadius(8)
               
        }
    }
}

struct LabelView: View {
    let component: UIComponent

    var body: some View {
        Text(component.text ?? "")
            .foregroundColor(Color(hex: component.textColor ?? ""))
//            .font(component.font.map { Font.custom($0.style, size: $0.size) } ?? .body)
           
    }
}

