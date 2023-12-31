//
//  ScheduleView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/31/23.
//

import SwiftUI

struct ScheduleView: View {
    @ObservedObject var viewModel = ScheduleViewModel()
    
    var body: some View {
        VStack {
            scheduleTitle
            monthNavigation
            schedulesList
        }
        .onAppear(perform: viewModel.refreshData)
    }
    
    private var scheduleTitle: some View {
        Text("학사일정")
            .font(.SemiBold20)
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.black)
    }
    
    private var monthNavigation: some View {
        HStack {
            monthChangeButton(direction: -1, systemName: "chevron.left")
            Spacer().frame(minWidth: 100)
            Text(viewModel.currentYearMonth).font(.SemiBold16)
            Spacer().frame(minWidth: 100)
            monthChangeButton(direction: 1, systemName: "chevron.right")
        }
        .padding(.horizontal, 20)
    }
    
    private func monthChangeButton(direction: Int, systemName: String) -> some View {
        Button(action: {
            viewModel.changeMonth(by: direction)
        }) {
            Image(systemName: systemName)
                .foregroundColor(.blue300)
                .frame(width: 30, height: 30)
        }
    }
    
    private var schedulesList: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(viewModel.schedules) { schedule in
                    scheduleRow(for: schedule)
                }
            }
        }
    }
    
    private func scheduleRow(for schedule: Schedule) -> some View {
        VStack {
            HStack {
                Text(schedule.scheduleDisplay)
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

#Preview {
    ScheduleView()
}
