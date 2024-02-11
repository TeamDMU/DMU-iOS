//
//  Menu.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/4/24.
//

import Foundation

struct Menu: Identifiable {
    
    var id = UUID()
    var date: String
    var details: [String]
}

let sampleMenu = [
    Menu(date: "2024-02-05", details: ["없음"]),
    Menu(date: "2024-02-06", details: ["백미밥","제육볶음","타코야끼","양상추발사믹샐러드","배추김치","부대찌개"]),
    Menu(date: "2024-02-07", details: ["없음"]),
    Menu(date: "2024-02-08", details: ["없음"]),
    Menu(date: "2024-02-09", details: ["없음"]),
    Menu(date: "2024-02-10", details: ["없음"]),
    Menu(date: "2024-02-11", details: ["백미밥","제육볶음","타코야끼","양상추발사믹샐러드","배추김치","부대찌개"]),
    Menu(date: "2024-02-14", details: ["없음"]),
    Menu(date: "2024-02-15", details: ["없음"]),
    Menu(date: "2024-02-16", details: ["없음"]),
]
