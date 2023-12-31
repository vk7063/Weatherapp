//
//  Coordinator.swift
//  Weather
//
//  Created by akashial on 13/03/23.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}
