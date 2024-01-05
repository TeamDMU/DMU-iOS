//
//  SettingDepartmentView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/5/24.
//

import SwiftUI

struct SettingDepartmentView: View {
    @ObservedObject var viewModel: SettingViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SettingDepartmentView(viewModel: SettingViewModel(userSettings: UserSettings()))
}
