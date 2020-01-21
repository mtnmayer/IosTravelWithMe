//
//  PostInfoViewController.swift
//  TravelMe
//
//  Created by admin on 13/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class PostInfoViewController: UIViewController, CLLocationManagerDelegate {
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "fbdfb29da93e069af6ba89ee6805362e"
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    //@IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarImg: UIImageView!
    
    let locationManager = CLLocationManager()
    var post:Post?
    var weatherDataModel = Model.instance.weatherDataModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //  cheek this
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        titleLabel.text = post?.title
        placeLabel.text = post?.place
        descriptionLabel.text = post?.description
        avatarImg.image = UIImage(named: "avatar")
        if(post?.avatar != ""){
            avatarImg.kf.setImage(with: URL(string: post!.avatar))
        }
        
        let params: [String : String] = ["q" : placeLabel.text!, "appid" : APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: params)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func configureTextView(){
        
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        let location = locations[locations.count - 1]
//        if location.horizontalAccuracy > 0{
//            locationManager.stopUpdatingLocation()
//            locationManager.delegate = nil
//
//            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
//
//            let latitude = String(location.coordinate.latitude)
//            let longitude = String(location.coordinate.longitude)
//
//            let params: [String: String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
//
//            getWeatherData(url: WEATHER_URL, parameters: params)
//        }
//    }
    
    
    
    func getWeatherData(url: String, parameters: [String : String]){
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            if response.result.isSuccess{
               print("Success! Got the weather data")
                let weatherJSON : JSON = JSON(response.result.value!)
                self.updateWeatherData(json: weatherJSON)
            }
            else{
                print("Error \(response.result.error)")
                //self.cityLabel.text = "Connection Issues"
            }
        }
    }
    
    func updateWeatherData(json :JSON){
        
        if let tempResult = json["main"]["temp"].double{
        
        weatherDataModel.temperature = Int(tempResult - 273.15)
        weatherDataModel.city = json["name"].stringValue
        weatherDataModel.condition = json["weather"][0]["id"].intValue
        
        weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            
            updateUIWithWeatherData()
        }
        else{
            print("Weather Unavailable")
        }
    }
    
  func updateUIWithWeatherData(){
        //cityLabel.text = weatherDataModel.city
        temperatureLabel.text = "\(weatherDataModel.temperature)°"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        // PRINT TO LABEL THE ERROR
    }
}
