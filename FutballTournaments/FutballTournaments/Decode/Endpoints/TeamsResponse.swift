//
//  TeamsResponse.swift
//  FutballTournaments
//
//  Created by bts on 26/02/21.
//

import Foundation

struct TeamsResponse: Decodable {
    var teams: [TeamsByCompetition]?
}
