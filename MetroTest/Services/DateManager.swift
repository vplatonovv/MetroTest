//
//  DataManager.swift
//  MetroTest
//
//  Created by Слава Платонов on 20.12.2021.
//

import Foundation
import SwiftDate

class DateManager {
    static let shared = DateManager()
    private init() {}
    
    func convertDate(from milliseconds: Int) -> String {
        // when
        let date = Date(milliseconds: milliseconds, region: .current)
        // interval between when and now
        let interval = Int(date.distance(to: Date()))
        switch milliseconds {
        case 0..<60:
            return "\(String(interval)) секунд назад"
        case 60..<3600:
            return "\(String(interval / 60)) минут назад"
        case 3600..<86400:
            return "\(String(interval / 3600)) часов назад"
        case 86400...:
            return "\(String(interval / 86400)) дней назад"
        default:
            break
        }
        return "Только что"
    }
}
