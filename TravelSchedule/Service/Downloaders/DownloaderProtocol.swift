//
//  DownloaderProtocol.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 28.01.2025.
//

protocol DataDownloaderProtocol {
    associatedtype Item: Sendable
    func fetchData() async throws
    func getItems() async -> [Item]
}
