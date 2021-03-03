//
//  TeamsResponse.swift
//  FutballTournaments
//
//  Created by bts on 26/02/21.
//

import Foundation

// FIXME: (Delete fixme if done) IF THIS FILE IS INSIDE Endpoints FOLDER I EXPECT TO SEE NETWORKING MODELS. IMPROVE PROYECT ORGANIZATION, MAYBE NAMES LIKE ENTITIES, WEB SERVICES RESPONSES, API MODELS, ETC
struct TeamsResponse: Decodable {
    var teams: [TeamsByCompetition]?
}
