//
//  RouteFinderService.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 14.01.2025.
//

final class RouteFinderService: RouteFinderProtocol {
    static let shared: RouteFinderProtocol = RouteFinderService()
    
    private let routes = Route.mockRoutes
    
    private init(){}
    
    func findRoute(from codeFrom: String, to codeTo: String)->[Route] {
        //TODO: - get rid off mock logic for finder
        if codeFrom == "MOW001" && codeTo == "SPB001" {
            return Array(routes[0...4])
        }
        
        if codeFrom == "MOW002" && codeTo == "SOC001" {
            return Array(routes[5...6])
        }
        
        return []
    }
    
    
}
