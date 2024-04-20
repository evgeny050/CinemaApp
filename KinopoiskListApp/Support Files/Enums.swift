////
////  Enums.swift
////  KinopoiskListApp
////
////  Created by Флоранс on 22.03.2024.
////
//
//import UIKit
//
//enum SectionKind: Int, CaseIterable {
//    case collections
//    case movies
//    case persons
//    case categories
//    case facts
//    
//    var itemHeight: NSCollectionLayoutDimension {
//        switch self {
//        case .collections:
//            return .absolute(180)
//        default:
//            return .absolute(235)
//        }
//    }
//    
//    var itemWidth: NSCollectionLayoutDimension {
//        switch self {
//        case .collections:
//            return .absolute(180)
//        default:
//            return .absolute(235)
//        }
//    }
//
//    var groupHeight: NSCollectionLayoutDimension {
//        switch self {
//        case .collections:
//            return .absolute(180)
//        default:
//            return .absolute(235)
//        }
//    }
//    
//    var groupWidht: NSCollectionLayoutDimension {
//        switch self {
//        case .collections:
//            return .absolute(180)
//        default:
//            return .absolute(235)
//        }
//    }
//    
//    var imageHeight: Int {
//        switch self {
//        case .collections:
//            return 125
//        default:
//            return 180
//        }
//    }
//    
//    var isClipped: Bool {
//        self == .persons
//    }
//}
