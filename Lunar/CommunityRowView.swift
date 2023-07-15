//
//  CommunityRowView.swift
//  Lunar
//
//  Created by Mani on 04/07/2023.
//

import Kingfisher
import SwiftUI

struct CommunityRowView: View {
    var community: CommunityElement

    var body: some View {
        HStack {
            let processor = DownsamplingImageProcessor(size: CGSize(width: 60, height: 60))
            KFImage(URL(string: community.community.icon ?? ""))
                .setProcessor(processor)
                .placeholder { Image(systemName: "books.vertical.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(.gray)
                }
                .resizable()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
            Text(community.community.title)
                .padding(.horizontal, 10)
        }
    }
}
