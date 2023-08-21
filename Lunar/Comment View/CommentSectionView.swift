//
//  CommentSectionView.swift
//  Lunar
//
//  Created by Mani on 18/08/2023.
//

import SwiftUI

struct CommentSectionView: View {
  @EnvironmentObject var postsFetcher: PostsFetcher
  @EnvironmentObject var commentsFetcher: CommentsFetcher
  var post: PostElement
  var comments: [CommentElement]
  var postBody: String
  
  @State var collapseToIndex: Int = 0
  @State var postBodyExpanded:Bool = false
  
  @Binding var upvoted: Bool
  @Binding var downvoted: Bool
  
  var communityIsSubscribed: Bool {
    if post.subscribed == .subscribed {
      return true
    } else {
      return false
    }
  }
  
  var body: some View {
    List {
      Section {
        PostRowView(upvoted: $upvoted, downvoted: $downvoted, isSubscribed: communityIsSubscribed, post: post).environmentObject(postsFetcher)
        InPostActionsView(post: post)
        if !postBody.isEmpty {
          VStack (alignment: .trailing){
              ExpandableTextBox(LocalizedStringKey(postBody)).font(.body)
          }
        }
      }
      .listRowSeparator(.hidden)
      .listRowBackground(Color.clear)
      Section {
        ForEach(comments.indices, id: \.self) { index in
          var indentLevel: Int {
            let elements = comment.comment.path.split(separator: ".").map { String($0) }
            let elementCount = elements.isEmpty ? 1 : elements.count - 1
            if elementCount >= 1 {
              return elementCount
            } else {
              return 1
            }
          }
          
          let comment = comments[index]
          if index <= collapseToIndex && indentLevel != 1 {
            EmptyView()
          } else {
            CommentRowView(collapseToIndex: $collapseToIndex, comment: comment, listIndex: index)
              .environmentObject(commentsFetcher)
          }
        }
      }
    }.listStyle(.grouped)
  }
}
