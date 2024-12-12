//
//  BasicService.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 12.12.2024.
//

class BasicService {
    let client: Client
    let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
}
