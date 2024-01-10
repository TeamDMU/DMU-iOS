//
//  HomeDetailView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/10/24.
//

import SwiftUI

struct HomeDetailView: View {
    let notice: Notice
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(notice.noticeTitle)
                .font(.title)
                .padding(.bottom)
            
            Text("게시일: \(notice.noticeDate)")
            
            Text("담당자: \(notice.noticeStaffName)")
            
            Text(notice.noticeDetail)
                .padding(.top)
        }
        .padding()
        .navigationBarTitle("공지사항 상세", displayMode: .inline)
    }
}

