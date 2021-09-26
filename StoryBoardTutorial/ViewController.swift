//
//  ViewController.swift
//  StoryBoardTutorial
//
//  Created by 박종훈 on 2021/08/10.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UINavigationController, CLLocationManagerDelegate {
    //지도 뷰
    @IBOutlet var mapView:MKMapView!
    //위치를 관리하는 객체 생성
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy =  kCLLocationAccuracyBest //battery
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    //locations에서 location을 받고, 매니저의 업데이트를 멈춤. location을 렌더링함.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            render(location)
        }
    }
    //렌더링(지도에 좌표, 핀 등을 표시하기) 함수
    func render(_ location:CLLocation) {
        //좌표 값 객체 생성
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        //좌표 span 생성
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        //좌표 지역 객체 생성
        let region = MKCoordinateRegion(center: coordinate, span: span)
        //좌표 지역을 mapkit의 현재 표시될 지역으로 지정
        mapView.setRegion(region, animated: true)
        //핀 객체 생성
        let pin = MKPointAnnotation()
        //핀의 좌표 값을 위에 생성한 좌표 값으로 지정
        pin.coordinate = coordinate
        //핀 제목, 부제목 등
        pin.title = "I'm here"
        pin.subtitle = "There is my coordinate bro~~"
        //지도에 핀을 추가
        mapView.addAnnotation(pin)
    }
}
