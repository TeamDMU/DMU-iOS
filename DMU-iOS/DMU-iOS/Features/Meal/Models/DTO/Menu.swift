//
//  Menu.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/4/24.
//

import Foundation

// MARK: - 한식
struct Menu: Identifiable {
    
    var id = UUID()
    var date: String
    var details: [String]
}

// MARK: - 일품

enum Weekday: String, CaseIterable {
    case monday = "월요일"
    case tuesday = "화요일"
    case wednesday = "수요일"
    case thursday = "목요일"
    case friday = "금요일"
}

struct OneMenuItem: Identifiable {
    var id = UUID()
    var name: String
    var englishName: String
    var price: String
    var imageName: String
}

struct OneMenu: Identifiable {
    var id = UUID()
    var items: [OneMenuItem]
    var availableDays: [Weekday]
}

let OneMenuList = [
    OneMenu(items: [
        OneMenuItem(name: "라면", englishName: "Ramen", price: "3,500원", imageName: "Ramen"),
        OneMenuItem(name: "치즈라면", englishName: "Cheese Ramen", price: "4,000원", imageName: "CheeseRamen"),
        OneMenuItem(name: "해물라면", englishName: "Seafood Ramen", price: "4,500원", imageName: "SeafoodRamen")
    ], availableDays: [.monday, .tuesday, .wednesday, .thursday, .friday]),
    
    OneMenu(items: [
        OneMenuItem(name: "돈까스", englishName: "Pork Cutlet", price: "5,000원", imageName: "Cutlet"),
        OneMenuItem(name: "치즈돈까스", englishName: "Cheese Pork Cutlet", price: "5,500원", imageName: "CheeseCutlet"),
        OneMenuItem(name: "고구마치즈돈까스", englishName: "Sweet Potato Cheese Cutlet", price: "6,000원", imageName: "SweetPotatoCheeseCutlet")
    ], availableDays: [.monday, .tuesday, .wednesday, .thursday, .friday]),
    
    OneMenu(items: [
        OneMenuItem(name: "스팸김치볶음밥", englishName: "Spam Kimchi Fried Rice", price: "4,900원", imageName: "SpamRice")
    ], availableDays: [.monday, .tuesday]),
    
    OneMenu(items: [
        OneMenuItem(name: "치킨마요덮밥", englishName: "Chicken Mayo Rice", price: "4,500원", imageName: "ChickenRice"),
        OneMenuItem(name: "불닭마요덮밥", englishName: "Buldak Mayo Rice", price: "4,500원", imageName: "BuldakRice")
    ], availableDays: [.wednesday, .thursday]),
    
    OneMenu(items: [
        OneMenuItem(name: "오므라이스", englishName: "Omelette Rice", price: "5,500원", imageName: "Omurice")
    ], availableDays: [.friday]),
]

