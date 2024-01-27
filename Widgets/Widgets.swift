
import SwiftUI
import WidgetKit
import MapKit


struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct WidgetSmall: Widget {
    let kind: String = "MyWidget"
   
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MyProvider()) { entry in
            MyWidgetView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
       .supportedFamilies([.systemSmall])
    }
}

struct MyProvider: TimelineProvider {
    func placeholder(in context: Context) -> MyModel {
        MyModel(date: Date(), imageURL: MapboxImageURLGenerator.generateURL())
    }

    func getSnapshot(in context: Context, completion: @escaping (MyModel) -> ()) {
        let model = MyModel(date: Date(), imageURL: MapboxImageURLGenerator.generateURL())
        completion(model)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MyModel>) -> ()) {
        let model = MyModel(date: Date(), imageURL: MapboxImageURLGenerator.generateURL())
        let timeline = Timeline(entries: [model], policy: .atEnd)
        completion(timeline)
    }
}

struct MyModel: TimelineEntry {
    let date: Date
    let imageURL: URL?
    var image: UIImage? {
        guard let url = imageURL else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: data)
    }
}

struct MyWidgetView: View {
    var entry: MyProvider.Entry
   
    
    let locations = [
           Location(name: "Kolkata", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
//           Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
       ]
   
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
                   
                    ForEach(locations) { location in
                        
                        HStack{
                            Spacer()
                            VStack {
                                
                                Image("person3")
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
                                
                                
                            }
                        }
                        .padding(.trailing, 12.0)
                        HStack{
                            
                            VStack{
                                Text("Explore")
                                    .multilineTextAlignment(.leading)
                                    .fontWeight(.bold)
                                Text(location.name)
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                        }
                        .padding(.leading, 8.0)
                    }
                    }
                    //MapSnapshotImageView()
                }
            }
    }

struct MapboxImageURLGenerator {
    @State  var longitude = -0.141
    @State var latitude = 51.501

    static func generateURL() -> URL? {
        @State  var longitude = -0.141
        @State var latitude = 51.501
        // Replace this with your logic to generate Mapbox image URL
        return URL(string: "https://api.mapbox.com/styles/v1/erklabs/clrktvr2v002q01peameb9am0/static/\(longitude),\(latitude),13,0/300x300@2x?access_token=pk.eyJ1IjoiZXJrbGFicyIsImEiOiJjbGtqcWRnYTMwbjc4M21sbml3eTUxbHZzIn0.xpSDMZkBifhBOyNdzu21Xw")
    }
}




struct MyWidget_Previews: PreviewProvider {
    static var previews: some View {
        MyWidgetView(entry: MyModel(date: Date(), imageURL: MapboxImageURLGenerator.generateURL()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

