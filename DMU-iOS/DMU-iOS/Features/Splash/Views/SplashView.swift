//
//  SplashView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/26/23.
//

import SwiftUI

struct SplashView: View {
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                Image("icon")
                    .resizable()
                    .frame(width: 100, height: 112)
                
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
