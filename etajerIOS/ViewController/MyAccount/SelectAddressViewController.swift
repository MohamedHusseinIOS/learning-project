//
//  SelectAddressViewController.swift
//  etajerIOS
//
//  Created by mohamed on 8/19/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxCocoa
import GoogleMaps
import GooglePlaces

class SelectAddressViewController: BaseViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var searchTxt: UITextField!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()
    
    var marker = GMSMarker()
    var cameraPosition = GMSCameraPosition()
    var address: String?
    var selectedPlace: GMSPlace?
    var currentLocation: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if address != nil {
            addressLbl.text = address
        }
        
    }
    
    override func configureUI() {
        super.configureUI()
        
        setupLocationManager()
        
//        searchTxt.rx
//            .controlEvent(.editingDidBegin)
//            .bind {[unowned self] (_) in
//                self.configureAutocomplete()
//        }.disposed(by: bag)
        
        if AppUtility.shared.currentLang == .ar {
            backImg.image = #imageLiteral(resourceName: "white-back-ar")
        } else {
            backImg.image = #imageLiteral(resourceName: "white-back-en")
        }
        
        backBtn.rx
            .tap
            .bind {[unowned self] (_) in
                self.navigationController?.dismiss(animated: true, completion: nil)
            }.disposed(by: bag)
    }
    
    func setupLocationManager(){
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func configureMapView(coordinate: CLLocationCoordinate2D?){
        let camera = GMSCameraPosition.camera(withLatitude: coordinate?.latitude ?? 0.0,
                                              longitude: coordinate?.longitude ?? 0.0, zoom: 15.0)
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.delegate = self
        self.mapView.animate(to: camera)
    }
    
    func changePositionTo(coordinate: CLLocationCoordinate2D){
        let camera = GMSCameraPosition(latitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 15.0)
        mapView.animate(to: camera)
    }
    
    func configureAutocomplete() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
            UInt(GMSPlaceField.placeID.rawValue))!
        autocompleteController.placeFields = fields
        
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .geocode
        autocompleteController.autocompleteFilter = filter
        
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }
    
    func getAddressFormCoordinate(_ coordinate: CLLocationCoordinate2D, selectedAdd: @escaping ((String)->Void)) {
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) {[unowned self] (response, error) in
            if let address =  response?.firstResult(), let lines = address.lines {
                let selectedAddress = lines.joined(separator: "\n")
                selectedAdd(selectedAddress)
            } else if let err = error {
                self.alert(title: "", message: err.localizedDescription, completion: nil)
            }
        }
    }

}

extension SelectAddressViewController: CLLocationManagerDelegate {
    // location Manager Authorization
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
    // location Did changed
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        self.configureMapView(coordinate: location?.coordinate)
        locationManager.stopUpdatingLocation()
    }
}

extension SelectAddressViewController: GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        mapView.clear()
        marker = GMSMarker(position: coordinate)
        marker.map = mapView
        getAddressFormCoordinate(coordinate) { (address) in
            self.address = address
            self.addressLbl.text = address
        }
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//        let coordinate = position.target
//        getAddressFormCoordinate(coordinate) { (address) in
//            self.address = address
//            self.addressLbl.text = address
//        }
    }
}

extension SelectAddressViewController: GMSAutocompleteViewControllerDelegate{
    // Hanble Error
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("[didFailAutocompleteWithError]\(error)")
    }
    
    // Handle Cancel
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didSelect prediction: GMSAutocompletePrediction) -> Bool {
        return true
    }
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        selectedPlace = place
        changePositionTo(coordinate: place.coordinate)
        dismiss(animated: true, completion: nil)
    }
}
