//
//  WidgetMedium.swift
//  ddui
//
//  Created by lakshita sodhi on 27/01/24.
//

import SwiftUI
import WidgetKit
import MapKit


struct Location2: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let imageName: String
}
struct WidgetMedium: Widget {
    let kind: String = "Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MyProvider2()) { entry in
            MyWidgetView2(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}
struct MyProvider2: TimelineProvider {
    func placeholder(in context: Context) -> MyModel2 {
        MyModel2(date: Date(), imageURL: MapboxImageURLGenerator2.generateURL())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (MyModel2) -> ()) {
        let model = MyModel2(date: Date(), imageURL: MapboxImageURLGenerator2.generateURL())
        completion(model)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<MyModel2>) -> ()) {
        let model = MyModel2(date: Date(), imageURL: MapboxImageURLGenerator2.generateURL())
        let timeline = Timeline(entries: [model], policy: .atEnd)
        completion(timeline)
    }
}
struct MyModel2: TimelineEntry {
    let date: Date
    let imageURL: URL?
    var image: UIImage? {
        guard let url = imageURL else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: data)
    }
}
struct MyWidgetView2: View {
    var entry: MyProvider2.Entry
    
    
    @State private var locations = [
        Location2(name: "Kolkata", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141),imageName: "person2"),
        Location2(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076),imageName: "person3")
    ].shuffled()
    
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
                
                
                
                HStack(){
                    ForEach(locations) { location in
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
                                
                            } .offset(x: CGFloat.random(in: 0...(geometry.size.width - 60)),
                                      y: CGFloat.random(in: 0...(geometry.size.height - 60)))
                            
                        }
                    }
                    
                }
                .padding([.top, .leading, .trailing], 8.0)
                .frame(maxWidth: .infinity)
                .onAppear{
                    // Start a timer to shuffle the array every second
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        locations.shuffle()
                    }
                }
                
                HStack{
                    
                    VStack(alignment: .leading){
                        Text("Explore People")
                        
                            .fontWeight(.bold)
                        Text("Kolkata")
                        
                    }
                    Spacer()
                }
                .padding([.leading, .bottom], 10.0)
            }
        }
        //MapSnapshotImageView()
    }
}


struct MapboxImageURLGenerator2{
   
    
    static func generateURL() -> URL? {
        @State  var longitude = -0.141
        @State var latitude = 51.501
        // Replace this with your logic to generate Mapbox image URL
        return URL(string:"https://api.mapbox.com/styles/v1/erklabs/clrktvr2v002q01peameb9am0/static/\(longitude),\(latitude),13,0/650x300@2x?access_token=pk.eyJ1IjoiZXJrbGFicyIsImEiOiJjbGtqcWRnYTMwbjc4M21sbml3eTUxbHZzIn0.xpSDMZkBifhBOyNdzu21Xw")
    }
}



struct WidgetMedium_Previews: PreviewProvider {
    static var previews: some View {
        MyWidgetView2(entry: MyModel2(date: Date(), imageURL: MapboxImageURLGenerator2.generateURL()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
