//
//  SearchResult.swift
//  StoreSearch
//
//  Created by Denis Nurislamov on 15.11.2022.
//

import Foundation

class ResultArray: Codable {
    var resultCount = 0
    var results = [SearchResult]()
}

class SearchResult: Codable, CustomStringConvertible {
    
    //MARK: Protocol code for CustomStringConvertible
    var description: String {
        return "\n\nResult - Kind: \(kind ?? "None"), Name: \(name), Artist Name: \(artistName ?? "None") \nImageURL: \(imageSmall), \nCurrency: \(currency)"
    }
    
    //MARK: JSON Properties
    var currency = ""
    var imageSmall = ""
    var imageLarge = ""
    // name:
    var collectionName: String?
    var trackName: String? = ""
    // storeURL:
    var trackViewUrl: String?
    var collectionViewUrl: String?
    // price:
    var trackPrice: Double? = 0.0
    var collectionPrice: Double?
    var itemPrice: Double?
    // genre:
    var itemGenre: String?
    var bookGenre: [String]?
    // type:
    var kind: String? = ""
    // artist:
    var artistName: String? = ""
    
    //MARK: Computed properties
    var name: String {
        return trackName ?? collectionName ?? ""
    }
    var storeURL: String {
        return trackViewUrl ?? collectionViewUrl ?? ""
    }
    var price: Double {
        return trackPrice ?? collectionPrice ?? itemPrice ?? 0.0
    }
    var genre: String {
        if let genre = itemGenre {
            return genre
        } else if let genres = bookGenre {
            return genres.joined(separator: ", ")
        }
        return ""
    }
    
    var type: String {
        let kind = self.kind ?? "audiobook"
        return typeForKind[kind] ?? kind
    }
    
    var artist: String {
        return artistName ?? ""
    }
    
    private let typeForKind = [
        "album":
    NSLocalizedString("Album", comment: "Localized kind: Album"),
        "audiobook":
    NSLocalizedString("Audio Book", comment: "Localized kind: Audio Book"),
        "book":
    NSLocalizedString("Book", comment: "Localized kind: Book"),
        "ebook":
    NSLocalizedString("E-Book", comment: "Localized kind: E-Book"),
        "feature-movie":
    NSLocalizedString("Movie", comment: "Localized kind: Movie"),
        "music-video":
    NSLocalizedString("Music Video", comment: "Localized kind: Music Video"),
        "podcast":
    NSLocalizedString("Podcast", comment: "Localized kind: Podcast"),
        "software":
    NSLocalizedString("App", comment: "Localized kind: App"),
        "song":
    NSLocalizedString("Song", comment: "Localized kind: Song"),
        "tv-episode":
    NSLocalizedString("TV Episode", comment: "Localized kind: TV Episode"),
    ]
    
    //MARK: Coding Keys
    enum CodingKeys: String, CodingKey {
        case imageSmall = "artworkUrl60"
        case imageLarge = "artworkUrl100"
        case itemGenre = "primaryGenreName"
        case bookGenre = "genres"
        case itemPrice = "price"
        case kind, artistName, currency
        case trackName, trackPrice, trackViewUrl
        case collectionName, collectionViewUrl, collectionPrice
    }
    
}

//MARK: - Sorting with symbol '<'
func < (lhs: SearchResult, rhs: SearchResult) -> Bool {
    return lhs.name.localizedStandardCompare(rhs.name) == .orderedAscending
}
