//
//  LoggedInUsersListView.swift
//  Lunar
//
//  Created by Mani on 31/07/2023.
//

import SwiftUI

struct LoggedInUsersListView: View {
    @AppStorage("loggedInUsersList") var loggedInUsersList = Settings.loggedInUsersList
    @AppStorage("loggedInEmailsList") var loggedInEmailsList = Settings.loggedInEmailsList
    @AppStorage("debugModeEnabled") var debugModeEnabled = Settings.debugModeEnabled
    @AppStorage("appBundleID") var appBundleID = Settings.appBundleID
    @AppStorage("loggedInAccounts") var loggedInAccounts = Settings.loggedInAccounts

    @Binding var selectedAccount: LoggedInAccount?

    var body: some View {
        ForEach(loggedInAccounts, id: \.self) { account in
            AccountSelectionItem(
                selectedAccount: $selectedAccount,
                account: account
            )
        }
    }
}

struct AccountSelectionItem: View {
    @AppStorage("selectedUserID") var selectedUserID = Settings.selectedUserID
    @AppStorage("selectedName") var selectedName = Settings.selectedName
    @AppStorage("selectedEmail") var selectedEmail = Settings.selectedEmail
    @AppStorage("selectedAvatarURL") var selectedAvatarURL = Settings.selectedAvatarURL
    @AppStorage("selectedActorID") var selectedActorID = Settings.selectedActorID

    @Binding var selectedAccount: LoggedInAccount?

    let account: LoggedInAccount

    var body: some View {
            HStack {
                Text(account.actorID)
                Spacer()
                Image(systemName: "chevron.left.circle.fill")
                    .font(.title2)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.indigo)
                    .opacity(account == selectedAccount ? 1 : 0)
            }
            .contentShape(Rectangle())

        .onTapGesture {
            selectedAccount = account

            selectedUserID = account.userID
            selectedName = account.name
            selectedEmail = account.email
            selectedAvatarURL = account.avatarURL
            selectedActorID = account.actorID

            print("\(String(describing: selectedAccount?.name)) = \(account.name)")
        }
    }
}
