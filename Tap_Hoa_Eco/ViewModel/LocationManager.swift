//
//  LocationManager.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 16/5/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    private var geocoder = CLGeocoder()
    
    @Published var location: CLLocation? {
        didSet {
            if let location = location {
                self.latitude = location.coordinate.latitude
                self.longitude = location.coordinate.longitude
                self.getAddressFromLocation(location)
            }
        }
    }
    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0
    @Published var address: String = ""

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.location = location
        }
    }
    
    private func getAddressFromLocation(_ location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Failed to get address: \(error.localizedDescription)")
                self.address = "Unable to get address"
            } else if let placemarks = placemarks, let placemark = placemarks.first {
                let addressString = [
                    placemark.name,
                    placemark.locality,
                    placemark.administrativeArea,
                    placemark.country
                ].compactMap { $0 }.joined(separator: ", ")
                self.address = addressString
            } else {
                print("No placemarks found")
                self.address = "No address found"
            }
        }
    }
}
