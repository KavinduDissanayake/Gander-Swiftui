//
//  FactCheckInputBottomSheet.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//
import SwiftUI
import MijickPopups

//# MARK: - Bottom Sheet Input View

struct FactCheckInputBottomSheet: BottomPopup {
    @Binding var inputURL: String
    @ObservedObject var viewModel: HomeViewModel

    
    
    func configurePopup(config: BottomPopupConfig) -> BottomPopupConfig {
        config
            .heightMode(.auto)
            .backgroundColor(Color(uiColor: .secondarySystemBackground))
            .overlayColor(Color.black.opacity(0.3))
            .cornerRadius(16)
    }

    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Spacer()
                Button(action: {
                    Task{
                        await dismissLastPopup()
                    }
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.secondary)
                        .padding(8)
                        .background(Color(.systemGray5))
                        .clipShape(Circle())
                }
            }
            .padding(.top)
            .padding(.horizontal)

            Text("Enter NYTimes Article URL")
                .font(.headline)
                .padding(.horizontal)

            VStack(spacing: 8) {
                HStack {
                    Image(systemName: "link")
                        .foregroundColor(.blue)
                        .padding(.leading, 10)
                    TextField("https://www.nytimes.com/...", text: $inputURL)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .textSelection(.enabled)
                        .keyboardType(.URL)
                        .submitLabel(.done)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 4)
                }
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            }
            .padding(.horizontal)

            Button(action: {
                viewModel.loadArticle(from: inputURL)
            }) {
                Text("Check Facts")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(inputURL.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            .disabled(inputURL.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || viewModel.isLoading)

            if let errorMessage = viewModel.errorMessage {
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.orange)
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Button("Dismiss") {
                        viewModel.clearError()
                    }
                    .font(.caption)
                    .foregroundColor(.blue)
                }
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)
            }

            if viewModel.isLoading {
                VStack(spacing: 8) {
                    ProgressView()
                    Text("Analyzing article...")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
        }
        .padding(.bottom)
    }
}


