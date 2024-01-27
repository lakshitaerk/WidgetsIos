//
//  WidgetMedium.swift
//  ddui
//
//  Created by lakshita sodhi on 27/01/24.
//

import SwiftUI
import WidgetKit
import MapKit
struct Location3: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let imageName: String
}

class WidgetViewModel3: ObservableObject {
    @Published var locations: [Location3] = [
        Location3(name: "Kolkata", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141), imageName: "person3"),
        Location3(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076), imageName: "person"),
        Location3(name: "Amritsar", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076), imageName: "person2")
    ].shuffled()

    private var timer: Timer?

    init() {
        startTimer()
    }

   

    deinit {
        timer?.invalidate()
    }
    func refreshData() {
           locations.shuffle()
       }
    private func startTimer() {
            timer = Timer.scheduledTimer(withTimeInterval: 300, repeats: true) { [weak self] _ in
                self?.locations.shuffle()
                MyProvider3().reloadTimeline2()
            }
        }
}


struct WidgetLarge: Widget {
    let kind: String = "LargeWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MyProvider3()) { entry in
            MyWidgetView3(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemLarge])
    }
}
struct MyProvider3: TimelineProvider {
    func placeholder(in context: Context) -> MyModel3 {
        MyModel3(date: Date(), imageURL: MapboxImageURLGenerator3.generateURL())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (MyModel3) -> ()) {
        let model = MyModel3(date: Date(), imageURL: MapboxImageURLGenerator3.generateURL())
        completion(model)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<MyModel3>) -> ()) {
        let model = MyModel3(date: Date(), imageURL: MapboxImageURLGenerator3.generateURL())
        let timeline = Timeline(entries: [model], policy: .atEnd)
        completion(timeline)
    }
    internal func reloadTimeline2() {
            let newModel = MyModel3(date: Date(), imageURL: MapboxImageURLGenerator3.generateURL())
            let timeline = Timeline(entries: [newModel], policy: .atEnd)
            WidgetCenter.shared.reloadTimelines(ofKind: "LargeWidget")
        }
}
struct MyModel3: TimelineEntry {
    let date: Date
    let imageURL: URL?
    var image: UIImage? {
        guard let url = imageURL else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: data)
    }
}
struct MyWidgetView3: View {
    var entry: MyProvider3.Entry
    
    
    @StateObject private var viewModel = WidgetViewModel3()
    
    let pinColor = Color(.white)
    
    var body: some View {
        
        ZStack{
            if let image = entry.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Text("No image found.")
            }
            VStack {
                
                ForEach(viewModel.locations) { location in
                    
                    GeometryReader { geometry in
                        
                        VStack {
                            
                            Image(location.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(pinColor, lineWidth: 2))
                            
                            Image(systemName: "triangle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10, height: 10)
                                .foregroundColor(pinColor)
                                .rotationEffect(Angle(degrees: 180))
                                .offset(y: -9)
                            
                            
                        }.offset(x: CGFloat.random(in: 0...(geometry.size.width - 60)),
                                 y: CGFloat.random(in: 0...(geometry.size.height - 60)))
                    }
                }
                    
                  
                    HStack{
                        
                VStack {
                            // Elevated Container
            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .frame(height: 75)
                                .padding()
                                .overlay(
                                HStack(spacing: 20) {
                                        // Circle Button 1
    CircleButton(imageName: "magnifyingglass", buttonColor: Color.gray, action: {
                                            // Action for Button 1
                                            print("Button 1 tapped")
                                        })
                                        
                                        // Circle Button 2
        CircleButton(imageName: "house", buttonColor: Color.purple, action: {
                                            // Action for Button 2
                        print("Button 2 tapped")
                                        })
                                        
                                        // Circle Button 3
        CircleButton(imageName: "message", buttonColor: Color.green,action: {
                                            // Action for Button 3
                                            print("Button 3 tapped")
                                        })
                                        
                                        // Circle Button 4
        CircleButton(imageName: "gear", buttonColor: Color.orange, action: {
                                            // Action for Button 4
                                            print("Button 4 tapped")
                                        })
                                    }
                                        
                                ) .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                        }
                    }
                   
                
            }
            //MapSnapshotImageView()
        }
    }
}
struct CircleButton: View {
    let imageName: String
    let buttonColor: Color
    let action: () -> Void
   
    
    var body: some View {
        Button(action: action) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 35, height: 35)
                .foregroundColor(.white)
                .padding(8)
                .background(Circle().fill(buttonColor))
        }
    }
}

struct MapboxImageURLGenerator3{
    
    
    static func generateURL() -> URL? {
        @State  var longitude = -0.141
        @State var latitude = 51.501
        // Replace this with your logic to generate Mapbox image URL
        return URL(string:
                    "https://api.mapbox.com/styles/v1/erklabs/clrktvr2v002q01peameb9am0/static/\(longitude),\(latitude),13,0/330x340@2x?access_token=pk.eyJ1IjoiZXJrbGFicyIsImEiOiJjbGtqcWRnYTMwbjc4M21sbml3eTUxbHZzIn0.xpSDMZkBifhBOyNdzu21Xw")
    }
}



struct WidgetLarge_Previews: PreviewProvider {
    static var previews: some View {
        MyWidgetView3(entry: MyModel3(date: Date(), imageURL: MapboxImageURLGenerator3.generateURL()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
