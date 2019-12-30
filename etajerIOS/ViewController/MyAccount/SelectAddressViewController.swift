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
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var countryTxt: UITextField!
    @IBOutlet weak var buildingTxt: UITextField!
    @IBOutlet weak var streetTxt: UITextField!
    @IBOutlet weak var areaTxt: UITextField!
    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var doneBtn: UIButton!
    
    
    let locationManager = CLLocationManager()
    
    var marker = GMSMarker()
    var cameraPosition = GMSCameraPosition()
    var address: String?
    var selectedPlace: GMSPlace?
    var currentLocation: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let address = address {
            addressLbl.text = address
            setAddressOnFildes(address: address)
        } else {
            addressLbl.text = SELECT_FORM_MAP.localized()
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
        
        doneBtn.rx
            .tap
            .bind {[unowned self] (_) in
                self.creatNewAddress()
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
    
    func setAddressOnFildes(address: String) {
        var addressArr = address.split(separator: "،")
        var area = ""
        var city = ""
        var country = ""
        
        if addressArr.count <= 1 {
            addressArr = address.split(separator: ",")
        }
        
        if addressArr.count == 3 {
            area = "--"
            city = addressArr[1].description
            country = addressArr[2].description
        }
        
        if addressArr.count == 4 {
            area = addressArr[1].description
            city = addressArr[2].description
            country = addressArr[3].description
        } else if addressArr.count == 5 {
            area = addressArr[1].description
            area = area + " -" + addressArr[2].description
            city = addressArr[3].description
            country = addressArr[4].description
        }
        
        let streetAndBuilding = addressArr[0].description
        let building = streetAndBuilding.split(separator: " ").first?.description
        let street = streetAndBuilding.split(separator: " ").dropFirst().joined(separator: " ").description
    
        if let num = Int(building ?? "--") {
            self.buildingTxt.text = "\(num)"
            self.streetTxt.text = street
        } else {
            self.buildingTxt.text = "--"
            self.streetTxt.text = streetAndBuilding
        }
        
        self.areaTxt.text = area
        self.cityTxt.text = city
        self.countryTxt.text = country
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
    
    func creatNewAddress(){
        guard let name = nameTxt.text?.trimmingCharacters(in: .whitespaces),
              let country = countryTxt.text?.trimmingCharacters(in: .whitespaces),
              let city = cityTxt.text?.trimmingCharacters(in: .whitespaces),
              let area = areaTxt.text?.trimmingCharacters(in: .whitespaces),
              let street = streetTxt.text?.trimmingCharacters(in: .whitespaces),
              let building = buildingTxt.text?.trimmingCharacters(in: .whitespaces)  else {
                self.alert(title: "", message: ALL_FIELDS_ERROR.localized(), completion: nil)
                return
        }
        
        guard let mobile = AppUtility.shared.getCurrentUser()?.mobile else { return }
        DataManager.shared.setNewAddress(name: name ,
                                         country: country,
                                         city: city,
                                         area: area,
                                         street: street,
                                         building: building,
                                         mobile: mobile) {[unowned self] (response) in
                                            switch response {
                                            case .success(let vlaue):
                                                guard let _ = vlaue as? AddressResponse else { return }
                                                self.alert(title: "", message: ADDRESS_ADDED.localized(), completion: {
                                                    self.dismiss(animated: true, completion: nil)
                                                })
                                            case .failure(_, let data):
                                                if let err = data as? ErrorModel, let msg = err.message {
                                                    self.alert(title: "", message: msg, completion: nil)
                                                } else if let errs = data as? [ErrorModel], let err = errs.first, let msg = err.message {
                                                    self.alert(title: "", message: msg, completion: nil)
                                                }
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
    
    //Handel User Tap On the map
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        mapView.clear()
        marker = GMSMarker(position: coordinate)
        marker.map = mapView
        getAddressFormCoordinate(coordinate) {[unowned self] (address) in
            self.setAddressOnFildes(address: address)
            self.address = address
            self.addressLbl.text = address
        }
    }
    
    //Handel map camera position move ( get the coordinate of screen center )
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        //Code
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
