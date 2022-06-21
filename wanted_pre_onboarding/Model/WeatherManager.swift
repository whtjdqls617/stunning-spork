//
//  WeatherManager.swift
//  wanted_pre_onboarding
//
//  Created by 조성빈 on 2022/06/20.
//

import Foundation

struct WeatherManager {
    
    var citiesName = ["gongju", "gwangju", "gumi", "gunsan", "daegu", "daejeon", "mokpo", "busan", "seosan", "seoul", "sokcho", "suwon", "suncheon", "ulsan", "iksan", "jeonju", "jeju", "cheonan", "cheongju", "chuncheon"]
                            
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=030afaa9b39a15483d87da4735bd6d5d&units=metric"
    
    var citiesList : [WeatherModel] = []
    
    func performRequest(urlString : String, completion: @escaping (WeatherModel) -> Void) {
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
            
            let weather = WeatherModel.init(cityName: cityName, conditionId: conditionId, minTemp: minTemp, currentTemp: currentTemp, maxTemp: maxTemp, sensibleTemp: sensibleTemp, humidity: humidity, windSpeed: windSpeed, atmPressure: atmPressure)
            return weather
        } catch {
            print(error)
            return nil
        }
    }
}
