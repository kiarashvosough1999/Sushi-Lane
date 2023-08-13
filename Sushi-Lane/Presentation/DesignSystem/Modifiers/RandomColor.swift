//
//  RandomColor.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/13/23.
//

import SwiftUI

extension ShapeStyle where Self == Color {
    static var randomColor: Color {
        Color(
            red: .random(in: 0...0.7),
            green: .random(in: 0...0.7),
            blue: .random(in: 0...0.7)
        )
    }
}
