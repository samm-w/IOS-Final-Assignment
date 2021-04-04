//
//  VaccineViewController.swift
//  IOS-Final-Assignment
//
//  Created by  on 3/22/21.
//

import UIKit
import MapKit
import CoreLocation

class VaccineViewController: UIViewController, UITextFieldDelegate, MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate{
    
    let locationManager = CLLocationManager()
    let initialLocation = CLLocation(latitude: 43.468992, longitude: -79.699316)
    
    @IBOutlet var myMapView: MKMapView!
    @IBOutlet var tfLocEntered: UITextField!
    @IBOutlet var myTableView: UITableView!
    
    var routeSteps = ["Enter a destination to see the steps"]
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        myMapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerMapOnLocation(location: initialLocation)
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = initialLocation.coordinate
        dropPin.title = "Starting at Sheridan Oakville"
        self.myMapView.addAnnotation(dropPin)
        self.myMapView.selectAnnotation(dropPin, animated: true)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func findNewLocation(){
        let locEnteredText = tfLocEntered.text
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(locEnteredText!, completionHandler:
                                        {(placemarks, error) -> Void in
                                            if(error != nil){
                                                print("Error", error!)
                                            }
                                            
                                            if let placemark = placemarks?.first{
                                                let coordinates: CLLocationCoordinate2D = placemark.location!.coordinate
                                                let newLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
                                                self.centerMapOnLocation(location: newLocation)
                                                let dropPin = MKPointAnnotation()
                                                dropPin.coordinate = coordinates
                                                dropPin.title = placemark.name
                                                self.myMapView.addAnnotation(dropPin)
                                                self.myMapView.selectAnnotation(dropPin, animated: true)
                                                
                                                let request = MKDirections.Request()
                                                request.source = MKMapItem(placemark: MKPlacemark(coordinate: self.initialLocation.coordinate, addressDictionary: nil))
                                                request.destination = MKMapItem(placemark: MKPlacemark(coordinate: coordinates, addressDictionary: nil))
                                                
                                                request.requestsAlternateRoutes = false
                                                request.transportType = .automobile
                                                
                                                let directions = MKDirections(request: request)
                                                
                                                directions.calculate(completionHandler: {[unowned self] response, error in
                                                    
                                                    for route in (response?.routes)!{
                                                        
                                                        self.myMapView.addOverlay(route.polyline,level: MKOverlayLevel.aboveRoads)
                                                        
                                                        self.myMapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                                                        
                                                        self.routeSteps.removeAll()
                                                        for step in route.steps{
                                                            self.routeSteps.append(step.instructions)
                                                            self.myTableView.reloadData()
                                                        }
                                                        
                                                        
                                                    }
                                                    
                                                })
                                                
                                                
                                            }
                                            
                                        }
                                      
                                      
                     )
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is MKPolyline{
            
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.blue
            renderer.fillColor = UIColor.blue
            renderer.lineWidth = 5.0
            return renderer
            
        }
        return MKOverlayRenderer()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routeSteps.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        
        tableCell.textLabel?.text = routeSteps[indexPath.row]
        return tableCell
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


