//
//  ViewController.swift
//  JigsawPuzzle
//
//  Created by Игорь Трохимчук on 16.06.17.
//  Copyright © 2017 Игорь Трохимчук. All rights reserved.
//

import UIKit
import JigsawPuzzleView

let segments: [UIImage] = [
    UIImage(named: "pazzle_segment_1")!,
    UIImage(named: "pazzle_segment_2")!,
    UIImage(named: "pazzle_segment_3")!,
    UIImage(named: "pazzle_segment_4")!,
    UIImage(named: "pazzle_segment_5")!,
    UIImage(named: "pazzle_segment_6")!,
    UIImage(named: "pazzle_segment_7")!,
    UIImage(named: "pazzle_segment_8")!,
    UIImage(named: "pazzle_segment_9")!,
    UIImage(named: "pazzle_segment_10")!,
    UIImage(named: "pazzle_segment_11")!,
    UIImage(named: "pazzle_segment_12")!
];

class ViewController: UIViewController {

    @IBOutlet weak var puzzleView: JigsawPuzzleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        puzzleView.setSegments(segments)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

