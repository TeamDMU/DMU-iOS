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
        ["장학", "등록"],
        ["채용", "공모전", "대회", "현장실습", "봉사"],
        ["기숙사", "동아리", "학생회"]
    ]
    
    @Binding var selectedKeywords: [String: [String]]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(Array(titles.enumerated()), id: \.element) { index, title in
                    VStack(alignment: .leading, spacing: 16) {
                        Text(title)
                            .font(.Medium20)
                            .foregroundColor(Color.Gray600)
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 90), spacing: 0, alignment: .leading)], spacing: 16) {
                            ForEach(contents[index], id: \.self) { content in
                                SelectableButton(content: content, isSelected: Binding(get: {
                                    self.selectedKeywords[title, default: []].contains(content)
                                }, set: { newValue in
                                    if newValue {
                                        self.selectedKeywords[title, default: []].append(content)
                                    } else {
                                        self.selectedKeywords[title]?.removeAll { $0 == content }
                                        if self.selectedKeywords[title]?.isEmpty == true {
                                            self.selectedKeywords[title] = nil
                                        }
                                    }
                                }), action: {})
                            }
                        }
                        
                        Divider()
                            .padding(.top, 10)
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        }
    }
    
}

struct SelectableButton: View {
    let content: String
    @Binding var isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
            self.isSelected.toggle()
        }) {
            Text(content)
                .font(.SemiBold16)
                .foregroundColor(isSelected ? Color.white : Color.Gray400)
                .frame(width: 70, alignment: .center)
                .padding(EdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16))
                .background(isSelected ? Color.Blue300 : Color.white)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(isSelected ? Color.Blue300 : Color.Gray400, lineWidth: 1)
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct CustomKeyword_Previews: PreviewProvider {
    @State static var selectedKeywords: [String: [String]] = [
        "수업" : ["시험"],
        "학적" : ["복학"]
    ]

    static var previews: some View {
        CustomKeyword(selectedKeywords: $selectedKeywords)
    }
}
