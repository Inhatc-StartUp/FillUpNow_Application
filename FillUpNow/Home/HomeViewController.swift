//
//  HomeViewController.swift
//  FillUpNow
//
//  Created by 한소희 on 2023/03/25.
//

import UIKit
import SnapKit
import CoreLocation
import GoogleMaps
import Alamofire


final class HomeViewController: UIViewController {
    private let locationManager = CLLocationManager()
    private var myLocation = CLLocation()
    private var mapView: GMSMapView!
    private var myCity: String!
    private var latitudes: [Double] = []
    private var longitudes: [Double] = []
    private var gasStoreNumbers: [Int] = []
    private var gasStoreNames: [String] = []

    
    override func loadView() {
        mapView = GMSMapView()
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        move(at: locationManager.location?.coordinate)
        
        if (myLocation.coordinate.latitude != 0.0 && myLocation.coordinate.longitude != 0.0) {
            convertToAddress(currentLocation: myLocation)
        }
    }
    
}

// MARK: -HomeViewController Method
extension HomeViewController {
    private func move(at coordinate: CLLocationCoordinate2D?) {
        guard let coordinate = coordinate else { return }
        
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 15.0)
        
        self.mapView.camera = camera
        self.mapView.settings.myLocationButton = true
    }
    
    private func convertToAddress(currentLocation: CLLocation) {
        let taskGroup = DispatchGroup()
        
        taskGroup.enter()
        
        GMSGeocoder().reverseGeocodeCoordinate(currentLocation.coordinate) { [weak self] (placemarks, error) in
            guard let placemark = placemarks?.firstResult() else { return }
            
            self?.myCity = placemark.administrativeArea ?? ""
            
            if self?.myCity == nil {
                self?.myCity = placemark.subLocality ?? ""
            }
            
            if self?.myCity != nil {
                taskGroup.leave()
            }
        }
        
        taskGroup.notify(queue: .main) {
            guard let myCity = self.myCity else {return}
            self.getGasStoreInformation(myCity: myCity)
        }
        
    }
    
    private func getGasStoreInformation(myCity: String) {
        let taskGroup = DispatchGroup()
        let url = Access.getCityNameURL
        let queryString: Parameters = ["city": myCity]
        
        taskGroup.enter()
        
        AF.request(url,
                   method: .get,
                   parameters: queryString,
                   encoding: URLEncoding.queryString).validate(statusCode: 200..<400).responseDecodable(of: GasStation.self) {
            response in
            switch response.result {
            case .success(let res):
                do {
                    let gasStation = res.gasStations
                    
                    for index in 0...(gasStation.count-1) {
                        self.gasStoreNumbers.append(gasStation[index].number)
                        self.gasStoreNames.append(gasStation[index].name)
                        self.latitudes.append(gasStation[index].latitude)
                        self.longitudes.append(gasStation[index].longitude)
                    }
                    
                    if self.gasStoreNumbers[gasStation.count-1] != 0 {
                        taskGroup.leave()
                    }
                    
                } catch (let err) {
                    print("error: \(err.localizedDescription)")
                }
                
            case .failure(let err):
                print("error: \(err.localizedDescription)")
            }
        }
        
        taskGroup.notify(queue: .main) {
            self.makeMarker(lan: self.latitudes, lon: self.longitudes, name: self.gasStoreNames)
        }
    }
    
    private func makeMarker(lan: [Double], lon: [Double], name: [String]) {
        for index in 0...(lan.count - 1) {
            let marker = GMSMarker()
            let position = CLLocationCoordinate2D(latitude: lan[index], longitude: lon[index])
            let title = name[index]

            marker.position = position
            marker.title = title
            marker.map = mapView
        }
    }
    
}

// MARK: CLLocationManager, GMSMapViewDelegate Delegate
extension HomeViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            self.myLocation = currentLocation
            self.locationManager.stopUpdatingLocation()
        } else {
            print("위치 로딩 중")
            return
        }
    }
}


extension HomeViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let viewController = GasInformationViewController()
        present(viewController, animated: true)
        
        return true
    }
}

