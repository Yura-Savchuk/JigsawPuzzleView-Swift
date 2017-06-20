//
// Created by Игорь Трохимчук on 19.06.17.
// Copyright (c) 2017 Игорь Трохимчук. All rights reserved.
//

import Foundation

protocol SegmentPoint {

    func getSegmentCenterPositionAt(_ ordinalPosition: Int, _ width: Int, _ height: Int) -> Position

}
