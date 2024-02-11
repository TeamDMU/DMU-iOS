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
        VStack(alignment: .center) {
            MealTitleView()
            
            WeeklyCalendarView(selectedDate: $selectedDate, startDate: viewModel.startOfWeek(date: Date()))
            
            RestaurantInfomationView()
            
            WeeklyMenuView(viewModel: viewModel, selectedDate: selectedDate)
            
            Spacer()
        }
        .onAppear(perform: viewModel.loadData)
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
        .padding(.horizontal, 18)
        .onTapGesture {
            self.selectedDate = self.date
        }
    }
}

// MARK: - 식당 정보 뷰
struct RestaurantInfomationView: View {
    
    var body: some View {
        HStack(alignment: .center) {
            InfomationSingleView(imageName: "map", text: "8호관 3층")
                .padding(.trailing, 20)
            InfomationSingleView(imageName: "clock", text: "11:30 - 14:00, 16:30 - 18:00")
        }
        .padding(.top, 20)
    }
}

struct InfomationSingleView: View {
    
    var imageName: String
    var text: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(Color.Gray400)
            Text(text)
                .font(.Medium14)
                .foregroundColor(Color.Gray400)
        }
    }
}

// MARK: - 금주의 식단(한식, 일품) 메뉴 뷰
struct WeeklyMenuView: View {
    
    @ObservedObject var viewModel: MealViewModel
    
    var selectedDate: Date
    
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
        else if viewModel.getMenuForDate(for: selectedDate) != nil {
            WeeklyMenuDetailView(viewModel: viewModel, selectedDate: selectedDate)
        }
    }
}

struct WeeklyMenuDetailView: View {
    
    @ObservedObject var viewModel: MealViewModel
    
    var selectedDate: Date
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    if let menu = viewModel.getMenuForDate(for: selectedDate) {
                        MenuDetailSingleView(category: "🍚 한식", details: menu.details, width: geometry.size.width, cellWidth: 75)
                    }
                    Spacer(minLength: 20)
                    MenuDetailSingleView(category: "🍛 일품", details: [], width: geometry.size.width, cellWidth: 200)
                }
                .padding(.top, 30)
                .padding(.horizontal, 20)
            }
        }
    }
}

struct MenuDetailSingleView: View {
    
    var category: String
    var details: [String]
    var width: CGFloat
    var cellWidth: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(category)
                .font(.Bold20)
                .foregroundColor(Color.Gray500)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: cellWidth), alignment: .leading)]) {
                ForEach(details.isEmpty ? ["😂 등록된 메뉴가 없어요."] : details, id: \.self) { detail in
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
        .frame(width: width - 40)
        .shadow(color: Color.Blue300.opacity(0.2), radius: 15, x: 0, y: 0)
    }
}

#Preview {
    MealView(viewModel: MealViewModel())
}
