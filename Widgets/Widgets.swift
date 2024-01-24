//////
//////  Widgets.swift
//////  Widgets
//////
//////  Created by lakshita sodhi on 17/01/24.
//////
////
////import WidgetKit
////import SwiftUI
////import Intents
////import MapKit
////
//////struct Provider: IntentTimelineProvider {
//////    func placeholder(in context: Context) -> SimpleEntry {
//////        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
//////    }
//////
//////    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//////        let entry = SimpleEntry(date: Date(), configuration: configuration)
//////        completion(entry)
//////    }
//////
//////    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//////        var entries: [SimpleEntry] = []
//////
//////        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//////        let currentDate = Date()
//////        for hourOffset in 0 ..< 5 {
//////            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//////            let entry = SimpleEntry(date: entryDate, configuration: configuration)
//////            entries.append(entry)
//////        }
//////
//////        let timeline = Timeline(entries: entries, policy: .atEnd)
//////        completion(timeline)
//////    }
//////}
//////
//////struct SimpleEntry: TimelineEntry {
//////    let date: Date
//////    let configuration: ConfigurationIntent
//////}
//////
//////struct WidgetsEntryView : View {
//////    var entry: Provider.Entry
//////
//////    var body: some View {
//////        Text("Hii Lakshita")
//////    }
//////}
//////
////struct Widgets: Widget {
//////    let kind: String = "Widgets"
//////
//////    var body: some WidgetConfiguration {
//////        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
//////            WidgetsEntryView(entry: entry)
//////        }
//////        .configurationDisplayName("My Widget")
//////        .description("This is an example widget.")
//////    }
////    let kind: String = "MapWidget"
////
////        var body: some WidgetConfiguration {
////            StaticConfiguration(kind: kind, provider: MapProvider()) { entry in
////                MapWidgetView()
////                    .background(Image(uiImage: entry.mapImage).resizable())
////            }
////            .configurationDisplayName("Map Widget")
////            .description("Display a static map in the widget.")
////        }
////}
////
////struct Location: Identifiable {
////    let id = UUID()
////    let name: String
////    let coordinate: CLLocationCoordinate2D
////}
////
////struct MapWidgetView: View {
////    let locations = [
////        Location(name: "Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
////        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
////    ]
////
////    let pinColor = Color(.blue)
////
////    var body: some View {
////        VStack {
////            ForEach(locations) { location in
////                VStack {
////                    Image("person")
////                        .resizable()
////                        .scaledToFill()
////                        .frame(width: 50, height: 50)
////                        .clipShape(Circle())
////                        .overlay(Circle().stroke(pinColor, lineWidth: 2))
////
////                    Image(systemName: "triangle.fill")
////                        .resizable()
////                        .scaledToFit()
////                        .frame(width: 10, height: 10)
////                        .foregroundColor(pinColor)
////                        .rotationEffect(Angle(degrees: 180))
////                        .offset(y: -10)
////
////                    Text(location.name)
////                        .fontWeight(.bold)
////                }
////            }
////        }
////    }
////
////    func generateMapImage() -> UIImage {
////            let mapView = Map(coordinateRegion: .constant(MKCoordinateRegion(
////                center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12),
////                span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
////            )), showsUserLocation: false)
////
////            let hostingController = UIHostingController(rootView: mapView)
////            let view = hostingController.view
////
////            let targetSize = hostingController.view.intrinsicContentSize
////            view?.bounds = CGRect(origin: .zero, size: targetSize)
////            view?.layoutIfNeeded()
////
////            let renderer = UIGraphicsImageRenderer(size: targetSize)
////            return renderer.image { _ in
////                view?.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
////            }
////        }
////    }
////struct MapProvider: TimelineProvider {
////    func placeholder(in context: Context) -> MapEntry {
////           MapEntry(date: Date(), mapImage: MapWidgetView().generateMapImage())
////       }
////
////       func getSnapshot(in context: Context, completion: @escaping (MapEntry) -> ()) {
////           let entry = MapEntry(date: Date(), mapImage: MapWidgetView().generateMapImage())
////           completion(entry)
////       }
////
////       func getTimeline(in context: Context, completion: @escaping (Timeline<MapEntry>) -> ()) {
////           let entry = MapEntry(date: Date(), mapImage: MapWidgetView().generateMapImage())
////           let timeline = Timeline(entries: [entry], policy: .atEnd)
////           completion(timeline)
////       }
////}
////
////struct MapEntry: TimelineEntry {
////    let date: Date
////    let mapImage: UIImage
////}
////
////
////struct Widgets_Previews: PreviewProvider {
////    static var previews: some View {
////        MapWidgetView()
////            .previewContext(WidgetPreviewContext(family: .systemSmall))
////    }
////}
//import WidgetKit
//import SwiftUI
//import MapKit
//@_spi(Experimental) import MapboxMaps
//
//struct Location: Identifiable {
//    let id = UUID()
//    let name: String
//    let coordinate: CLLocationCoordinate2D
//}
//
//struct MapWidgetView: View {
//    let locations = [
//        Location(name: "Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
//        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
//    ]
//
//    let pinColor = Color(.blue)
//
//    var body: some View {
//        VStack {
//            ForEach(locations) { location in
//                ZStack{
//                    VStack {
//
//                        Image("person")
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 50, height: 50)
//                            .clipShape(Circle())
//                            .overlay(Circle().stroke(pinColor, lineWidth: 2))
//
//                        Image(systemName: "triangle.fill")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 10, height: 10)
//                            .foregroundColor(pinColor)
//                            .rotationEffect(Angle(degrees: 180))
//                            .offset(y: -10)
//
//                        Text(location.name)
//                            .fontWeight(.bold)
//                    }
//                }
//            }
//            //MapSnapshotImageView()
//        }
//    }
//}
//
//struct MapSnapshotImageView: View {
//    var body: some View {
//        Image(uiImage: MapSnapshotView().generateMapImage())
//            .resizable()
//            .aspectRatio(contentMode: .fill)
//            //.frame(height: 200)
//            .cornerRadius(10)
//    }
//}
//
//struct MapSnapshotView: UIViewRepresentable {
//    func makeUIView(context: Context) -> MKMapView {
//        MKMapView()
//    }
//
//    func updateUIView(_ uiView: MKMapView, context: Context) {
//        let region = MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12),
//            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
//        )
//        uiView.setRegion(region, animated: true)
//    }
//
//    func generateMapImage() -> UIImage {
//        let hostingController = UIHostingController(rootView: self)
//        let view = hostingController.view
//
//        let targetSize = hostingController.view.intrinsicContentSize
//        view?.bounds = CGRect(origin: .zero, size: targetSize)
//        view?.layoutIfNeeded()
//
//        let renderer = UIGraphicsImageRenderer(size: targetSize)
//        return renderer.image { _ in
//            view?.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
//        }
//    }
//}
//
//
//struct Widgets: Widget {
//    let kind: String = "MapWidget"
//
//    var body: some WidgetConfiguration {
//        StaticConfiguration(kind: kind, provider: MapProvider()) { entry in
//            MapWidgetView()
//        }
//        .configurationDisplayName("Map Widget")
//        .description("Display a static map in the widget.")
//    }
//}
//
//struct MapProvider: TimelineProvider {
//    func placeholder(in context: Context) -> MapEntry {
//        MapEntry(date: Date(), mapImage: MapSnapshotView().generateMapImage())
//    }
//
//    func getSnapshot(in context: Context, completion: @escaping (MapEntry) -> ()) {
//        let entry = MapEntry(date: Date(), mapImage: MapSnapshotView().generateMapImage())
//        completion(entry)
//    }
//
//    func getTimeline(in context: Context, completion: @escaping (Timeline<MapEntry>) -> ()) {
//        let entry = MapEntry(date: Date(), mapImage: MapSnapshotView().generateMapImage())
//        let timeline = Timeline(entries: [entry], policy: .atEnd)
//        completion(timeline)
//    }
//}
//
//struct MapEntry: TimelineEntry {
//    let date: Date
//    let mapImage: UIImage
//}
//
//struct MapWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        MapWidgetView()
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
//
import SwiftUI
import WidgetKit

