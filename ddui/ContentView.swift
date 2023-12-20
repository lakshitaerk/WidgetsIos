//
//  ContentView.swift
//  ddui
//
//  Created by lakshita sodhi on 20/12/23.
//


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
        "backgroundColor": "#B22222"
       
      },
      "components": [
   
        {
                "type": "image",
                "id": "imgLogo",
                "url": "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8fDA%3D",
                          
                },
   
       

        {
              "type": "label",
              "id": "lblMessage",
              "text": "@selenagomez",
              "textColor": "#ffffff",
              "font": {
                "size": 18,
                "style": "bold"
           }
              },
    {
                  "type": "list",
                  "id": "lstItems",
               "backgroundColor": "#ffffff",
                  "items": [
                    {"id": "item1", "text": "Shop here"},
                    {"id": "item2", "text": "Rare beauty "},
                    {"id": "item3", "text": "Item 3"},
                    {"id": "item4", "text": "Item 4"},
                    {"id": "item5", "text": "Item 5"},
                  ],
                
                },
        {
          "type": "button",
          "id": "btnSubmit",
          "title": "Submit",
          "backgroundColor": "#ffffff",
          "textColor": "#800080",
         
        },
        
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

struct UIComponent: Decodable,Identifiable {
let type: String
let id: String
let title: String?
let text: String?
let backgroundColor: String?
let textColor: String?
let url: String?
let items: [ListItem]?
}



struct ListItem: Decodable, Identifiable {
let id: String
let text: String
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
            case "image":
                ImageView(component: component)
            case "list":
                ListView(component: component)
            default:
                EmptyView()
            }
            
        }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    
}
}
struct ListView: View {
let component: UIComponent

var body: some View {
    ScrollView {
    VStack {
        ForEach(component.items ?? []) { item in
                Text(item.text)
                .frame(maxWidth: .infinity)
                .padding(12)
                .background(
               RoundedRectangle(cornerRadius: 10) // Adjust cornerRadius as needed
                   .fill(Color(hex: component.backgroundColor ?? ""))
           )
           .clipShape(RoundedRectangle(cornerRadius: 10))

        }
    }.padding(.horizontal, 8.0)
            }
        }
    }

struct ImageView: View {
let component: UIComponent

var body: some View {
    if let imageUrl = URL(string: component.url ?? ""),
       let imageData = try? Data(contentsOf: imageUrl),
       let uiImage = UIImage(data: imageData) {
        Image(uiImage: uiImage)
            .resizable()
            .frame(width: 150, height: 150)
            .cornerRadius(100)
            
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

