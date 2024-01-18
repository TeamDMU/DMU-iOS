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
            MealTitle
            
            MenuListView
        }
        .onAppear(perform: viewModel.loadSampleData)
    }
    
    private var MealTitle: some View {
        Text("금주의 식단")
            .font(.SemiBold20)
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(Color.Gray500)
            .padding(.horizontal, 20)
    }
    
    private var MenuListView: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 0) {
                ForEach(viewModel.thisWeeksMenu) { menu in
                    MenuDateView(date: viewModel.formatDate(menu.date))
                        .padding(.horizontal, 20)
                    
                    Text(menu.details.joined(separator: ", "))
                        .font(.SemiBold16)
                        .foregroundColor(Color.Gray500)
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
                .background(Color.Blue100)
                .foregroundColor(Color.Gray500)
                .cornerRadius(30)
            
            Spacer(minLength: 20)
        }
    }
}
#Preview {
    MealView()
}
