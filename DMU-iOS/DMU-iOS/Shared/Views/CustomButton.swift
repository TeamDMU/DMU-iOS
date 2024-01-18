//
//  CustomButton.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/27/23.
//

import SwiftUI

struct CustomButton: View {
    
    let title: String
    let action: () -> Void
    var isEnabled: Bool
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.Medium24)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 55, maxHeight: 55)
                .background(isEnabled ? Color.blue300 : Color.gray300)
                .cornerRadius(10)
                .padding(.horizontal, 20)
        }
        .disabled(!isEnabled)
    }
}
