//
// Created by Игорь Трохимчук on 19.06.17.
// Copyright (c) 2017 Игорь Трохимчук. All rights reserved.
//

import Foundation

class SegmentPoint12: SegmentPoint {

    func getSegmentCenterPositionAt(_ ordinalPosition: Int, _ width: Int, _ height: Int) -> Position {
        switch ordinalPosition {
            case 1: return Position(x: width*2/16, y: height*3/18)
            case 2: return Position(x: width*6/16, y: height*3/18)
            case 3: return Position(x: width*10/16, y: height*3/18)
            case 4: return Position(x: width*14/16, y: height*3/18)
            case 5: return Position(x: width*2/16, y: height*9/18)
            case 6: return Position(x: width*6/16, y: height*9/18)
            case 7: return Position(x: width*10/16, y: height*9/18)
            case 8: return Position(x: width*14/16, y: height*9/18)
            case 9: return Position(x: width*2/16, y: height*15/18)
            case 10: return Position(x: width*6/16, y: height*15/18)
            case 11: return Position(x: width*10/16, y: height*15/18)
            case 12: return Position(x: width*14/16, y: height*15/18)
            default: fatalError("Internal error. Un expected position.")
        }
    }

}
