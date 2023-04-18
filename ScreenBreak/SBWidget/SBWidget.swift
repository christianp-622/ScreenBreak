//
//  SBWidget.swift
//  SBWidget
//
//  Created by Christian Pichardo on 4/11/23.
//

import WidgetKit
import SwiftUI
import DeviceActivity

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> ScreenTimeEntry {
        ScreenTimeEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (ScreenTimeEntry) -> ()) {
        let entry = ScreenTimeEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [ScreenTimeEntry] = []

        // Generate a timeline consisting of five entries 30 minutes apart, starting from the current time.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = ScreenTimeEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct ScreenTimeEntry: TimelineEntry {
    let date: Date
    
}

struct SBWidgetEntryView : View {
    @State private var widgetContext: DeviceActivityReport.Context = .init(rawValue: "Widget")
    @State private var filter = DeviceActivityFilter(
        segment: .daily(
            during: Calendar.current.dateInterval(
               of: .day, for: .now
            )!
        ),
        users: .all,
        devices: .init([.iPhone, .iPad])
    )
    
    var entry: ScreenTimeEntry

    var body: some View {
        ZStack{
            
            ContainerRelativeShape().fill(Color("backgroundColor").gradient.opacity(0.9))
            DeviceActivityReport(widgetContext, filter: filter)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color("borderColor"), lineWidth: 5)
        )
        
        
    }
}


struct SBWidget: Widget {
    let kind: String = "SBWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            SBWidgetEntryView(entry:entry)
        }
        .configurationDisplayName("ScreenBreak Widget")
        .description("This widget will update with your current screentime every 20 minutes")
        .supportedFamilies([.systemSmall])
    }
}

/*
struct SBWidget_Previews: PreviewProvider {
    static var previews: some View {
        SBWidgetEntryView(entry: ScreenTimeEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
 */

extension Date{
    var weekdayDisplayFormat:String{
        self.formatted(.dateTime.weekday(.wide))
    }
}
