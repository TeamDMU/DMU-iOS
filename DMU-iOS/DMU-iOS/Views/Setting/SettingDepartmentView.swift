//
//  SettingDepartmentView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/5/24.
//

import SwiftUI

struct SettingDepartmentView: View {
    @ObservedObject var viewModel: SettingViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var settingDepartment: String? = nil
    
    var body: some View {
        departmentList()
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("학과 설정", displayMode: .inline)
        .navigationBarItems(leading: backButton, trailing: saveButton)
    }
    
    @ViewBuilder
    var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward")
                .foregroundColor(Color.Gray500)
        }
    }
    
    @ViewBuilder
    var saveButton: some View {
        Button(action: {
            viewModel.saveDepartment()
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("완료")
                .font(.Medium16)
                .foregroundColor(viewModel.settingDepartment != nil ? Color.Blue300 : Color.Gray500)
        }
        .disabled(viewModel.settingDepartment == nil)
    }
    
    @ViewBuilder
    func departmentList() -> some View {
        ScrollView {
            LazyVStack {
                ForEach(Department.departmentlist, id: \.self) { department in
                    departmentRow(for: department)
                }
            }
            .padding(20)
            .background(Color.Gray100)
        }
    }
    
    @ViewBuilder
    func departmentRow(for department: String) -> some View {
        Text(department)
            .font(.Medium18)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, alignment: .center)
            .padding([.top, .bottom], 8)
            .background(viewModel.settingDepartment == department ? Color.Blue300 : Color.white)
            .foregroundColor(viewModel.settingDepartment == department ? Color.white : Color.Gray400)
            .onTapGesture {
                viewModel.selectDepartment(department)
            }
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(viewModel.settingDepartment == department ? .clear : Color.Gray200, lineWidth: 1)
            )
    }
}

#Preview {
    SettingDepartmentView(viewModel: SettingViewModel(userSettings: UserSettings()))
}
