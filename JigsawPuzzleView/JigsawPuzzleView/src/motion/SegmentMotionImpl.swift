//
// Created by Игорь Трохимчук on 20.06.17.
// Copyright (c) 2017 Игорь Трохимчук. All rights reserved.
//

import Foundation

class SegmentMotionImpl: SegmentMotion {

    let segmentsPattern: SegmentsPattern
    let view: ViewDrawing

    init(_ segmentsPattern: SegmentsPattern, _ view: ViewDrawing) {
        self.segmentsPattern = segmentsPattern
        self.view = view
    }

    func touchesBegan(_ position: CGPoint) {
        segmentsPattern.setSegmentMovable(at: position)
        view.drawLayers()
    }

    func touchesMoved(_ position: CGPoint) {
        segmentsPattern.moveMovableSegment(to: position)
        view.drawLayers()
    }

    func touchesEnded(_ position: CGPoint) {
        segmentsPattern.updatePosition()
        view.drawLayers()
    }


}
