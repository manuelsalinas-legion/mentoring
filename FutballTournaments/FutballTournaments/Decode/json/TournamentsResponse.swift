//
//  TournamentsResponse.swift
//  FutballTournaments
//
//  Created by bts on 24/02/21.
//

/// Array of tournamest. To JSON decodable
struct TournamentsResponse: Decodable {
    var tournaments: [Tournament]
}
