//
//  MealView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/31/23.
//

import SwiftUI

struct MealView: View {
    @ObservedObject var viewModel: MealViewModel = MealViewModel()
    
    let today = Date()
    let calendar = Calendar.current
    
    var body: some View {
        VStack {
            Text("금주의 식단")
                .font(.SemiBold20)
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(.gray500)
                .padding(.horizontal, 20)
            
            ScrollView {
                VStack(alignment: .center, spacing: 0) {
                    ForEach(viewModel.weeklyMenu.filter { isDateInThisWeek($0.date) }) { menu in
                        VStack(alignment: .center, spacing: 0) {
                            HStack {
                                Spacer(minLength: 20)
                                Text(formatDate(menu.date))
                                    .font(.SemiBold16)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    .background(.blue100)
                                    .foregroundColor(.gray500)
                                    .cornerRadius(30)
                                Spacer(minLength: 20)
                            }
                            
                            Text(menu.details.joined(separator: ", "))
                                .font(.SemiBold16)
                                .foregroundColor(.gray500)
                                .padding(.top, 8)
                                .padding(.bottom, 20)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .padding(.horizontal, 20)
                        .background(Color.clear)
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadSampleData()
        }
    }

    func formatDate(_ dateString: String) -> String {
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy.MM.dd"
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "yyyy년 MM월 dd일"
            
            if let date = dateFormatterGet.date(from: dateString) {
                return dateFormatterPrint.string(from: date)
            } else {
                return dateString
            }
        }
    
    func isDateInThisWeek(_ dateString: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        guard let date = dateFormatter.date(from: dateString) else {
            return false
        }
        
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)),
              let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) else {
            return false
        }
        
        return date >= startOfWeek && date <= endOfWeek
    }
}


#Preview {
    MealView()
}
