//
//  ScheduleView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/31/23.
//

import SwiftUI

struct ScheduleView: View {
    @ObservedObject var viewModel = AcademicCalendarViewModel()
    
    var body: some View {
        VStack {
            Text("학사일정")
                .font(.SemiBold20)
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(.black)
            
            HStack {
                Button(action: {
                    viewModel.changeMonth(by: -1)
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue300)
                        .frame(width: 30, height: 30)
                }
                Spacer()
                    .frame(minWidth: 100)
                Text(viewModel.currentYearMonth)
                    .font(.SemiBold16)
                Spacer()
                    .frame(minWidth: 100)
                Button(action: {
                    viewModel.changeMonth(by: 1)
                }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.blue300)
                        .frame(width: 30, height: 30)
                }
            }
            .padding(.horizontal, 20)
            
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(viewModel.schedules) { schedule in
                        VStack {
                            HStack {
                                Text(schedule.dateDisplay)
                                    .font(.SemiBold14)
                                    .foregroundColor(.gray500)
                                Spacer()
                                Text(schedule.detail)
                                    .font(.SemiBold14)
                                    .foregroundColor(.gray500)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(nil)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(20)
                            
                            Divider()
                        }
                        .background(Color.white)
                    }
                }
            }
        }
        .onAppear {
            viewModel.refreshData()
        }
    }
}

#Preview {
    ScheduleView()
}
