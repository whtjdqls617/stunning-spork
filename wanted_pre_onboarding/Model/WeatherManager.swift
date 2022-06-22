//
//  WeatherManager.swift
//  wanted_pre_onboarding
//
//  Created by 조성빈 on 2022/06/20.
//

import Foundation
import UIKit

struct WeatherManager {
    
    var citiesNameForURL = ["Gongju", "Gwangju", "Gumi", "Gunsan", "Daegu", "Daejeon", "Mokpo", "Busan", "Seosan", "Seoul", "Sokcho", "Suwon-si", "Suncheon", "Ulsan", "Iksan", "Jeonju", "Jeju", "Cheonan", "Cheongju-si", "Chuncheon"]
    
    var citiesNameForCell = ["Gongju", "Gwangju", "Gumi", "Gunsan", "Daegu", "Daejeon", "Mokpo", "Busan", "Seosan City", "Seoul", "Sokcho", "Suwon-si", "Suncheon", "Ulsan", "Iksan", "Jeonju", "Jeju City", "Cheonan", "Cheongju-si", "Chuncheon"]
    
    var citiesKrName = ["공주", "광주", "구미", "군산", "대구", "대전", "목포", "부산", "서산", "서울", "속초", "수원", "순천", "울산", "익산", "전주", "제주", "천안", "청주", "춘천"]
                            
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=030afaa9b39a15483d87da4735bd6d5d&units=metric"
    
    let ImageCache = NSCache<NSString, UIImage>()
    let UserFileManager = FileManager.default
        
    func getJSON(urlString : String, completion: @escaping (WeatherModel) -> Void) {
        guard let url = URL(string: urlString) else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            if let safeData = data {
                if let weather = self.parseJSON(safeData) {
                    completion(weather)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(_ weatherData : Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let cityName = decodedData.name
            let conditionId = decodedData.weather[0].id
            let minTemp = decodedData.main.temp_min
            let currentTemp = decodedData.main.temp
            let maxTemp = decodedData.main.temp_max
            let sensibleTemp = decodedData.main.feels_like
            let humidity = decodedData.main.humidity
            let windSpeed = decodedData.wind.speed
            let atmPressure = decodedData.main.pressure
            let icon = decodedData.weather[0].icon
            let description = decodedData.weather[0].description
            
            let weather = WeatherModel.init(cityName: cityName, conditionId: conditionId, minTemp: minTemp, currentTemp: currentTemp, maxTemp: maxTemp, sensibleTemp: sensibleTemp, humidity: humidity, windSpeed: windSpeed, atmPressure: atmPressure, icon: icon, description: description)
            return weather
        } catch {
            print(error)
            return nil
        }
    }
    
    func imageLoader(_ data : WeatherModel, _ cell : CitiesWeatherTableViewCell) -> UIImage? {
        guard let requestImgURL = URL(string: "http://openweathermap.org/img/wn/\(data.icon)@2x.png") else {return nil}
        guard let cachesDir = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else {return nil}
        var filePath = URL(fileURLWithPath: cachesDir)
        filePath.appendPathComponent(requestImgURL.lastPathComponent)
        
        var imageData : Data?
        
        if UserFileManager.fileExists(atPath: filePath.path) {
            if let cacheImage = ImageCache.object(forKey: filePath.lastPathComponent as NSString) {
                cell.weatherImageView.image = cacheImage
            }
            imageData = try? Data(contentsOf: filePath)
        } else {
            imageData = try? Data(contentsOf: requestImgURL)
        }
        let image = UIImage(data: imageData!)
        ImageCache.setObject(image!, forKey: filePath.lastPathComponent as NSString)
        UserFileManager.createFile(atPath: filePath.path, contents: image!.pngData(), attributes: nil)
        return image
    }
    
    func imageLoader(_ data : WeatherModel) -> UIImage? {
        guard let requestImgURL = URL(string: "http://openweathermap.org/img/wn/\(data.icon)@2x.png") else {return nil}
        guard let cachesDir = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else {return nil}
        var filePath = URL(fileURLWithPath: cachesDir)
        filePath.appendPathComponent(requestImgURL.lastPathComponent)
        
        var imageData : Data?
        
        if UserFileManager.fileExists(atPath: filePath.path) {
            imageData = try? Data(contentsOf: filePath)
        } else {
            imageData = try? Data(contentsOf: requestImgURL)
        }
        let image = UIImage(data: imageData!)
        ImageCache.setObject(image!, forKey: filePath.lastPathComponent as NSString)
        UserFileManager.createFile(atPath: filePath.path, contents: image!.pngData(), attributes: nil)
        return image
    }
}
