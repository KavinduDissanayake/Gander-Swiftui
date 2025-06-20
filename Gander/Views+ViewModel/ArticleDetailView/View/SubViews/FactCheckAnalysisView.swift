//
//  FactCheckAnalysisView.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//
import SwiftUI

 struct FactCheckAnalysisView: View {
    let rationale: String
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(rationale)
                .font(.body)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
        }
    }
}

#Preview("FactCheckAnalysisView") {
    FactCheckAnalysisView(rationale: "This is a preview of the fact-check analysis rationale. It explains the decision behind the fact-check status and provides a summarized justification.")
        .padding()
}
