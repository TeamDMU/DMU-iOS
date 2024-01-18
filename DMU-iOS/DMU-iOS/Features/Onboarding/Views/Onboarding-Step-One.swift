//
//  Onboarding-Step-One.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/27/23.
//

import SwiftUI

struct Onboarding_Step_One: View {
    
    @State private var searchText = ""
    @State private var isListVisible = true
    @State private var isTextInList = false
    @State private var isStepTwoViewActive = false
    
    @EnvironmentObject var userSettings: UserSettings
    
    @Binding var isFirstLanching: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                OnboardingTitleView1()
                
                ProgressBarView1()
                
                DepartmentSearchView(searchText: $searchText, isListVisible: $isListVisible, isTextInList: $isTextInList)
                
                Spacer()
                
                CustomButton(title: "다음", action: {
                    if Department.list.contains(searchText) {
                        userSettings.selectedDepartment = searchText
                        self.isStepTwoViewActive = true
                    }
                }, isEnabled: Department.list.contains(searchText))
                .navigationDestination(isPresented: $isStepTwoViewActive) {
                    Onboarding_Step_Two(isFirstLanching: $isFirstLanching)
                }
            }
        }
    }
}

struct OnboardingTitleView1: View {
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 0){
                    Text("소속학과")
                        .font(.Bold32)
                        .foregroundColor(Color.Blue300)
                    
                    Text("를 선택하면,")
                        .font(.Bold32)
                        .foregroundColor(Color.Gray500)
                }
                
                Text("해당 학과의 공지만 바로 알려줘요.")
                    .font(.Bold24)
                    .foregroundColor(Color.Gray500)
            }
            .padding(.top, 60)
        }
        .padding(.leading, -20)
    }
}

struct ProgressBarView1: View {
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundColor(Color.Blue300)
                
                Spacer()
                
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundColor(Color.Gray300)
                
                Spacer()
                
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundColor(Color.Gray300)
            }
            .frame(width: 240, height: 2)
            .background(Color.Gray300)
            
            HStack {
                Text("학과 선택")
                    .padding(.top, 10)
                    .foregroundColor(Color.Blue300)
                    .font(.Bold16)
                
                Spacer()
            }
            .padding(.leading, 49)
            
        }
        .padding(.top, 40)
    }
}

struct DepartmentSearchView: View {
    
    @Binding var searchText: String
    @Binding var isListVisible: Bool
    @Binding var isTextInList: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Spacer()
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Department.list.firstIndex(of: searchText) != nil ? Color.Blue300 : Color.Gray300)
                    .frame(width: 30, height: 30)
                
                TextField("소속 학과를 검색해주세요.", text: $searchText)
                    .foregroundColor(isTextInList ? Color.Blue300 : Color.Gray300)
                    .onChange(of: searchText, perform: { value in
                        self.isListVisible = !searchText.isEmpty && !(Department.list.contains(searchText))
                        self.isTextInList = Department.list.contains(searchText)
                    })
                if !searchText.isEmpty {
                    Button(action: {
                        self.searchText = ""
                    }) {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(Color.Gray300)
                            .frame(width: 30, height: 30)
                    }
                    .padding(.trailing, 16)
                }
            }
            .frame(height: 52)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Department.list.firstIndex(of: searchText) != nil ? Color.Blue300 : Color.Gray300, lineWidth: 2)
            )
            .padding(.horizontal, 20)
            
            if isListVisible {
                List {
                    ForEach(Department.list.filter({ "\($0)".contains(searchText) }), id: \.self) { department in
                        Text(department).onTapGesture {
                            self.searchText = department
                            self.isListVisible = false
                        }
                        .foregroundColor(.gray300)
                    }
                    .listRowBackground(Color.white)
                }
                .listStyle(PlainListStyle())
                .padding(.horizontal, 20)
                .padding(.leading, -20)
                .frame(maxHeight: 200)
            }
        }
        .padding(.top, 40)
    }
}

#Preview {
    Onboarding_Step_One(isFirstLanching: .constant(true))
        .environmentObject(UserSettings())
}
