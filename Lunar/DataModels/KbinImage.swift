//
//  KbinImage.swift
//  Lunar
//
//  Created by Mani on 09/12/2023.
//

import Foundation

struct KbinImage: Codable {
  let filePath, sourceURL, storageURL, altText: String
  let width, height: Int

  enum CodingKeys: String, CodingKey {
    case filePath
    case sourceURL = "sourceUrl"
    case storageURL = "storageUrl"
    case altText, width, height
  }
}
