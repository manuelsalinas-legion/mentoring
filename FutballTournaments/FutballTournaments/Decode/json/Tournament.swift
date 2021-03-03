//
//  Tournaments.swift
//  FutballTournaments
//
//  Created by bts on 24/02/21.
//

// FIXME: (Delete fixme if done) IF THIS FILE IS INSIDE json FOLDER I EXPECT TO SEE JSON FILES. IMPROVE PROYECT ORGANIZATION
struct Tournament: Decodable {
    var type: String?
    var displayName: String?
    var competitions: [Competition]?
}
