//
//  place.swift
//  mapkitStuff
//
//  Created by MCS Devices on 1/4/18.
//  Copyright © 2018 MCS Devices. All rights reserved.
//

import Foundation
import CoreLocation


struct place: Decodable {
    let html_attributions: [String?]
    let  results: Array<Result>
    let status: String
    let next_page_token:String
    }
struct Result: Decodable {
    let geometry: Geometry
    let icon: URL
    let id: String
    let name: String
    let opening_hours: openhours?
    let photos: [Photo?]
    let place_id: String
    let scope: String
    let alt_ids: [alt?]?
    let reference: String
    let types: [String?]
    let vincinity: String?
    
    
    
}
struct alt:Decodable {
    let place_id: String?
    let scope: String?
}
struct Components: Decodable {
    let long_name: String?
    let short_name: String?
    let types: [String?]
}
struct Geometry: Decodable {
    let location: Location
}
struct Location: Decodable {
    let lat: Double?
    let lng: Double?
}
struct ViewPort: Decodable {
    let northeast: Location?
    let southwest: Location?
}
struct Review: Decodable {
    let author_name: String?
    let author_url: URL?
    let language: String?
    let profile_picture_url: String?
    let rating: Int?
    let relative_time_Description: String?
    let text: String?
    let time: Int?
    
}
struct Photo: Decodable {
    let height: Int?
    let html_attributions: [String?]
    let photo_references: String?
    let width: Int?
}
struct openhours: Decodable {
    let open_now: Bool?
}
class Details {
    var name: String?
    var opennow: Bool?
    var vincinity: String?  
    init() { }
}
