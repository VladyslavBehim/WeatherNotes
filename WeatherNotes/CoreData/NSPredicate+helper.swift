//
//  NSPredicate+helper.swift
//  WeatherNotes
//
//  Created by Vladyslav Behim on 12.01.2026.
//

import Foundation

extension NSPredicate{
    static let all = NSPredicate(format: "TRUEPREDICATE")
    static let none = NSPredicate(format: "FALSEPREDICATE")
}
