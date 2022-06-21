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
    
    var citiesList : [WeatherModel] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        citiesWeatherTableView.dataSource = self
        citiesWeatherTableView.delegate = self
    }
    
    func getCitiesWeatherInfo() {
        for city in weatherManager.citiesName {
            let urlString = "\(weatherManager.weatherURL)&q=\(city)"
            weatherManager.performRequest(urlString: urlString){ data in
                self.citiesList.append(data)
            }
        }
    }
}

extension CitiesWeatherController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherManager.citiesName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        getCitiesWeatherInfo()
        let cell = citiesWeatherTableView.dequeueReusableCell(withIdentifier: "citiesCell", for: indexPath) as! CitiesWeatherTableViewCell
//        cell.weatherImageView.image = UIImage(named: countryList![indexPath.row].korean_name)
//        cell.countryNameLabel.text = countryList![indexPath.row].korean_name
//        cell.cityNameLabel.text = citiesList[indexPath.row].cityName
        print(citiesList)
        return cell
    }
}

extension CitiesWeatherController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "detailCityViewController") as? DetailCityViewController else {return}
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
