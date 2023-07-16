//
//  PostRowView.swift
//  Lunar
//
//  Created by Mani on 04/07/2023.
//

import Kingfisher
import SwiftUI

struct PostRowView: View {
    var post: PostElement

    var body: some View {
        VStack(alignment: .leading) {
            Text(post.post.name)
                .font(.headline)
                .multilineTextAlignment(.leading)

            VStack(alignment: .leading) {
                InPostCommunityHeaderView(community: post.community)
            }
            .padding(.vertical, 1)

            if let thumbnailURL = post.post.thumbnailURL { InPostThumbnailView(thumbnailURL: thumbnailURL)
            } else if let url = post.post.url, url.isValidExternalImageURL() {
                InPostThumbnailView(thumbnailURL: url)
            } else {
                EmptyView()
            }

            HStack(spacing: 6) {
                InPostUserView(bodyText: post.creator.name, iconName: "person.crop", userAvatar: post.creator.avatar)
                Spacer(minLength: 20)
                InPostMetadataView(bodyText: String(post.counts.upvotes), iconName: "arrow.up", iconColor: Color.green)
                InPostMetadataView(bodyText: String(post.counts.downvotes), iconName: "arrow.down", iconColor: Color.red)
                InPostMetadataView(bodyText: String(post.counts.comments), iconName: "text.bubble", iconColor: Color.gray)
            }
        }
    }
}

struct InPostCommunityHeaderView: View {
    var community: Community
    var body: some View {
        HStack(spacing: 0, content: {
//            KFImage(URL(string: community.icon ?? ""))
//                .placeholder { Image(systemName: "books.vertical.circle.fill")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 20, height: 20)
//                    .symbolRenderingMode(.hierarchical)
//                    .foregroundColor(.gray)
//                }
//                .resizable()
//                .frame(width: 20, height: 20)
//                .clipShape(Circle())
//                .scaledToFit()

            HStack(alignment: .lastTextBaseline, spacing: 1) {
                Text(String(community.name))
                Text(String("@\(URLParser.extractDomain(from: community.actorID))"))
                    .foregroundStyle(.gray).opacity(0.8)
            }.lineLimit(1)
                .font(.subheadline)

        })
    }
}

struct InPostThumbnailView: View {
    @State private var isLoading = true

    let processor = DownsamplingImageProcessor(size: CGSize(width: 1300, height: 1300))
//    |> RoundCornerImageProcessor(cornerRadius: 10)

    var thumbnailURL: String
    var body: some View {
        KFImage(URL(string: thumbnailURL))
            .onProgress { receivedSize, totalSize in
                if receivedSize < totalSize {
                    isLoading = true
                } else {
                    isLoading = false
                }
            }
//            .retry(maxCount: 1, interval: .seconds(5))
//            .cacheOriginalImage()
            .setProcessor(processor)
            .resizable()
//            .startLoadingBeforeViewAppear()
            .cancelOnDisappear(true)
            .fade(duration: 0.2)
            .progressViewStyle(.circular)
            .aspectRatio(contentMode: .fit)
            .frame(alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .padding(.bottom, 3)
    }
}

struct InPostUserView: View {
    var bodyText: String
    var iconName: String
    var userAvatar: String?
    var body: some View {
        HStack(alignment: .center, spacing: 2) {
//            KFImage(URL(string: userAvatar ?? ""))
//                .placeholder { Image(systemName: "person.circle.fill")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 20, height: 20)
//                    .symbolRenderingMode(.hierarchical)
//                    .foregroundColor(.gray)
//                }
//                .resizable()
//                .frame(width: 20, height: 20)
//                .clipShape(Circle())
//                .scaledToFit()

            Text(String(bodyText))
                .foregroundColor(.gray)
                .textCase(/*@START_MENU_TOKEN@*/ .uppercase/*@END_MENU_TOKEN@*/)
        }
//        .font(.callout)
        .font(.subheadline)
        .padding(.trailing, 2)
        .lineLimit(1)
    }
}

struct InPostMetadataView: View {
    var bodyText: String
    var iconName: String
    var iconColor: Color
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 1) {
            Image(systemName: iconName)
                .symbolRenderingMode(.hierarchical)
                .foregroundColor(iconColor)
            Text(String(bodyText))
                .foregroundColor(iconColor)
                .textCase(/*@START_MENU_TOKEN@*/ .uppercase/*@END_MENU_TOKEN@*/)
        }
//        .font(.callout)
        .font(.subheadline)
        .padding(.horizontal, 2)
        .lineLimit(1)
    }
}

