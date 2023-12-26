//
//  ContentView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/26/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var showMainView = false
    
    var body: some View {
        VStack {
            if showMainView {
                Text("main")
            } else {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                showMainView = true
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
