//
//  MealView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/31/23.
//

import SwiftUI

struct MealView: View {
    
    @ObservedObject var viewModel: MealViewModel
    
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            MealTitleView()
            
            WeeklyCalendarView(selectedDate: $selectedDate, startDate: viewModel.startOfWeek(date: Date()))
            
            RestaurantInfomationView()
            
            WeeklyMenuView(selectedDate: selectedDate, viewModel: viewModel)
            
            Spacer()
        }
    }
}

// MARK: - 금주의 식단 타이틀 뷰
struct MealTitleView: View {
    var body: some View {
        Text("금주의 식단")
            .font(.SemiBold20)
            .foregroundColor(Color.Gray500)
            .padding()
    }
}

// MARK: - 금주의 캘린더 뷰
struct WeeklyCalendarView: View {
    
    @Binding var selectedDate: Date
    
    var startDate: Date
    
    var body: some View {
        HStack {
            ForEach(0..<5) { offset in
                let date = Calendar.current.date(byAdding: .day, value: offset, to: startDate)!
                WeeklyCalendarSingleDateView(selectedDate: $selectedDate, date: date)
            }
        }
    }
}

struct WeeklyCalendarSingleDateView: View {
    
    @Binding var selectedDate: Date
    
    var date: Date
    
    var body: some View {
        
        let calendar: Calendar = {
            var cal = Calendar.current
            cal.locale = Locale(identifier: "ko_KR")
            return cal
        }()
        
        let weekday = calendar.shortWeekdaySymbols[calendar.component(.weekday, from: date) - 1]
        
        VStack(alignment: .center) {
            Text("\(Calendar.current.component(.month, from: date))월")
                .font(.Medium12)
                .foregroundColor(Color.Gray500)
                .padding(.bottom, 14)
                .lineLimit(1)
            Text("\(Calendar.current.component(.day, from: date))")
                .font(.Medium16)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .foregroundColor(calendar.isDate(date, inSameDayAs: selectedDate) ? Color.white : Color.Gray500)
                .background(calendar.isDate(date, inSameDayAs: selectedDate) ? Color.Blue300 : Color.clear)
                .cornerRadius(10)
                .lineLimit(1)
            Text(weekday)
                .font(.Medium12)
                .padding(.top, 14)
                .foregroundColor(Color.Gray500)
                .lineLimit(1)
        }
        .padding(.horizontal, 20)
        .onTapGesture {
            self.selectedDate = self.date
        }
    }
}

// MARK: - 식당 정보 뷰
struct RestaurantInfomationView: View {
    
    var body: some View {
        HStack(alignment: .center){
            HStack {
                Image(systemName: "map")
                    .foregroundColor(Color.Gray400)
                Text("8호관 3층")
                    .font(.Medium14)
                    .foregroundColor(Color.Gray400)
            }
            .padding(.trailing, 20)
            
            HStack {
                Image(systemName: "clock")
                    .foregroundColor(Color.Gray400)
                Text("11:30 - 14:00, 16:30 - 18:00")
                    .font(.Medium14)
                    .foregroundColor(Color.Gray400)
            }
        }
        .padding(.top, 20)
    }
}

// MARK: - 금주의 식단(한식, 일품) 메뉴 뷰
struct WeeklyMenuView: View {
    var selectedDate: Date
    var viewModel: MealViewModel
    
    var body: some View {

        
        if viewModel.isWeekend(selectedDate){
            VStack {
                Text("⛔️ 오늘은 식당을 운영하지 않아요.")
                    .font(.Medium16)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.Blue100)
                    .foregroundColor(Color.Gray600)
                    .cornerRadius(20)
            }
            .padding(.top, 20)
        }
        else if let menu = viewModel.getMenuForDate(for: selectedDate) {
            WeeklyMenuDetailView(menu: menu)
        }
    }
}

struct WeeklyMenuDetailView: View {
    
    var menu: Menu
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    VStack(alignment: .leading) {
                        Text("🍚 한식")
                            .font(.Bold20)
                            .foregroundColor(Color.Gray500)
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 75), alignment: .leading)]) {
                            ForEach(menu.details, id: \.self) { detail in
                                Text(detail)
                                    .font(.Medium16)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.Blue100)
                                    .foregroundColor(Color.Gray600)
                                    .cornerRadius(20)
                                    .lineLimit(1)
                            }
                        }
                    }
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(15)
                    .frame(width: geometry.size.width - 40)
                    .shadow(color: Color.Blue300.opacity(0.2), radius: 8, x: 0, y: 0)
                                  
                    Spacer(minLength: 20)
                    
                    VStack(alignment: .leading) {
                        Text("🍛 일품")
                            .font(.Bold20)
                            .foregroundColor(Color.Gray500)
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 200), alignment: .leading)]) {
                            Text("😂 등록된 메뉴가 없어요.")
                                .font(.Medium16)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.Blue100)
                                .foregroundColor(Color.Gray600)
                                .cornerRadius(20)
                        }
                    }
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(15)
                    .frame(width: geometry.size.width - 40)
                    .shadow(color: Color.Blue300.opacity(0.2), radius: 15, x: 0, y: 0)
                }
                .padding(.top, 30)
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    MealView(viewModel: MealViewModel())
}
