//
//  DeviceOrientationViewModel.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 20/04/23.
//

import SwiftUI

final class DeviceOrientationViewModel: ObservableObject {
    @Published var deviceOrientation = UIDevice.current.orientation
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc private func deviceOrientationDidChange() {
        deviceOrientation = UIDevice.current.orientation
    }
    
    func setColumns() -> [GridItem] {
        if deviceOrientation.isLandscape {
            return [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        } else {
            return [GridItem(.flexible()), GridItem(.flexible())]
        }
    }
}
