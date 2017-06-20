//
// Created by Игорь Трохимчук on 19.06.17.
// Copyright (c) 2017 Игорь Трохимчук. All rights reserved.
//

import QuartzCore

protocol SegmentsPattern: SegmentMoving {

    func updateSize(_ width: Int, _ height: Int)
    func blendSegments()
    func draw(_ rect: CGRect)

}
