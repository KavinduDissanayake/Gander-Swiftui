//
//  AddOptionsBottomSheet.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//

import SwiftUI
import MijickPopups

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
                AddOptionRow(icon: "ic_gallary", title: "Image", action: onSelectImage)
                AddOptionRow(icon: "ic_link", title: "Link", action: onSelectLink)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .padding(.top)
    }
}

struct AddOptionRow: View {
    let icon: String
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(icon)
                    .renderingMode(.template)
                    .fontRegular(20)
                    .foregroundColor(.tint)
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

                Text(title)
                    .fontRegular(17)
                    .foregroundColor(.tint)

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.tint)

            }
            .padding()
            .background(Color(.elevatedSurfaceBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .padding(.horizontal, 8)
        }
    }
}

#if DEBUG
#Preview("AddOptionsBottomSheet - Light") {
    AddOptionsBottomSheet(
        onSelectImage: { print("Image selected") },
        onSelectLink: { print("Link selected") }
    )
}

#Preview("AddOptionsBottomSheet - Dark") {
    AddOptionsBottomSheet(
        onSelectImage: { print("Image selected") },
        onSelectLink: { print("Link selected") }
    )
    .preferredColorScheme(.dark)
}

#Preview("AddOptionRow") {
    VStack(spacing: 16) {
        AddOptionRow(icon: "photo.on.rectangle", title: "Image", action: {})
        AddOptionRow(icon: "link", title: "Link", action: {})
    }
    .padding()
    .background(Color(.systemBackground))
}
#endif
