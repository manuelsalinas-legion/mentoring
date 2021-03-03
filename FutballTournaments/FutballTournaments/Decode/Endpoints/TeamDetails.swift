//
//  getTeamsDetails.swift
//  FutballTournaments
//
//  Created by bts on 25/02/21.
//

import Foundation

// FIXME: (Delete fixme if done) IF THIS FILE IS INSIDE Endpoints FOLDER I EXPECT TO SEE NETWORKING MODELS. IMPROVE PROYECT ORGANIZATION, MAYBE NAMES LIKE ENTITIES, WEB SERVICES RESPONSES, API MODELS, ETC
struct TeamDetails: Decodable {
    var idTeam: String?
    var strTeam: String?
    var strDescriptionEN: String?
    var strTeamBadge: String?
    var strTeamBanner: String?
    var strStadium: String?
    var strStadiumThumb: String?
}
