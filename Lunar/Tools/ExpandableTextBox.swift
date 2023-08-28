//
//  ExpandableTextBox.swift
//  Lunar
//
//  Created by Mani on 15/08/2023.
//

import Foundation
import SwiftUI

struct ExpandableTextBox: View {
  @State private var expanded: Bool = false
  @State private var truncated: Bool = false
  private var text: LocalizedStringKey
  var lineLimit = 3

  let haptics = UIImpactFeedbackGenerator(style: .soft)

  init(_ text: LocalizedStringKey) {
    self.text = text
  }

  var body: some View {
    VStack(alignment: .leading) {
      Text(text)
        .lineLimit(expanded ? nil : lineLimit)
        .background(
          Text(text).lineLimit(lineLimit)
            .background(
              GeometryReader { displayedGeometry in
                ZStack {
                  Text(self.text)
                    .background(
                      GeometryReader { fullGeometry in
                        Color.clear.onAppear {
                          self.truncated = fullGeometry.size.height > displayedGeometry.size.height
                        }
                      })
                }
                .frame(height: .greatestFiniteMagnitude)
              }
            )
            .hidden()
        )

      if truncated { toggleButton }
    }
  }

  var toggleButton: some View {
    HStack {
      Spacer()
      ReactionButton(
        text: self.expanded ? "Show less" : "Show more",
        icon: self.expanded
          ? "arrow.down.and.line.horizontal.and.arrow.up"
          : "arrow.up.and.line.horizontal.and.arrow.down",
        color: Color.blue,
        textSize: Font.caption,
        iconSize: Font.caption,
        active: self.$expanded,
        opposite: .constant(false)
      )
      .highPriorityGesture(
        TapGesture().onEnded {
          haptics.impactOccurred(intensity: 0.5)
          self.expanded.toggle()
        }
      )
      Spacer()
    }

  }
}
