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
    
    func convertDate(from milliseconds: Int) -> String? {
        // when
        let date = Date(milliseconds: milliseconds, region: .current)
        // interval between when and now
        let interval = Int(date.distance(to: Date()))
        var outputString = ""
        switch milliseconds {
        case 0..<60:
            outputString = "секунд назад"
            return String(interval) + " " + outputString
        case 60..<3600:
            outputString = "минут назад"
            return String(interval / 60) + " " + outputString
        case 3600..<86400:
            outputString = "часов назад"
            return String(interval / 3600) + " " + outputString
        case 86400...:
            outputString = "дней назад"
            return String(interval / 86400) + " " + outputString
        default:
            break
        }
        return nil
    }
}
