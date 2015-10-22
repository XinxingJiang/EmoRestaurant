//
//  Constants.swift
//  EmoRestaurant
//
//  Created by Xinxing Jiang on 3/7/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import Foundation

struct UserDefault {
    static let Username = "Username"
}

struct Error {
    static let NetworkErrorCode = 100
    static let NetworkErrorMessage = "Network error"
    static let InvalidLoginParameterErrorCode = 101
    static let InvalidLoginParameterErrorMessage = "Invalid username or password"
    static let UsernameExistErrorCode = 202
    static let UsernameExistErrorMessage = "Username already exists"
    static let UnknownErrorMessage = "Unknown error"
    static let UnknownPlace = "Unknown Place"
    static let PleaseTryAgainLater = "Please try again later"
}

struct StoryBoard {
    static let GoBackToWelcomeSegueIdentifier = "Go Back to Welcome"
    static let GoBackToAccountSegueIdentifier = "Go Back to Account"
    static let SearchResult = "Search Result"
    static let BestRestaurant = "Best Restaurant"
    static let ShowARestaurant = "Show a Restaurant"
    static let EmbeddedComments = "Embedded Comments"
    static let CommentCell = "Comment Cell"
    static let WriteComment = "Write Comment"
}

struct Database {
    static let Restaurant = "Restaurant"
    static let RestaurantName = "Name"
    static let RestaurantChineseName = "ChineseName"
    static let RestaurantCategory = "Category"
    static let Feature = "Feature"
    static let ProfileImage = "ProfileImage"
    static let UserAndRestaurant = "UserANDRestaurant"
    static let Username = "UserName"
    static let Signature = "Signature"
    static let Comments = "Comments"
    static let Comment = "Comment"
    static let CommentNumber = "CommentNumber"
    static let Content = "Content"
    static let Phone = "Phone"
    static let AddressDetail = "AddressDetail"
    static let City = "City"
    static let State = "State"
    static let Zipcode = "Zipcode"
    static let Longitude = "Longitude"
    static let Latitue = "Latitude"
}

struct Stepper {
    static let MinHappiness = 1
    static let MaxHappiness = 5
    static let DefaultHappiness = 3
    static let MinWeather = 1
    static let MaxWeather = 5
    static let DefaultWeather = 3
    static let MinPeople = 1
    static let MaxPeople = 12
    static let DefaultPeople = 4
}

struct RestaurantCategory {
    static let Values = ["东北菜", "中东", "中式甜品", "其他", "北京", "台湾", "地中海", "天津", "奶茶店", "川菜", "希腊", "日本", "早茶", "烧烤", "江浙菜系", "泰国", "海鲜", "清真", "湘菜", "火锅", "干锅", "粤菜", "美国", "越南", "面包店", "韩国", "法国"]
}

struct Map {
    static let RegionDistance: CLLocationDistance = 10000
}