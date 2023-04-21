//
//  DeviceOrientationViewModel.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 20/04/23.
//

import SwiftUI

final class DeviceOrientationViewModel: ObservableObject {
    @Published var deviceOrientation = UIDevice.current.orientation
    @Published var isLandscape: Bool = false
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc private func deviceOrientationDidChange() {
        deviceOrientation = UIDevice.current.orientation
        isLandscape = deviceOrientation.isLandscape
    }
}
