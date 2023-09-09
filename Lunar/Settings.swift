//
//  Settings.swift
//  Lunar
//
//  Created by Mani on 23/07/2023.
//

import Foundation
import SwiftUI

/// **USAGE**
/// @AppStorage("debugModeEnabled") var debugModeEnabled = Settings.debugModeEnabled

enum Settings {
  static let appBundleID: String = Bundle.main.bundleIdentifier ?? "io.github.mani-sh-reddy.Lunar.app"
  static let lemmyInstances: [String] = [
    "lemmy.world",
    "lemmy.ml",
    "beehaw.org",
    "programming.dev",
    "lemm.ee",
  ]
  static let selectedInstance: String = "lemmy.world"
  static let kbinHostURL: String = "kbin.social"
  static let debugModeEnabled: Bool = false
  static let selectedAppIcon: String = "AppIconLight"

  static let kbinActive: Bool = false

  /// **USAGE**
  /// @AppStorage("loggedInAccounts") var loggedInAccounts = Settings.loggedInAccounts

  static let loggedInAccounts: [AccountModel] = []

  static let selectedName: String = ""
  static let selectedEmail: String = ""
  static let selectedAvatarURL: String = ""
  static let selectedActorID: String = ""

  static let commentSort: String = "Hot"
  static let commentType: String = "All"
  static let postSort: String = "Hot"
  static let postType: String = "All"
  static let communitiesSort: String = "New"
  static let communitiesType: String = "All"

  static let commentMetadataPosition = "Bottom"

  static let subscribedCommunityIDs: [Int] = []

  static let quicklinks: [Quicklink] = [
    Quicklink(
      title: "Local", type: "Local", sort: "Active", icon: "house.circle.fill", iconColor: "34C759"
    ),
    Quicklink(
      title: "All", type: "All", sort: "Active", icon: "building.2.crop.circle.fill",
      iconColor: "31ADE6"
    ),
    Quicklink(
      title: "Top", type: "All", sort: "TopWeek", icon: "chart.line.uptrend.xyaxis.circle.fill",
      iconColor: "FF2D55"
    ),
    Quicklink(
      title: "New", type: "All", sort: "New", icon: "star.circle.fill", iconColor: "FFCC00"
    ),
  ]
  
  static var quicklinkColor: Color = .primary

  static let selectedSearchSortType: String = "Active"
  static let showLaunchSplashScreen: Bool = true
  static let showWelcomeScreen: Bool = true
  static let detailedCommunityLabels: Bool = true
  static let compactViewEnabled: Bool = false
  static let networkInspectorEnabled: Bool = false
  static let prominentInspectorButton: Bool = true
}
