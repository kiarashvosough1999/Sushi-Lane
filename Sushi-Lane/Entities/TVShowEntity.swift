//
//  TVShowEntity.swift
//  Sushi-Lane
//
//  Created by Kiarash Vosough on 8/8/23.
//

struct TVShowEntity {
    let titleDefault: String
    let channelId: Int
}

extension TVShowEntity: Decodable {}
extension TVShowEntity: Hashable {}
extension TVShowEntity: Identifiable {
    var id: Int { hashValue }
}
