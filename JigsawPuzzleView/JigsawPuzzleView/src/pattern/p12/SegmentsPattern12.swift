//
// Created by Игорь Трохимчук on 19.06.17.
// Copyright (c) 2017 Игорь Трохимчук. All rights reserved.
//

import UIKit

private let SEGMENT_SIZE = SegmentSize(6.0/16.0, 5.0/9.0)
private let LEDGE_PART_RATIO: Float = 1.0/6.0

private let EMPTY_INDEX = -1

class SegmentsPattern12: SegmentsPattern {

    private let segments: Segments
    private let segmentsDrawer: SegmentLayersDrawer
    private let segmentPoint = SegmentPoint12()

    private let segmCenter: SegmentCenter

    init(_ segments: [UIImage]!) {
        self.segments = Segments(segments: segments, size: SEGMENT_SIZE)
        self.segmentsDrawer = SegmentLayersDrawer(self.segments, segmentPoint)
        self.segmCenter = SegmentCenter(segmentPoint, self.segments)
    }

    //PRAGMA: SegmentsPattern

    func updateSize(_ width: Int, _ height: Int) {
        segments.updateSize(width, height)
    }

    func blendSegments() {

    }

    func draw(_ rect: CGRect) {
        segmentsDrawer.draw(rect)
    }

    //PRAGMA: SegmentMoving

    func setSegmentMovable(at position: CGPoint) {
        if !segments.isSized() { return }
        let x = Int(position.x)
        let y = Int(position.y)
        for i in 0...segments.sizedSegments.count-1 {
            let segment = segments.sizedSegments[i]
            let centerPos = segmCenter.getCenterPosition(from: segment, i)
            let centerX = centerPos.getX()
            let centerY = centerPos.getY()
            let segmentWidth = Int(segment.size!.width)
            let segmentHeight = Int(segment.size!.height)
            let ledgeSize = Int(LEDGE_PART_RATIO*Float(segmentWidth))
            let segmentAbsoluteWidth = segmentWidth - 2*ledgeSize
            let segmentAbsoluteHeight = segmentHeight - 2*ledgeSize
            let left = centerX - segmentAbsoluteWidth/2
            let top = centerY - segmentAbsoluteHeight/2
            let right = centerX + segmentAbsoluteWidth/2
            let bottom = centerY + segmentAbsoluteHeight/2
            if x >= left && x <= right && y >= top && y <= bottom {
                segment.setMotionPosition(x: x, y: y)
                break
            }
        }
    }

    func moveMovableSegment(to position: CGPoint) {
        let segment = getMovableSegment()
        if segment == nil {return}
        let segmentWidth = Int(segment!.size!.width)
        let ledgeSize = Int(LEDGE_PART_RATIO*Float(segmentWidth))
        let minX = (segmentWidth - 2*ledgeSize)/2
        let maxX = segments.getViewWidth() - minX
        let minY = (Int(segment!.size!.height) - 2*ledgeSize)/2
        let maxY = segments.getViewHeight() - minY
        var x = Int(position.x)
        var y = Int(position.y)
        if x < minX { x = minX }
        if x > maxX { x = maxX }
        if y < minY { y = minY }
        if y > maxY { y = maxY }
        segment!.setMotionPosition(x: x, y: y)
    }

    private func getMovableSegment() -> Segment? {
        for segment: Segment in segments.sizedSegments {
            if segment.isMovable() {
                return segment
            }
        }
        return nil
    }

    func updatePosition() {
        let movableSegmentIndex = getMovableSegmentIndex()
        if movableSegmentIndex == EMPTY_INDEX {return}
        let movableSegment: Segment = segments.sizedSegments[movableSegmentIndex]
        let motionPos = movableSegment.getMotionPosition()
        let distanceToVertexes = getDistanceToVertexes(from: motionPos)
        let minDistanceIndex = getMinDistanceIndex(distanceToVertexes)
        segments.swapSegments(minDistanceIndex, movableSegmentIndex)
        segments.stopMoving(movableSegment)
    }

    private func getMovableSegmentIndex() -> Int {
        let sizedSegments: [Segment] = segments.sizedSegments
        for i in 0...sizedSegments.count-1 {
            let segment = sizedSegments[i]
            if segment.isMovable() {
                return i
            }
        }
        return EMPTY_INDEX
    }

    private func getDistanceToVertexes(from position: Position) -> [Int] {
        let segmentVertexes = getAllSegmentVertexes()
        var distanceToVertexes = [Int]()
        for i in 0...segmentVertexes.count-1 {
            let vertex = segmentVertexes[i]
            let distance = getDistanceBeetwen(vertex, position)
            distanceToVertexes.append(distance)
        }
        return distanceToVertexes
    }

    private func getAllSegmentVertexes() -> [Position] {
        var vertexes = [Position]()
        let width = segments.getViewWidth()
        let height = segments.getViewHeight()
        for i in 0...11 {
            let vertex = segmentPoint.getSegmentCenterPositionAt(i+1, width, height)
            vertexes.append(vertex)
        }
        return vertexes
    }

    private func getDistanceBeetwen(_ point1: Position, _ point2: Position) -> Int {
        let x1 = point1.getX()
        let y1 = point1.getY()
        let x2 = point2.getX()
        let y2 = point2.getY()
        return Int(sqrt(Double( (x1-x2)*(x1-x2) + (y1-y2)*(y1-y2) )))
    }

    private func getMinDistanceIndex(_ distances: [Int]) -> Int {
        var minDistIndex = 0
        for i in 1...distances.count-1 {
            let distance = distances[i]
            let minDistance = distances[minDistIndex]
            if distance < minDistance {
                minDistIndex = i
            }
        }
        return minDistIndex
    }

}
