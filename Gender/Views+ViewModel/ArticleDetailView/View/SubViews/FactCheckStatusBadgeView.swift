//
//  FactCheckStatusBadgeView.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//

import SwiftUI

 struct FactCheckStatusBadgeView: View {
    let status: FactCheckStatus
    var body: some View {
        HStack {
            Image(systemName: status.iconName)
            Text(status.displayName)
                .fontWeight(.semibold)
            Spacer()
        }
        .foregroundColor(.white)
        .padding()
        .background(status.color)
        .cornerRadius(12)
    }
}

#Preview {
    FactCheckStatusBadgeView(status: .verified)
        .previewLayout(.sizeThatFits)
        .padding()
}
