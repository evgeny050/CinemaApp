//
//  Enums.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 22.03.2024.
//

enum Font: String {
    case helveticaBold = "HelveticaNeue-Bold"
}

enum KPItem: Hashable {
  case firstSection(KPCollection)
  case secondSection(Movie)
}

enum KPSectionEnum: Hashable {
    case items([KPItemEnum])
}

extension KPSectionEnum: Decodable {
    private enum CodingKeys: String, CodingKey {
        case items = "docs"
    }
    
    enum CodingError: Error {
        case decoding(String)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let collections = try? values.decode([KPCollection].self, forKey: .items) {
            let kpItemEnumList = collections.map { collection in
                KPItemEnum.collection(collection)
            }
            self = .items(kpItemEnumList)
            return
        }
        if let movies = try? values.decode([Movie].self, forKey: .items) {
            let kpItemEnumList = movies.map { movie in
                KPItemEnum.movie(movie)
            }
            self = .items(kpItemEnumList)
            return
        }
        throw CodingError.decoding("Decoding Error: \(dump(values))")
    }
}

enum KPItemEnum: Hashable, Decodable {
    case collection(KPCollection)
    case movie(Movie)
}
