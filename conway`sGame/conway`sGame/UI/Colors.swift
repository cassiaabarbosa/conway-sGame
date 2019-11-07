//
//  Colors.swift
//  conway`sGame
//
//  Created by Cassia Aparecida Barbosa on 05/11/19.
//  Copyright © 2019 teamconwaysGame. All rights reserved.
//

import Foundation
import UIKit

let colors: [UIColor] = [.red, .blue, .yellow, .systemPink, .systemOrange, .systemIndigo, .brown, .cyan, .magenta, .purple, .systemTeal]

public func futureColor() -> UIColor{
     return colors[Int.random(in: 0..<colors.count)]
}
