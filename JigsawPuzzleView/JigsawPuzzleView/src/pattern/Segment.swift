//
// Created by Игорь Трохимчук on 19.06.17.
// Copyright (c) 2017 Игорь Трохимчук. All rights reserved.
//

import UIKit

class Segment {

    var image: UIImage
    var size: CGSize?
    var centerPosition: Position?
    private var motionPosition: Position?


    init(_ image: UIImage) {
        self.image = image
        size = nil
        centerPosition = nil
        motionPosition = nil
    }

    func setMotionPosition(x: Int, y: Int) {
        if motionPosition == nil {
            motionPosition = Position(x: x, y: y)
            return
        }
        motionPosition!.moveTo(x: x, y: y)
    }

    func isMovable() -> Bool {
        return motionPosition != nil
    }

    func getMotionPosition() -> Position {
        return motionPosition!
    }

    func stopMoving() {
        motionPosition = nil
    }

}
