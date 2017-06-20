//
// Created by Игорь Трохимчук on 20.06.17.
// Copyright (c) 2017 Игорь Трохимчук. All rights reserved.
//

import Foundation

class SegmentCenter {

    let positions: SegmentPoint
    let segments: Segments

    init(_ positions: SegmentPoint, _ segments: Segments) {
        self.positions = positions
        self.segments = segments
    }

    func getCenterPosition(from segment: Segment, _ orderPosition: Int) -> Position {
        if segment.centerPosition == nil {
            let width = segments.getViewWidth()
            let height = segments.getViewHeight()
            segment.centerPosition = positions.getSegmentCenterPositionAt(orderPosition + 1, width, height)
        }
        return segment.centerPosition!
    }

}
