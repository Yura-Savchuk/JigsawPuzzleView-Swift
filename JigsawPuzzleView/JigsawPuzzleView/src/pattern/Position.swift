//
// Created by Игорь Трохимчук on 19.06.17.
// Copyright (c) 2017 Игорь Трохимчук. All rights reserved.
//

import Foundation

class Position {

    private var x: Int
    private var y: Int

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    func getX() -> Int {
        return self.x
    }

    func getY() -> Int {
        return self.y
    }

    func moveTo(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

}
