//
//  Onboarding-Step-One.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/27/23.
//

import SwiftUI

struct Onboarding_Step_One: View {
    
    @State private var searchText = ""
    
    var body: some View {
        
        VStack {
            // 제목
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 0){
                        Text("소속학과")
                            .font(.Bold32)
                            .foregroundColor(.blue300)
                        Text("를 선택하면,")
                            .font(.Bold32)
                            .foregroundColor(.gray500)
                    }
                    Text("해당 학과의 공지만 바로 알려줘요.")
                        .font(.Bold24)
                        .foregroundColor(.gray500)
                }
                .padding(.top, 60)
            }
            .padding(.leading, -20)
            
            // 프로그레스바
            VStack(alignment: .center) {
                HStack {
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.blue300)
                    
                    Spacer()
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.gray300)
                    
                    Spacer()
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.gray300)
                }
                .frame(width: 240, height: 2)
                .background(.gray300)
                
                HStack {
                    Text("학과 선택")
                        .padding(.top, 10)
                        .foregroundColor(.blue300)
                        .font(.Bold16)
                    Spacer()
                }
                .padding(.leading, 49)
                    
            }
            .padding(.top, 40)
            
            // 학과 검색창
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "magnifyingglass")  // 아이콘 추가
                        .foregroundColor(.gray)
                        .frame(width: 30, height: 30)
                    
                    TextField("소속 학과를 검색해주세요.", text: $searchText)  // placeholder 변경
                }
                .frame(height: 52)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 20)
                
                List {
                    // 사용자가 입력한 키워드를 포함하는 학과만 표시
                    ForEach(Department.list.filter({ "\($0)".contains(searchText) }), id: \.self) { department in
                        // 리스트의 학과를 선택하면 그 학과의 이름이 검색창에 입력됨
                        Text(department).onTapGesture {
                            self.searchText = department
                        }
                    }
                }
            }
            .padding(.top, 40)
            
            
            // 다음 버튼
            VStack {
                Spacer()  // 버튼을 아래쪽으로 밀어내는 데 사용합니다.
                CustomButton(title: "다음", action: {
                    print("버튼 클릭!")
                })
            }
        }
    }
}

#Preview {
    Onboarding_Step_One()
}
