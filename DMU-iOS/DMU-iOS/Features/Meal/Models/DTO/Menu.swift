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
        OneMenuItem(name: "치즈 라면", englishName: "Cheese Ramen", price: "4,000원", imageName: "CheeseRamen"),
        OneMenuItem(name: "해물짬뽕 라면", englishName: "Seafood Ramen", price: "4,500원", imageName: "SeafoodRamen"),
        OneMenuItem(name: "짜파게티", englishName: "Chapagetti", price: "3,500원", imageName: "Chapagetti"),
        OneMenuItem(name: "짜계치", englishName: "Cheese Egg Chapagetti", price: "4,000원", imageName: "Chapagetti"),
        OneMenuItem(name: "불닭볶음면", englishName: "Buldak", price: "3,500원", imageName: "BuldakRamen"),
        OneMenuItem(name: "까르보 불닭볶음면", englishName: "Carbonara Buldak", price: "3,800원", imageName: "BuldakRamen"),
        OneMenuItem(name: "치즈 불닭볶음면", englishName: "Cheese Buldak", price: "4,000원", imageName: "BuldakRamen")
    ], availableDays: [.monday, .tuesday, .wednesday, .thursday, .friday]),
    
    OneMenu(items: [
        OneMenuItem(name: "돈까스", englishName: "Pork Cutlet", price: "5,000원", imageName: "Cutlet"),
        OneMenuItem(name: "치즈돈까스", englishName: "Cheese Pork Cutlet", price: "5,500원", imageName: "CheeseCutlet"),
        OneMenuItem(name: "고구마치즈돈까스", englishName: "Sweet Potato Cheese Cutlet", price: "6,000원", imageName: "SweetPotatoCheeseCutlet"),
        OneMenuItem(name: "수제 왕 돈까스", englishName: "Homemade King Pork Cutlet", price: "6,000원", imageName: "KingCutlet"),
        OneMenuItem(name: "통가슴살 치킨까스", englishName: "Chicken Cutlet", price: "5,200원", imageName: "ChickenCutlet")
    ], availableDays: [.monday, .tuesday, .wednesday, .thursday, .friday]),
    
    OneMenu(items: [
        OneMenuItem(name: "스팸 김치 볶음밥", englishName: "Spam Kimchi Fried Rice", price: "4,900원", imageName: "SpamRice")
    ], availableDays: [.monday, .tuesday]),
    
    OneMenu(items: [
        OneMenuItem(name: "치킨 마요 덮밥", englishName: "Chicken Mayo Rice", price: "4,900원", imageName: "ChickenRice"),
        OneMenuItem(name: "불닭 마요 덮밥", englishName: "Buldak Mayo Rice", price: "4,900원", imageName: "BuldakRice")
    ], availableDays: [.wednesday]),
    
    OneMenu(items: [
        OneMenuItem(name: "삼겹살 덮밥", englishName: "Pork Belly Rice", price: "5,500원", imageName: "PorkBellyRice")
    ], availableDays: [.thursday]),
    
    OneMenu(items: [
        OneMenuItem(name: "장조림 버터 비빔밥", englishName: "Bibimbap with Soy Sauce Braised Beef", price: "4,500원", imageName: "Bibimbap")
    ], availableDays: [.friday]),
]

