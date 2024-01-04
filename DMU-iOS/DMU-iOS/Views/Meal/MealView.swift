//
//  MealView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/31/23.
//

import SwiftUI

struct MealView: View {
    @StateObject var viewModel: MealViewModel
    
    init(viewModel: MealViewModel = MealViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            headerView
            menuListView
        }
        .onAppear(perform: viewModel.loadSampleData)
    }
    
    private var headerView: some View {
        Text("금주의 식단")
            .font(.SemiBold20) // 이 폰트가 시스템에 포함되어 있거나, 앱에 추가되어 있다고 가정합니다.
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.gray500) // 이 색상이 앱의 Color Assets에 정의되어 있다고 가정합니다.
            .padding(.horizontal, 20)
    }
    
    private var menuListView: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 0) {
                ForEach(viewModel.thisWeeksMenu) { menu in
                    MenuDateView(date: viewModel.formatDate(menu.date))
                        .padding(.horizontal, 20)
                    
                    Text(menu.details.joined(separator: ", "))
                        .font(.SemiBold16)
                        .foregroundColor(.gray500)
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
    }
}

struct MenuDateView: View {
    var date: String
    
    var body: some View {
        HStack {
            Spacer(minLength: 20)
            Text(date)
                .font(.SemiBold16)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(.blue100)
                .foregroundColor(.gray500)
                .cornerRadius(30)
            Spacer(minLength: 20)
        }
    }
}
#Preview {
    MealView()
}
