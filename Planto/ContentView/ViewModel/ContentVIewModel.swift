//
//  ContentVIewModel.swift
//  Planto
//
//  Created by Manu on 2024-01-10.
//

import Foundation
import Combine

class ContentVIewModel: ObservableObject {
    @Published var isClosed = false
    private var cancellable = Set<AnyCancellable>()
    
    init(){
        setUpSubsciber()
    }
    
    func setUpSubsciber() {
        WelcomeVIewModel.shared.$isClosed.sink { bool in
            self.isClosed = bool
        }.store(in: &cancellable)
    }
}
