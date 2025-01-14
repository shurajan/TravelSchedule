//
//  RouteFinderProtocol.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 14.01.2025.
//
import SwiftUI

protocol RouteFinderProtocol {
    func findRoute(from codeFrom: String, to codeTo: String) ->[Route]
}
