//
//  WeatherModel.swift
//  wanted_pre_onboarding
//
//  Created by 조성빈 on 2022/06/20.
//

import Foundation

struct WeatherModel {
    let cityName : String
    let conditionId : Int // 이미지 선택할 때 필요
    let minTemp : Float
    let currentTemp : Float
    let maxTemp : Float
    let sensibleTemp : Float
    let humidity : Int
    let windSpeed : Float
    let atmPressure : Int
}
