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
    
    @State private var selectedKeywords = [String: [String]]()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(0..<titles.count) { index in
                    VStack(alignment: .leading, spacing: 16) {
                        Text(titles[index])
                            .font(.Medium20)
                            .foregroundColor(Color.gray600)
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 88), spacing: 0, alignment: .leading)], spacing: 16) {
                            ForEach(contents[index], id: \.self) { content in
                                SelectableButton(content: content, isSelected: selectedKeywords[titles[index], default: []].contains(content)) {
                                    if selectedKeywords[titles[index], default: []].contains(content) {
                                        selectedKeywords[titles[index]]?.removeAll { $0 == content }
                                    } else {
                                        selectedKeywords[titles[index], default: []].append(content)
                                    }
                                }
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
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(content)
                .font(.SemiBold16)
                .foregroundColor(isSelected ? Color.white : Color.gray400)
                .padding(EdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16))
                .background(isSelected ? Color.blue300 : Color.white)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(isSelected ? Color.blue300 : Color.gray400, lineWidth: 1)
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct CustomKeyword_Previews: PreviewProvider {
    static var previews: some View {
        CustomKeyword()
    }
}