struct MyWidget: Widget {
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
        MyModel(date: Date(), imageURL: URL(string: "https://api.mapbox.com/styles/v1/erklabs/clrktvr2v002q01peameb9am0/static/-122.2693,37.8014,12,0/300x300@2x?access_token=pk.eyJ1IjoiZXJrbGFicyIsImEiOiJjbGtqcWRnYTMwbjc4M21sbml3eTUxbHZzIn0.xpSDMZkBifhBOyNdzu21Xw"))
    }

    func getSnapshot(in context: Context, completion: @escaping (MyModel) -> ()) {
        let model = MyModel(date: Date(), imageURL: URL(string: "https://api.mapbox.com/styles/v1/erklabs/clrktvr2v002q01peameb9am0/static/-122.2693,37.8014,12,0/300x300@2x?access_token=pk.eyJ1IjoiZXJrbGFicyIsImEiOiJjbGtqcWRnYTMwbjc4M21sbml3eTUxbHZzIn0.xpSDMZkBifhBOyNdzu21Xw"))
        completion(model)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MyModel>) -> ()) {
        let model = MyModel(date: Date(), imageURL: URL(string: "https://api.mapbox.com/styles/v1/erklabs/clrktvr2v002q01peameb9am0/static/-122.2693,37.8014,12,0/300x300@2x?access_token=pk.eyJ1IjoiZXJrbGFicyIsImEiOiJjbGtqcWRnYTMwbjc4M21sbml3eTUxbHZzIn0.xpSDMZkBifhBOyNdzu21Xw"))
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

    var body: some View {
        VStack {
            if let image = entry.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Text("No image found.")
            }
        }
    }
}


struct MyWidgetBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        MyWidget()
    }
}

struct MyWidget_Previews: PreviewProvider {
    static var previews: some View {
        MyWidgetView(entry: MyModel(date: Date(), imageURL: URL(string: "https://api.mapbox.com/styles/v1/erklabs/clrktvr2v002q01peameb9am0/static/-122.2693,37.8014,12,0/300x300@2x?access_token=pk.eyJ1IjoiZXJrbGFicyIsImEiOiJjbGtqcWRnYTMwbjc4M21sbml3eTUxbHZzIn0.xpSDMZkBifhBOyNdzu21Xw")))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

