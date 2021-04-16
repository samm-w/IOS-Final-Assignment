//
//  VaccineViewController.swift
//  Principle Author: Sam Whelan
//  Created by  on 3/22/21.
//  Description: Creates the map and responds to the users locations, and will give directions
//  so that the user can see how far it would be to arrive at a hospital or other location
//  starting from the Sheridan Oakville campus

import UIKit
import MapKit
import CoreLocation

class VaccineViewController: UIViewController, UITextFieldDelegate, MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate{
    
    //Creates an instance of the Location Manager
    let locationManager = CLLocationManager()
    //Sets the starting location to Sheridan Oakville Campus
    let initialLocation = CLLocation(latitude: 43.468992, longitude: -79.699316)
    
    //Linked to the mapview in the storyboard, displays the visual locations
    @IBOutlet var myMapView: MKMapView!
    //Linked to the location the user will enter so that it can be found
    @IBOutlet var tfLocEntered: UITextField!
    //Creates a table that will hold instructions to reach your location
    @IBOutlet var myTableView: UITableView!
    
    //The default message when the user hasn't entered a location
    var routeSteps = ["Enter a destination to see the steps"]
    
    //Returns the text field after the return key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    //Sets the distance the map can see from when it is started
    let regionRadius: CLLocationDistance = 1000
    
    //Centers the map on the inital location of where the user is starting from
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        myMapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Centers the map and creates a pin to show where the user starts, and creates an
        //annotation if the user clicks on the pin
        centerMapOnLocation(location: initialLocation)
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = initialLocation.coordinate
        dropPin.title = "Starting at Sheridan Oakville"
        self.myMapView.addAnnotation(dropPin)
        self.myMapView.selectAnnotation(dropPin, animated: true)
        
        // Do any additional setup after loading the view.
    }
    
    //After the user enters the location they want to go to, this will find the location
    //and display where it is
    @IBAction func findNewLocation(){
        //Holds the location the user entered
        let locEnteredText = tfLocEntered.text
        //Creates an instance of the geocoder
        let geocoder = CLGeocoder()
        
        //Takes in the address the user enters, and tries to find it on the map
        geocoder.geocodeAddressString(locEnteredText!, completionHandler:
                                        {(placemarks, error) -> Void in
                                            if(error != nil){
                                                print("Error", error!)
                                            }
                                            
                                            //Tries to find the location and then focus on it
                                            if let placemark = placemarks?.first{
                                                let coordinates: CLLocationCoordinate2D = placemark.location!.coordinate
                                                let newLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
                                                self.centerMapOnLocation(location: newLocation)
                                                
                                                //Creates a pin on the map and gives it an annotation
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
                                                
                                                //Holds the directions of the found location
                                                let directions = MKDirections(request: request)
                                                
                                                //Calculates the optimal route to reach the destination
                                                directions.calculate(completionHandler: {[unowned self] response, error in
                                                    
                                                    //This block draws the route and provdes the information for the tableview
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
    
    //Renders a blue line when the location is found to show in a visual sense how to get
    //to the location
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
    
    //Sets the number of rows in the table based on the number of instructions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routeSteps.count
    }
    
    //Sets the height of each row in the table
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    //Each cell in the row will show an instruction when it is visible on the screen
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


