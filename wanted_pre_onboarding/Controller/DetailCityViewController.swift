//
//  DetailCityViewController.swift
//  wanted_pre_onboarding
//
//  Created by 조성빈 on 2022/06/20.
//

import UIKit

class DetailCityViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var sensibleTempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var atmPressureLabel: UILabel!
    
    var cityData : WeatherModel?
    var cityNameKr : String = ""
    var weatherManager = WeatherManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        navigationController?.navigationBar.tintColor = .white
        self.navigationItem.title = cityNameKr
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    func initView() {
//        cityNameLabel.text = cityNameKr
        weatherImageView.image = weatherManager.imageLoader(cityData!)
        weatherDescriptionLabel.text = cityData?.descriptionKr
        minTempLabel.text = String(format: "%.1f", cityData?.minTemp ?? 0.0)
        currentTempLabel.text = String(format: "%.1f", cityData?.currentTemp ?? 0.0)
        maxTempLabel.text = String(format: "%.1f", cityData?.maxTemp ?? 0.0)
        sensibleTempLabel.text = String(format: "%.1f", cityData?.sensibleTemp ?? 0.0)
        humidityLabel.text = "\(String(cityData?.humidity ?? 0))%"
        windSpeedLabel.text = "\(String(format: "%.1f", cityData?.windSpeed ?? 0.0))ms"
        atmPressureLabel.text = "\(String(cityData?.atmPressure ?? 0))apm"
        
    }
}
