//
//  WidgetsBundle.swift
//  Widgets
//
//  Created by lakshita sodhi on 17/01/24.
//

import WidgetKit
import SwiftUI

@main
struct WidgetsBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
     
        WidgetSmall()
      WidgetMedium()
        WidgetLarge()
    
        WidgetsLiveActivity()
    }
}
