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
    
    @State private var selectedDepartment: String? = nil
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(Department.departmentlist, id: \.self) { department in
                        Text(department)
                            .font(.Medium18)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, alignment: .center)
                            .padding([.top, .bottom], 8)
                            .background(self.selectedDepartment == department ? Color.Blue300 : Color.white)
                            .foregroundColor(self.selectedDepartment == department ? Color.white : Color.Gray400)
                            .onTapGesture {
                                self.selectedDepartment = self.selectedDepartment == department ? nil : department
                            }
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(self.selectedDepartment == department ? .clear : Color.Gray200, lineWidth: 1)
                            )
                    }
                }
                .padding(20)
                .background(Color.Gray100)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("학과 설정", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(Color.Gray500)
            }, trailing: Button(action: {
                
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("완료")
                    .font(.Medium16)
                    .foregroundColor(self.selectedDepartment != nil ? Color.Blue300 : Color.Gray500)
            }
            .disabled(self.selectedDepartment == nil))
        }
    }
}

#Preview {
    SettingDepartmentView(viewModel: SettingViewModel(userSettings: UserSettings()))
}
