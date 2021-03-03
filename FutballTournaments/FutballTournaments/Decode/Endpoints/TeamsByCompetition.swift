//
//  URLSessions.swift
//  FutballTournaments
//
//  Created by bts on 25/02/21.
//

import Foundation

// FIXME: (Delete fixme if done) IF THIS FILE IS INSIDE Endpoints FOLDER I EXPECT TO SEE NETWORKING MODELS. IMPROVE PROYECT ORGANIZATION, MAYBE NAMES LIKE ENTITIES, WEB SERVICES RESPONSES, API MODELS, ETC
struct TeamsByCompetition: Decodable {
    var idTeam: String?
    var strTeam: String?
    var strTeamBadge: String?
    var strAlternate: String?
}
