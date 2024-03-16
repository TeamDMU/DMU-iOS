//
//  CustomKeyword.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/27/23.
//

import SwiftUI

struct CustomKeyword: View {
    
    let titles = ["수업", "학적", "장학금", "취업", "기타"]
    let contents = [
        ["시험", "수강", "특강", "계절학기"],
        ["휴학", "복학", "졸업", "전과", "학기포기"],
        ["장학", "국가장학", "등록"],
        ["채용", "공모전", "대회", "현장실습", "봉사"],
        ["기숙사", "동아리", "학생회"]
    ]
    
    @Binding var selectedKeywords: [String]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(Array(titles.enumerated()), id: \.element) { index, title in
                    KeywordSection(title: title, items: contents[index], selectedKeywords: $selectedKeywords)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

struct KeywordSection: View {
    var title: String
    var items: [String]
    @Binding var selectedKeywords: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.Medium20)
                .foregroundColor(Color.Gray600)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 90), spacing: 0, alignment: .leading)], spacing: 16) {
                ForEach(items, id: \.self) { item in
                    SelectableButton(content: item, isSelected: selectedKeywords.contains(item), action: {
                        if selectedKeywords.contains(item) {
                            selectedKeywords.removeAll { $0 == item }
                        } else {
                            selectedKeywords.append(item)
                        }
                    })
                }
            }
            
            Divider().padding(.top, 10)
        }
    }
}

struct SelectableButton: View {
    let content: String
    var isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(content)
                .font(.SemiBold16)
                .foregroundColor(isSelected ? Color.white : Color.Gray400)
                .frame(minWidth: 70, alignment: .center)
                .padding(.vertical, 5).padding(.horizontal, 16)
                .background(isSelected ? Color.Blue300 : Color.clear)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? Color.Blue300 : Color.Gray400, lineWidth: 1)
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct CustomKeyword_Previews: PreviewProvider {
    @State static var selectedKeywords: [String] = ["시험", "복학"]

    static var previews: some View {
        CustomKeyword(selectedKeywords: $selectedKeywords)
    }
}
