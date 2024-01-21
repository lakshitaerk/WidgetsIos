//
//  Mapbox.swift
//  ddui
//
//  Created by lakshita sodhi on 21/01/24.
//

import SwiftUI
@_spi(Experimental) import MapboxMaps

//import _MapKit_SwiftUI



struct Mapbox: View {
    var body: some View {
        let center = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12)
        Map(initialViewport: .camera(center: center, zoom: 8, bearing: 0, pitch: 0))
        .ignoresSafeArea()
        }
    }


struct Mapbox_Previews: PreviewProvider {
    static var previews: some View {
        Mapbox()
    }
}
