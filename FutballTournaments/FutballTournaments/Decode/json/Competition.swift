//
//  Competitions.swift
//  FutballTournaments
//
//  Created by bts on 24/02/21.
//

// FIXME: (Delete fixme if done) IF THIS FILE IS INSIDE json FOLDER I EXPECT TO SEE JSON FILES. IMPROVE PROYECT ORGANIZATION
/// Array of IdLeague, strLeague, strSport, strLeagueAlternate and logo
struct Competition: Decodable {
    var idLeague: String?
    var strLeague: String?
    var strSport: String?
    var strLeagueAlternate: String?
    var logo: String?
}
