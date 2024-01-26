//
//  map.swift
//  ddui
//
//  Created by lakshita sodhi on 17/01/24.
//

import SwiftUI
import MapKit


struct Location : Identifiable{
    let id = UUID()
    let name :String
    let coordinate: CLLocationCoordinate2D
}


struct map: View {
    @State private var mapRegion = MKCoordinateRegion (center:CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan (latitudeDelta: 0.02, longitudeDelta: 0.02))
    
    let locations = [
        Location(name: "Palace", coordinate: CLLocationCoordinate2D(latitude:51.501, longitude:-0.141) ),
        Location (name: "Tower of London" , coordinate: CLLocationCoordinate2D (latitude: 51.508, longitude: -0.076))
    ]
    
    let pinColor = Color (.white)
    
    
    var body: some View {
        Map(coordinateRegion: $mapRegion, annotationItems: locations){
            location in
            MapAnnotation(coordinate: location.coordinate){
                VStack{
//                    Circle()
//                        .stroke(.red, lineWidth: 3)
//                        . frame (width: 44, height:44)
                    Image("person2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(pinColor, lineWidth: 2))
                   // .aspectRatio( contentMode: .fit)
                   // .foregroundColor(.white)
                   // .background(Color("white"))
                    Image(systemName: "triangle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 10)
                    .foregroundColor(pinColor)
                    .rotationEffect(Angle(degrees: 180))
                    .offset(y:-10)
                    
                    
                    
                    Text(location.name)
                        .fontWeight(.bold)
                    
                }
            }
        }
    }
    
}

struct map_Previews: PreviewProvider {
static var previews: some View {
map()
}
}
