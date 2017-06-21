//
//  JigsawPuzzleView.swift
//  JigsawPuzzleView
//
//  Created by Игорь Трохимчук on 16.06.17.
//  Copyright © 2017 Игорь Трохимчук. All rights reserved.
//

import UIKit
import QuartzCore

public class JigsawPuzzleView : UIView, ViewDrawing {

    private var segmentsPattern: SegmentsPattern? = nil
    private var segmentMotion: SegmentMotion? = nil
    private let delegateProxy: DelegateProxy = DelegateProxy()
    public var delegate: JigsawPuzzleViewDelegate? {
        get {
            return delegateProxy.delegate
        }
        set(newValue) {
            delegateProxy.delegate = newValue
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInitialization()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInitialization()
    }

    private func sharedInitialization() {
        self.isUserInteractionEnabled = true
    }

    public func setSegments(_ segments: Array<UIImage>!) {
        let patternFct = SegmentPatternFactory(delegateProxy)
        segmentsPattern = patternFct.createPattern(segments)
        segmentMotion = SegmentMotionImpl(segmentsPattern!, self)
    }

    func drawLayers() {
        setNeedsDisplay()
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        segmentsPattern?.draw(rect)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        self.segmentsPattern?.updateSize(Int(frame.width), Int(frame.height))
    }

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let location = getTouchLocation(touches)
        segmentMotion?.touchesBegan(location)
    }

    private func getTouchLocation(_ touches: Set<UITouch>) -> CGPoint {
        let touch = touches.first!
        return touch.location(in: self)
    }

    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let location = getTouchLocation(touches)
        segmentMotion?.touchesMoved(location)
    }

    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        let location = getTouchLocation(touches)
        segmentMotion?.touchesEnded(location)
    }

    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        let location = getTouchLocation(touches)
        segmentMotion?.touchesEnded(location)
    }

    public func blendSegments() {
        if segmentsPattern != nil {
            segmentsPattern!.blendSegments()
            drawLayers()
        }
    }

}

fileprivate class DelegateProxy: JigsawPuzzleViewDelegate {

    fileprivate var delegate: JigsawPuzzleViewDelegate? = nil

    func onAllSegmentsGathered() {
        delegate?.onAllSegmentsGathered()
    }

}
