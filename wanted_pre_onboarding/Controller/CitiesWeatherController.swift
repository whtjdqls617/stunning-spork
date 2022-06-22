//
//  ViewController.swift
//  wanted_pre_onboarding
//
//  Created by 조성빈 on 2022/06/20.
//

import UIKit

class CitiesWeatherController: UIViewController {

    @IBOutlet weak var citiesWeatherTableView: UITableView!
        
    var weatherManager = WeatherManager()
    
    var city : WeatherModel?
    var citiesList : [WeatherModel] = []
    
    let ImageCache = NSCache<NSString, UIImage>()
    let UserFileManager = FileManager.default
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        citiesWeatherTableView.dataSource = self
        citiesWeatherTableView.delegate = self
        
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        self.navigationItem.title = "국내날씨"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}

extension CitiesWeatherController: UITableViewDataSource {
    
    func changeCityNameToKr (_ cityName : String) -> String {
        let index = weatherManager.citiesNameForCell.firstIndex(of: cityName)
        return (weatherManager.citiesKrName[index!])
    }
    
    func makeURL(_ cityName : String) -> String {
        let urlString = "\(weatherManager.weatherURL)&q=\(cityName)"
        return urlString
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherManager.citiesNameForURL.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = citiesWeatherTableView.dequeueReusableCell(withIdentifier: "citiesCell", for: indexPath) as! CitiesWeatherTableViewCell
        let city = weatherManager.citiesNameForURL[indexPath.row]
        let requestURL = makeURL(city)
        weatherManager.getJSON(urlString: requestURL) { cityData in
            self.city = cityData
            guard let data = self.city else {return}
            // request image
            DispatchQueue.main.async { [self] in
                let image = weatherManager.imageLoader(data, cell)
                cell.weatherImageView.image = image
            }
            DispatchQueue.main.async {
                self.citiesList.append(data)
                cell.cityNameLabel.text = self.changeCityNameToKr(data.cityName)
                cell.tempLabel.text = "\(String(format: "%.1f", data.currentTemp)) °C"
                cell.humidityLabel.text = "\(String(data.humidity)) %"
            }
        }
        return cell
    }
}

extension CitiesWeatherController: UITableViewDelegate {
    func findCityData(_ cityName : String) -> WeatherModel? {
        for city in citiesList {
            if cityName == city.cityName {
                return city
            }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "detailCityViewController") as? DetailCityViewController else {return}
        let data = findCityData(weatherManager.citiesNameForCell[indexPath.row])
        nextVC.cityData = data
        nextVC.cityNameKr = changeCityNameToKr(data!.cityName)
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
