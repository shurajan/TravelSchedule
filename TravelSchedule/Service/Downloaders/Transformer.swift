//
//  Transformer.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 28.01.2025.
//

protocol Transformer {
    associatedtype Input: Sendable
    associatedtype Output: Sendable
    
    func transform(_ input: Input) -> Output?
}
