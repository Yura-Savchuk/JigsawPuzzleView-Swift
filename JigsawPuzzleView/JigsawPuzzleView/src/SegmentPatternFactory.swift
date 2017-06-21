//
// Created by Игорь Трохимчук on 19.06.17.
// Copyright (c) 2017 Игорь Трохимчук. All rights reserved.
//

import UIKit

class SegmentPatternFactory {

    private let delegate: JigsawPuzzleViewDelegate

    init(_ delegate: JigsawPuzzleViewDelegate) {
        self.delegate = delegate
    }

    func createPattern(_ segments: [UIImage]) -> SegmentsPattern {
        switch segments.count {
            case 12: return SegmentsPattern12(segments, delegate)
            default: fatalError("Un supported segments count. Only 12 segment count supported.")
        }
    }

}
