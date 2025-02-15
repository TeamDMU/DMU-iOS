//
//  MealView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/31/23.
//

import SwiftUI

enum MenuType {
    case korean
    case oneDish
}

struct MealView: View {
    
    @StateObject var viewModel: MealViewModel
    
    @State private var selectedDate = Date()
    
    @State private var selectedMenuType: MenuType = .korean
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                MealTitleView()
                
                WeeklyCalendarView(selectedDate: $selectedDate, startDate: viewModel.startOfWeek(date: Date()))
                
                RestaurantInfomationView()
            
                
                Picker("메뉴 선택", selection: $selectedMenuType) {
                    Text("한식 🍚")
                        .tag(MenuType.korean)
                    
                    Text("일품 🍛")
                        .tag(MenuType.oneDish)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.bottom, 10)
                .padding(.horizontal, 75)
                
                ScrollView{
                    if viewModel.isWeekend(selectedDate) {
                        Text("⛔️ 주말은 식당을 운영하지 않아요.")
                            .font(.Medium18)
                            .foregroundColor(Color.Gray600)
                            .environment(\.sizeCategory, .large)
                            .padding(10)
                            .background(Color.Gray100)
                            .cornerRadius(10)
                    } else {
                        if selectedMenuType == .korean {
                            if let menu = viewModel.getMenuForDate(for: selectedDate) {
                                KoreanMenuView(menu: menu) // 한식 메뉴 뷰 추가
                            }
                        } else {
                            let oneMenu = viewModel.filteredOneMenu(for: selectedDate)
                            
                            Text("*해당 사진은 AI를 통해 생성된 이미지입니다.")
                                .font(.Medium12)
                                .foregroundColor(Color.Gray400)
                                .environment(\.sizeCategory, .large)
                            
                            ForEach(oneMenu) { menu in
                                ForEach(menu.items) { item in
                                    OneMenuItemView(item: item) // 일품 메뉴 뷰 추가
                                }
                            }
                        }
                    }
                }
                
                Spacer()
            }
            
            VStack {
                if viewModel.isMenuLoadingFailed {
                    VStack(alignment: .center) {
                        Text("식단을 불러오지 못했어요")
                            .font(.SemiBold20)
                            .foregroundColor(Color.Gray600)
                            .environment(\.sizeCategory, .large)
                            .padding(.bottom, 12)
                        Text("네트워크 상태를 확인한 후,\n새로고침 버튼을 눌러 페이지를 불러올 수 있어요.")
                            .font(.Medium16)
                            .foregroundColor(Color.Gray400)
                            .environment(\.sizeCategory, .large)
                            .padding(.bottom, 28)
                        CustomButton(title: "새로고침", action: {
                            viewModel.loadMenuData()
                        }, isEnabled: true)
                    }
                    .multilineTextAlignment(.center)
                } else if viewModel.isMenuLoading {
                    LoadingView(lottieFileName: "DMforU_Loading_GIF")
                        .frame(width: 100, height: 100)
                }
            }
        }
        .onAppear(perform: viewModel.loadMenuData)
    }
}

// MARK: - 금주의 식단 타이틀 뷰
struct MealTitleView: View {
    var body: some View {
        Text("금주의 식단")
            .font(.SemiBold20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(Color.Gray600)
            .environment(\.sizeCategory, .large)
            .padding(.all, 20)
            .multilineTextAlignment(.leading)
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
        let isToday = calendar.isDateInToday(date)
        
        VStack(alignment: .center) {
            Text("\(Calendar.current.component(.month, from: date))월")
                .font(.Medium12)
                .foregroundColor(calendar.isDate(date, inSameDayAs: selectedDate) ? Color.white : Color.Gray500)
                .environment(\.sizeCategory, .large)
                .frame(width: 30)
                .padding(.bottom, 10)
                .lineLimit(1)
            Text("\(Calendar.current.component(.day, from: date))")
                .font(.SemiBold16)
                .foregroundColor(calendar.isDate(date, inSameDayAs: selectedDate) ? Color.white : Color.Gray500)
                .environment(\.sizeCategory, .large)
                .frame(width: 30, height: 30, alignment: .center)
                .lineLimit(1)
            Text(weekday)
                .font(.Medium12)
                .padding(.top, 10)
                .foregroundColor(calendar.isDate(date, inSameDayAs: selectedDate) ? Color.white : Color.Gray500)
                .environment(\.sizeCategory, .large)
                .frame(width: 30)
                .lineLimit(1)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 10)
        .background(
            ZStack {
                // 오늘 날짜
                if isToday {
                    Color.gray200
                }
                // 선택된 날짜
                if calendar.isDate(date, inSameDayAs: selectedDate) {
                    Color.Blue300
                        .cornerRadius(10)
                }
            }
        )
        .cornerRadius(10)
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
            InfomationSingleView(imageName: "clock", text: "11:00 - 14:00, 16:30 - 18:00")
        }
        .padding(.vertical, 20)
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
                .environment(\.sizeCategory, .large)
        }
    }
}

// MARK: - 메뉴 정보 뷰
// 일품 메뉴
struct OneMenuItemView: View {
    var item: OneMenuItem
    
    var body: some View {
        HStack {
            Image(item.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .cornerRadius(100)
            
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.SemiBold20)
                    .foregroundColor(Color.Gray600)
                    .environment(\.sizeCategory, .large)
                    .padding(.top, 10)
                
                Text(item.englishName)
                    .font(.Regular16)
                    .foregroundColor(Color.Gray400)
                    .environment(\.sizeCategory, .large)
                    .padding(.bottom, 8)
                
                Text(item.price)
                    .font(.SemiBold16)
                    .foregroundColor(Color.Gray600)
                    .environment(\.sizeCategory, .large)
                    .padding(.bottom, 20)
                
            }
            .padding(.leading, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 20)
        
        Divider().background(Color.Gray200)
    }
}

// 한식 메뉴
struct KoreanMenuView: View {
    var menu: Menu
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text("🍽️")
                    .font(.SemiBold50)
                    .environment(\.sizeCategory, .large)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(Color.Gray100)
                    .cornerRadius(100)
                
                VStack(alignment: .leading) {
                    Text("백반")
                        .font(.SemiBold20)
                        .foregroundColor(Color.Gray600)
                        .environment(\.sizeCategory, .large)
                        .padding(.top, 10)
                    
                    Text("Baekban")
                        .font(.Regular16)
                        .foregroundColor(Color.Gray400)
                        .environment(\.sizeCategory, .large)
                        .padding(.bottom, 8)
                    
                    Text("6,000원")
                        .font(.SemiBold16)
                        .foregroundColor(Color.Gray600)
                        .environment(\.sizeCategory, .large)
                        .padding(.bottom, 12)
                    
                    Text("📋")
                        .font(.Regular16)
                        .environment(\.sizeCategory, .large)
                        .padding(.bottom, 12)
                    
                    // 메뉴가 비어있는지 확인
                    if menu.details.isEmpty {
                        Text("등록된 메뉴가 없습니다.")
                            .font(.Regular16)
                            .foregroundColor(Color.Gray500)
                            .environment(\.sizeCategory, .large)
                            .padding(.bottom, 12)
                    } else {
                        ForEach(menu.details, id: \.self) { detail in
                            Text(detail)
                                .font(.Regular16)
                                .foregroundColor(Color.Gray500)
                                .environment(\.sizeCategory, .large)
                                .padding(.bottom, 1)
                        }
                    }
                }
                .padding(.leading, 25)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.horizontal, 20)
    }
}


#Preview {
    MealView(viewModel: MealViewModel())
}
