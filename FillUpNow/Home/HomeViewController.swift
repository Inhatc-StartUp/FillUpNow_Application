//
//  HomeViewController.swift
//  FillUpNow
//
//  Created by 한소희 on 2023/03/25.
//

import UIKit
import CoreLocation

final class HomeViewController: UIViewController {
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    var gasStationDataList: [gasStationData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // CSV 파일의 URL 얻어오기 (주훈)
        guard let csvURL = Bundle.main.url(forResource: "data", withExtension: "csv") else {
            print("CSV file not found")
            return
        }
            
        // CSV 파일 읽어들이기 (주훈)
        parseCSVAt(url: csvURL)
    }
    // city와 일치하는 도시를 포함하는 데이터 필터링 (주훈)
    private func filterDataForCity(_ city: String) -> [gasStationData] {
        let filteredData = gasStationDataList.filter { $0.region == city }
        return filteredData
    }
}

extension HomeViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let currentLocation = locations.last else { return }
            
            // 현재 위치에서 주소로 변환 (주훈)
            geocoder.reverseGeocodeLocation(currentLocation) { (placemarks, error) in
                guard let placemark = placemarks?.first else { return }
                
                // 시 추출 (주훈)
                var city = placemark.locality ?? ""
                        if city.isEmpty {
                            // 시가 비어있는 경우 행정 구역 이름으로 시 설정
                            city = placemark.subAdministrativeArea ?? ""
                        }
                print(city)
                
                // 해당 시의 데이터 필터링 (주훈)
                let filteredData = self.filterDataForCity(city)
                print(filteredData)
        }
    }
    // csv 파일 내용을 리스트에 저장하는 함수
    private func parseCSVAt(url:URL) {
        do {
            let data = try Data(contentsOf: url)
            let dataEncoded = String(data: data, encoding: .utf8)
            if let dataArr = dataEncoded?.components(separatedBy: "\n").map({$0.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: ",")}) {

                for item in dataArr {
                    if item.count == 7 {
                        let data = gasStationData(region: item[0], shopName: item[1], address: item[2], selfFuel: item[3], premiumGasoline: item[4], gasoline: item[5], lightFuel: item[6])
                        gasStationDataList.append(data)
                    }
                }
            }
        } catch  {
            print("Error reading CSV file")
        }
    }
}
