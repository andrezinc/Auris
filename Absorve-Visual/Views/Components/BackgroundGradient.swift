//
//  BackgroundGradient.swift
//  Absorve-Visual
//
//  Created by Alana Queiroz on 19/11/25.
//

import SwiftUI

struct BackgroundGradient: View {
    var body: some View {
        LinearGradient(colors: [.topGradiente, .bottomGradiente, .bottomGradiente, .bottomGradiente], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

#Preview {
    BackgroundGradient()
}
