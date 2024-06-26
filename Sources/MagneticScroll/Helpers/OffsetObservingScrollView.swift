//
//  OffsetObservingScrollView.swift
//  
//
//  Created by Demirhan Mehmet Atabey on 29.06.2023.
//

import SwiftUI
import SwiftUIIntrospect

internal struct OffsetObservingScrollView<Content: View>: View {
    var axes: Axis.Set = [.horizontal]
    var showsIndicators = true
    @Binding var offset: CGPoint
    @ViewBuilder var content: () -> Content

    private let coordinateSpaceName = UUID()

    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            PositionObservingView(
                coordinateSpace: .named(coordinateSpaceName),
                position: Binding(
                    get: { offset },
                    set: { newOffset in
                        offset = CGPoint(
    x: -newOffset.x,
    y: -newOffset.y
)
                    }
                ),
                content: content
            )
        }
        .coordinateSpace(name: coordinateSpaceName)
        .introspect(.scrollView, on: .iOS(.v14),.iOS(.v15), .iOS(.v16), .iOS(.v17)) { scrollView in
          scrollView.setValue(0.35, forKeyPath: "contentOffsetAnimationDuration")
        }
    }
}
