//
//  getTeamsDetails.swift
//  FutballTournaments
//
//  Created by bts on 25/02/21.
//

import Foundation

struct TeamDetails: Decodable {
    var idTeam: String?
    var strTeam: String?
    var strDescriptionEN: String?
    var strTeamBadge: String?
    var strTeamBanner: String?
    var strStadium: String?
    var strStadiumThumb: String?
}
