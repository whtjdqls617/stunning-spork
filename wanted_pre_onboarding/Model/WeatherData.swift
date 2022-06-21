//
//  WeatherData.swift
//  wanted_pre_onboarding
//
//  Created by 조성빈 on 2022/06/20.
//

import Foundation

struct WeatherData : Codable {
    let name : String
    let weather : [Weather]
    let main : Main
    let wind : Wind
}

struct Weather : Codable {
    let id : Int
    let main : String
    let description : String
    let icon : String
}

struct Main : Codable {
    let temp : Float // 현재온도
    let feels_like : Float // 체감온도
    let temp_min : Float // 최저온도
    let temp_max : Float // 최대온도
    let pressure : Int // 기압
    let humidity : Int // 습도
}

struct Wind: Codable {
    let speed : Float // 풍속
}
