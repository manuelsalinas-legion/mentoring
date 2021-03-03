//
//  TeamDetailsResponse.swift
//  FutballTournaments
//
//  Created by bts on 01/03/21.
//

import Foundation

// FIXME: (Delete fixme if done) IF THIS FILE IS INSIDE Endpoints FOLDER I EXPECT TO SEE NETWORKING MODELS. IMPROVE PROYECT ORGANIZATION, MAYBE NAMES LIKE ENTITIES, WEB SERVICES RESPONSES, API MODELS, ETC
struct TeamDetailsResponse: Decodable {
    var teams: [TeamDetails]?
}
