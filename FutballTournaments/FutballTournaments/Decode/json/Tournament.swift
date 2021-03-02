//
//  Tournaments.swift
//  FutballTournaments
//
//  Created by bts on 24/02/21.
//

struct Tournament: Decodable {
    var type: String?
    var displayName: String?
    var competitions: [Competition]?
}