extension String {
    func isValidExternalImageURL() -> Bool {
        let validURLs = [
            "i.imgur.com",
            "media1.giphy.com",
            "media.giphy.com",
            "files.catbox.moe",
            "i.postimg.cc",
        ]
        for url in validURLs {
            if contains(url) {
                return true
            }
        }
        return false
    }
}

enum URLParser {
    static func extractDomain(from url: String) -> String {
        guard let urlComponents = URLComponents(string: url),
              let host = urlComponents.host
        else {
            return ""
        }

        if let range = host.range(of: #"^(www\.)?([a-zA-Z0-9-]+\.[a-zA-Z]{2,})(\.[a-zA-Z]{2,})?$"#,
                                  options: .regularExpression)
        {
            return String(host[range])
        }

        return ""
    }
}

struct PostRowView_Previews: PreviewProvider {
    static var previews: some View {
        let post =
            PostElement(
                post: PostObject(
                    id: 1_161_347,
                    name: "This is an example title used while creating the post row view in xcode",
                    url: "https://lemmy.world/pictrs/image/7ae620b7-203e-43f3-b43f-030ad3beb629.png",
                    creatorID: 316_097,
                    communityID: 22036,
                    removed: false,
                    locked: false,
                    published: "2023-07-07T23:47:15.923519Z",
                    deleted: false,
                    thumbnailURL: "https://i.imgur.com/F3LORSG.jpeg",
                    apID: "https://lemmy.world/post/1161347",
                    local: true,
                    languageID: 37,
                    featuredCommunity: false,
                    featuredLocal: false,
                    body: "[@ljdawson](https://lemmy.world/u/ljdawson) shared on Discord",
                    updated: "2023-07-07T23:49:45.584798Z",
                    embedTitle: nil,
                    embedDescription: nil,
                    embedVideoURL: nil
                ),
                creator: Creator(
                    id: 316_097,
                    name: "eco",
                    displayName: nil,
                    avatar: "",
                    banned: false,
                    published: "2023-06-21T17:02:57.364033Z",
                    actorID: "https://lemmy.world/u/eco",
                    bio: nil,
                    local: true,
                    banner: nil,
                    deleted: false,
                    admin: false,
                    botAccount: false,
                    instanceID: 1,
                    updated: nil,
                    matrixUserID: nil
                ),
                community: Community(
                    id: 22036,
                    name: "syncforlemmy",
                    title: "Sync for Lemmy",
                    description: "ðŸ‘€",
                    removed: false,
                    published: "2023-06-20T10:21:37.000528Z",
                    updated: nil,
                    deleted: false,
                    actorID: "https://lemmy.world/c/syncforlemmy",
                    local: true,
                    icon: nil,
                    hidden: false,
                    postingRestrictedToMods: false,
                    instanceID: 1,
                    banner: nil
                ),
                creatorBannedFromCommunity: false,
                counts: Counts(
                    id: 254_871,
                    postID: 1_161_347,
                    comments: 189,
                    score: 2180,
                    upvotes: 2188,
                    downvotes: 8,
                    published: "2023-07-07T23:47:15.923519Z",
                    newestCommentTimeNecro: "2023-07-08T14:53:06.765630Z",
                    newestCommentTime: "2023-07-08T14:53:06.765630Z",
                    featuredCommunity: false,
                    featuredLocal: false,
                    hotRank: 204,
                    hotRankActive: 8999
                ),
                subscribed: .notSubscribed,
                saved: false,
                read: false,
                creatorBlocked: false,
                unreadComments: 189
            )

        PostRowView(post: post).padding()
    }
}
