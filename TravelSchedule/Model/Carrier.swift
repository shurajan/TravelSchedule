//
//  Carier.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 13.01.2025.
//

import Foundation

struct Carrier: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let logo: String
    let email: String
    let phone: String
}

//MARK: - test data for development
extension Carrier {
    static let mockCarriers: [Carrier] = [
        Carrier(name: "ОАО «РЖД»", logo: "rzd", email: "i.lozgkina@rzd.ru", phone: "+7 (901) 111-11-11"),
        Carrier(name: "ОАО «ФГК»", logo: "fgk", email: "i.lozgkina@fgk.ru", phone: "+7 (902) 222-22-22"),
        Carrier(name: "ОАО «Урал логистика»", logo: "ural", email: "i.lozgkina@ural.ru", phone: "+7 (903) 333-33-33")
    ]
}
