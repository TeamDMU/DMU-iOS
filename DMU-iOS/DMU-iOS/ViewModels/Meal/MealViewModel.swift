//
//  MealViewModel.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/4/24.
//

import Foundation

// 주간 식단을 관리하는 뷰 모델
class MealViewModel: ObservableObject {
    @Published var weeklyMenu: [Menu] = []

    // 예시 데이터를 불러오는 함수
    func loadSampleData() {
        let sampleData = [
            Menu(date: "2024.01.02", details: ["백미밥", "아귀콩나물찜", "동그랑땡전", "청포묵김무침", "배추김치", "소고기미역국"]),
            Menu(date: "2024.01.03", details: ["백미밥", "아귀콩나물찜", "동그랑땡전", "청포묵김무침", "배추김치", "소고기미역국"]),
            Menu(date: "2024.01.04", details: ["백미밥", "아귀콩나물찜", "동그랑땡전", "청포묵김무침", "배추김치", "소고기미역국"]),
            Menu(date: "2024.01.05", details: ["백미밥", "아귀콩나물찜", "동그랑땡전", "청포묵김무침", "배추김치", "소고기미역국"]),
            Menu(date: "2024.01.08", details: ["백미밥", "아귀콩나물찜", "동그랑땡전", "청포묵김무침", "배추김치", "소고기미역국"]),
            Menu(date: "2024.01.09", details: ["백미밥", "아귀콩나물찜", "동그랑땡전", "청포묵김무침", "배추김치", "소고기미역국"]),
            Menu(date: "2024.01.10", details: ["백미밥", "아귀콩나물찜", "동그랑땡전", "청포묵김무침", "배추김치", "소고기미역국"]),
            Menu(date: "2024.01.11", details: ["백미밥", "아귀콩나물찜", "동그랑땡전", "청포묵김무침", "배추김치", "소고기미역국"]),
        ]
        weeklyMenu = sampleData
    }
}
