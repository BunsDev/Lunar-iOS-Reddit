//
//  AppResetButton.swift
//  Lunar
//
//  Created by Mani on 01/08/2023.
//

import SwiftUI

struct AppResetButton: View {
  @AppStorage("loggedInUsersList") var loggedInUsersList = Settings.loggedInUsersList
  @AppStorage("loggedInEmailsList") var loggedInEmailsList = Settings.loggedInEmailsList
  @AppStorage("loggedInAccounts") var loggedInAccounts = Settings.loggedInAccounts

  @State private var showConfirmation: Bool = false
  @State private var isLoading: Bool = false
  @State private var isClicked: Bool = false
  @State private var confirmationOpacity: Double = 0
  @Binding var refreshView: Bool

  var notificationHaptics = UINotificationFeedbackGenerator()

  var body: some View {
    Section {
      Button(role: .destructive) {
        showConfirmation = true
      } label: {
        Label {
          if isLoading {
            ProgressView()
          } else {
            Text("Reset App")
              .foregroundStyle(.primary)
          }
          Spacer()
          ZStack(alignment: .trailing) {
            if isClicked {
              Group {
                Image(systemName: "checkmark.circle.fill")
                  .font(.title2).opacity(confirmationOpacity)
                  .symbolRenderingMode(.hierarchical)
                  .foregroundStyle(.primary)
              }.onAppear {
                let animation = Animation.easeInOut(duration: 2)
                confirmationOpacity = 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                  isClicked = false
                  withAnimation(animation) {
                    confirmationOpacity = 0
                  }
                }
              }
            }
          }
        } icon: {
          Image(systemName: "exclamationmark.octagon.fill")
            .font(.title2)
            .foregroundStyle(.red)
            .symbolRenderingMode(.hierarchical)
        }.onTapGesture {
          showConfirmation = true
        }
      }
      .hapticFeedbackOnTap(style: .rigid)
      .confirmationDialog("Clear user defaults and reset app", isPresented: $showConfirmation) {
        Button(role: .destructive) {
          resetApp()
        } label: {
          Text("Confirm Reset")
        }
      }
    }
  }

  private func resetApp() {
    showConfirmation = true
    isLoading = true
    notificationHaptics.notificationOccurred(.success)
    isClicked = true

    loggedInEmailsList.removeAll()
    loggedInAccounts.removeAll()
    loggedInUsersList.removeAll()

    KeychainHelper.standard.clearKeychain()

    if let bundleID = Bundle.main.bundleIdentifier {
      UserDefaults.standard.removePersistentDomain(forName: bundleID)
      UserDefaults.standard.synchronize()
    }

    refreshView.toggle()

    isLoading = false
    showConfirmation = false
  }
}
