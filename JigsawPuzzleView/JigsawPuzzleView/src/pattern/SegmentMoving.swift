//
// Created by Игорь Трохимчук on 20.06.17.
// Copyright (c) 2017 Игорь Трохимчук. All rights reserved.
//

import Foundation

protocol SegmentMoving {

    func setSegmentMovable(at position: CGPoint)
    func moveMovableSegment(to position: CGPoint)
    func updatePosition()

}
