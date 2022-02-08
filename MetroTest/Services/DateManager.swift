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
    
    func calculateTime(date: Date) -> String {
        date.toRelative(style: RelativeFormatter.defaultStyle(), locale: Locales.russian)
    }
}
