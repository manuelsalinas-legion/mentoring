//
//  TournamentsResponse.swift
//  FutballTournaments
//
//  Created by bts on 24/02/21.
//

/// Array of tournamest. To JSON decodable
// FIXME: (Delete fixme if done) IF THIS FILE IS INSIDE json FOLDER I EXPECT TO SEE JSON FILES. IMPROVE PROYECT ORGANIZATION
struct TournamentsResponse: Decodable {
    var tournaments: [Tournament]
}
