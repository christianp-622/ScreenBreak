//
//  ExampleView.swift
//  ReportExtension
//
//  Created by Christian Pichardo on 3/28/23.
//

import SwiftUI
import ManagedSettings
import DeviceActivity


struct ExampleView: View {
    let selectedApps: Set<ApplicationToken>
    let selectedCategories: Set<ActivityCategoryToken>
    let selectedWebDomains: Set<WebDomainToken>

    @State private var context: DeviceActivityReport.Context = .barGraph
    @State private var filter = DeviceActivityFilter(
        segment: .daily(
            during: Calendar.current.dateInterval(
               of: .weekOfYear, for: .now
            )!
        ),
        users: .children,
        devices: .init([.iPhone, .iPad])
        /*
        applications: selectedApps,
        categories: selectedCategories,
        webDomains: selectedWebDomains
         */
    )

    public var body: some View {
        VStack {
            DeviceActivityReport(context, filter: filter)

            // A picker used to change the report's context.
            Picker(selection: $context, label: Text("Context: ")) {
                Text("Bar Graph")
                    .tag(DeviceActivityReport.Context.barGraph)
                Text("Pie Chart")
                     .tag(DeviceActivityReport.Context.pieChart)
            }

            // A picker used to change the filter's segment interval.
            Picker(selection: $filter.segmentInterval,label: Text("Segment Interval: ")) {
                Text("Hourly")
                    .tag(DeviceActivityFilter.SegmentInterval.hourly())
                Text("Daily")
                    .tag(DeviceActivityFilter.SegmentInterval.daily(
                        during: Calendar.current.dateInterval(
                             of: .weekOfYear, for: .now
                        )!
                    ))
                Text("Weekly")
                    .tag(DeviceActivityFilter.SegmentInterval.weekly(
                        during: Calendar.current.dateInterval(
                            of: .month, for: .now
                        )!
                    ))
            }
            // ...
        }
    }
}
