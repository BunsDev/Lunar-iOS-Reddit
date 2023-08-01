//
//  DebugAccountsPropertiesView.swift
//  Lunar
//
//  Created by Mani on 30/07/2023.
//

import Foundation
import SwiftUI

struct DebugAccountsPropertiesView: View {
    @AppStorage("loggedInUsersList") var loggedInUsersList = Settings.loggedInUsersList
    @AppStorage("debugModeEnabled") var debugModeEnabled = Settings.debugModeEnabled
    @AppStorage("selectedActorID") var selectedActorID = Settings.selectedActorID
    @AppStorage("loggedInEmailsList") var loggedInEmailsList = Settings.loggedInEmailsList
    @AppStorage("appBundleID") var appBundleID = Settings.appBundleID
    @AppStorage("loggedInAccounts") var loggedInAccounts = Settings.loggedInAccounts

    var showingPopover: Bool
    var isPresentingConfirm: Bool
    var logoutAllUsersButtonClicked: Bool
    var logoutAllUsersButtonOpacity: Double
    var isLoadingDeleteButton: Bool
    var deleteConfirmationShown: Bool

    var body: some View {
        Section {
            VStack(alignment: .leading, spacing: 5) {
                Text("Debug Properties").textCase(.uppercase)
                Group {
                    Text("showingPopover: \(String(showingPopover))")
                        .booleanColor(bool: showingPopover)
                    Text("isPresentingConfirm: \(String(isPresentingConfirm))")
                        .booleanColor(bool: isPresentingConfirm)
                    Text("logoutAllUsersButtonClicked: \(String(logoutAllUsersButtonClicked))")
                        .booleanColor(bool: logoutAllUsersButtonClicked)
                    Text("logoutAllUsersButtonOpacity: \(String(logoutAllUsersButtonOpacity))")
                    Text("isLoadingDeleteButton: \(String(isLoadingDeleteButton))")
                        .booleanColor(bool: isLoadingDeleteButton)
                    Text("deleteConfirmationShown: \(String(deleteConfirmationShown))")
                        .booleanColor(bool: deleteConfirmationShown)
                }
                Spacer()
                Group {
                    Text("@AppStorage selectedActorID: \(selectedActorID)")
                    Text("@AppStorage loggedInUsersList: \(loggedInUsersList.rawValue)")
                    Text("@AppStorage loggedInEmailsList: \(loggedInEmailsList.rawValue)")
                    Text("@AppStorage loggedInAccounts: \(loggedInAccounts.rawValue)")
                }
                Spacer()
                Group {
                    let keychainDebugString = KeychainHelper.standard.generateDebugString(service: "io.github.mani-sh-reddy.Lunar.app")
                    Text("KEYCHAIN: \(keychainDebugString)").font(.caption2)
                }
            }
        }
        .font(.caption)
        .if(!debugModeEnabled) { _ in EmptyView() }
    }
}
