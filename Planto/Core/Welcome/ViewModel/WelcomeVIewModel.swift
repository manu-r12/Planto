//
//  WelcomeVIewModel.swift
//  Planto
//
//  Created by Manu on 2024-01-10.
//

import Foundation


class WelcomeVIewModel: ObservableObject {
    @Published var isClosed = false
    
    static let shared  = WelcomeVIewModel()
    
    func closeTheView() {
        isClosed = true
    }
}
