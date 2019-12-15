//
//  Trip.swift
//  kaptenWars
//
//  Created by daniel velasco on 13/12/2019.
//  Copyright © 2019 daniel velasco. All rights reserved.
//

struct Trip: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case pilot
        case distance
        case duration
        case pickUp = "pick_up"
        case dropOff = "drop_off"
    }
    
    let id: Int
    let pilot: Pilot
    let distance: Distance
    let duration: Int
    let pickUp: Location
    let dropOff: Location
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        pilot = try container.decode(Pilot.self, forKey: .pilot)
        distance = try container.decode(Distance.self, forKey: .distance)
        duration = try container.decode(Int.self, forKey: .duration)
        pickUp = try container.decode(Location.self, forKey: .pickUp)
        dropOff = try container.decode(Location.self, forKey: .dropOff)
    }
    
    init(id: Int = 0, pilot: Pilot, distance: Distance, duration: Int, pickUp: Location, dropOff: Location) {
        self.id = id
        self.pilot = pilot
        self.distance = distance
        self.duration = duration
        self.pickUp = pickUp
        self.dropOff = dropOff
    }
}

struct Location: Decodable {
    enum CodingKeys: String, CodingKey {
            case name
            case picture
            case date
       }
    
    let name: String
    let picture: String
    let date: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        picture = try container.decode(String.self, forKey: .picture)
        date = try container.decode(String.self, forKey: .date)
    }
    
    init(name: String, picture: String, date: String) {
        self.name = name
        self.picture = picture
        self.date = date
    }
}

struct Distance: Decodable {
    enum CodingKeys: String, CodingKey {
           case value
           case unit
    }
    
    let value: Double
    let unit: String
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           unit = try container.decode(String.self, forKey: .unit)
           value = try container.decode(Double.self, forKey: .value)
    }
    
    init(value: Double, unit: String) {
        self.value = value
        self.unit = unit
    }
}

struct Pilot: Decodable {
    enum CodingKeys: String, CodingKey {
           case name
           case avatar
           case rating
    }
    
    let name: String
    let avatar: String
    let rating: Float?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        avatar = try container.decode(String.self, forKey: .avatar)
        rating = container.kapten_decodeOptional(Float.self, forKey: .rating)
    }
    
    init(name: String, avatar: String, rating: Float? = nil) {
        self.name = name
        self.avatar = avatar
        self.rating = rating
    }
}
