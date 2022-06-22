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
    let icon : String
    let description : String
    
    var descriptionKr : String {
        switch description {
        case "clear sky":
            return "맑음"
        case "few clouds":
            return "구름 조금"
        case "scattered clouds":
            return "흐림"
        case "broken clouds":
            return "적란운"
        case "shower rain":
            return "약간의 비"
        case "rain":
            return "비"
        case "thunderstorm":
            return "뇌우"
        case "snow":
            return "눈"
        case "mist":
            return "안개"
        default:
            return "맑음"
        }
    }
}
