//
// Created by Игорь Трохимчук on 19.06.17.
// Copyright (c) 2017 Игорь Трохимчук. All rights reserved.
//

import UIKit

class Segments {

    let segmentsImg: [UIImage]!
    var sizedSegments: [Segment]!

    private let segmentSize: SegmentSize!

    private lazy var order: SegmentsOrder = {
        var ord = SegmentsOrder(self)
        ord.setupOrderFromInitialData()
        return ord
    }()

    private var viewWidth: Int = 0
    private var viewHeight: Int = 0

    init(segments: [UIImage]!, size: SegmentSize) {
        self.segmentsImg = segments
        self.sizedSegments = [Segment]()
        for i in 0...segments.count - 1 {
            sizedSegments.append(Segment(self.segmentsImg[i]))
        }
        self.segmentSize = size
    }

    func updateSize(_ width: Int, _ height: Int) {
        viewWidth = width
        viewHeight = height
        refreshSizedSegmentsArray()
    }

    private func refreshSizedSegmentsArray() {
        let segmWidth = Int(segmentSize.widthRatio * Float(viewWidth))
        let segmHeight = Int(segmentSize.heightRatio * Float(viewHeight))
        for i in 0...sizedSegments.count - 1 {
            let segment: Segment = sizedSegments[i]
            segment.size = CGSize(width: segmWidth, height: segmHeight)
            segment.centerPosition = nil
        }
    }

    func isSized() -> Bool {
        return viewHeight != 0 && viewWidth != 0
    }

    func getViewWidth() -> Int {
        return viewWidth
    }

    func getViewHeight() -> Int {
        return viewHeight
    }

    func swapSegments(_ index1: Int, _ index2: Int) {
        order.swapSegments(index1, index2)
    }

    func stopMoving(_ segment: Segment) {
        segment.stopMoving()
    }

}
