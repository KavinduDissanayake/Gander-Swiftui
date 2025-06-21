//
//  AddOptionsBottomSheet.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//

import SwiftUI
import MijickPopups


struct AddOptionRow: View {
    let icon: String
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.tint)
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                Text(title)
                    .font(.body)
                    .foregroundColor(.tint)

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.tint)
                   
            }
            .padding()
            .background(Color(uiColor: .systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .padding(.horizontal, 8)
        }
    }
}

struct AddOptionsBottomSheet: BottomPopup {
    let onSelectImage: () -> Void
    let onSelectLink: () -> Void

    func configurePopup(config: BottomPopupConfig) -> BottomPopupConfig {
        config
        
            .heightMode(.auto)
            .backgroundColor(Color(uiColor: .secondarySystemBackground))
            .overlayColor(Color.black.opacity(0.3))
            .cornerRadius(16)
    }

    var body: some View {
        VStack(spacing: 16) {
            Capsule()
                .fill(Color.tint.opacity(0.6))
                .frame(width: 40, height: 5)

            Text("ADD")
                .font(.headline)
                .foregroundColor(.primary)

            VStack(spacing: 12) {
                AddOptionRow(icon: "photo.on.rectangle", title: "Image", action: onSelectImage)
                AddOptionRow(icon: "link", title: "Link", action: onSelectLink)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .padding(.top)
    }
}

#if DEBUG
#Preview {
    AddOptionsBottomSheet(
        onSelectImage: { print("Image selected") },
        onSelectLink: { print("Link selected") }
    )

}
#endif

