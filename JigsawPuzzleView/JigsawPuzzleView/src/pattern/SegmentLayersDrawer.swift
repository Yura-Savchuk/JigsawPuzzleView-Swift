//
// Created by Игорь Трохимчук on 19.06.17.
// Copyright (c) 2017 Игорь Трохимчук. All rights reserved.
//

import QuartzCore

class SegmentLayersDrawer {

    private let segments: Segments
    private let positions: SegmentPoint
    private let segmCenter: SegmentCenter

    init(_ segments: Segments, _ positions: SegmentPoint) {
        self.segments = segments
        self.positions = positions
        self.segmCenter = SegmentCenter(positions, segments)
    }

    func draw(_ rect: CGRect) {
        if !self.segments.isSized() {
            updateSegmentsSize(rect)
        }
        var movableSegment: Segment? = nil
        let sizedSegments: [Segment] = self.segments.sizedSegments
        for i in 0...sizedSegments.count-1 {
            let segment = sizedSegments[i]
            if segment.isMovable() {
                movableSegment = segment
            } else {
                drawSegment(segment, i)
            }
        }
        if movableSegment != nil {
            drawMovableSegment(movableSegment!)
        }
    }

    private func updateSegmentsSize(_ frame: CGRect) {
        let fWidth = Int(frame.width)
        let fHeight = Int(frame.height)
        segments.updateSize(fWidth, fHeight)
    }

    private func drawSegment(_ segment: Segment, _ orderPosition: Int) {
        let centerPosition = segmCenter.getCenterPosition(from: segment, orderPosition)
        drawSegment(segment, centerPosition)
    }

    private func drawSegment(_ segment: Segment, _ position: Position) {
        let segmentSize = segment.size!
        let x = CGFloat(position.getX()) - (segmentSize.width/2)
        let y = CGFloat(position.getY()) - (segmentSize.height/2)
        let frame = CGRect(x: x, y: y, width: segmentSize.width, height: segmentSize.height)
        segment.image.draw(in: frame)
    }

    private func drawMovableSegment(_ segment: Segment) {
        if !segment.isMovable() {
            fatalError("Internal error.")
        }
        drawSegment(segment, segment.getMotionPosition())
    }

}
