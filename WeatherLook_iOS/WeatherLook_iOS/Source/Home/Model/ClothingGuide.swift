//
//  ClothingGuide.swift
//  WeatherLook_iOS
//
//  Created by 전소영 on 2022/02/17.
//

import Foundation

struct ClothingGuide {
    let from28 = 28...
    let from23To27 = 23...27
    let from20To22 = 20...22
    let from17To19 = 17...19
    let from12To16 = 12...16
    let from9To11 = 9...11
    let from5To8 = 5...8
    let to4 = ...4
    
    func getClotingImageName(by temperature: Int) -> String {
        switch temperature {
        case self.from28:
            return "28temp"
        case self.from23To27:
            return "from23To27temp"
        case self.from20To22:
            return "from20To22temp"
        case self.from17To19:
            return "from17To19temp"
        case self.from12To16:
            return "from12To16temp"
        case self.from9To11:
            return "from9To11temp"
        case self.from5To8:
            return "from5To8temp"
        case self.to4:
            return "to4temp"
        default:
            return ""
        }
    }
    
    func getClotingDescriptions(by temperature: Int) -> [String] {
        switch temperature {
        case self.from28:
            return ["민소매", "반팔", "반바지"]
        case self.from23To27:
            return ["민소매", "반팔", "반바지"]
        case self.from20To22:
            return ["민소매", "반팔", "반바지"]
        case self.from17To19:
            return ["민소매", "반팔", "반바지"]
        case self.from12To16:
            return ["민소매", "반팔", "반바지"]
        case self.from9To11:
            return ["민소매", "반팔", "반바지"]
        case self.from5To8:
            return ["민소매", "반팔", "반바지"]
        case self.to4:
            return ["패딩", "코트", "목도리"]
        default:
            return []
        }
    }
}
