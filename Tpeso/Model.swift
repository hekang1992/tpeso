//
//  Model.swift
//  Tpeso
//
//  Created by tom on 2025/5/22.
//

class BaseModel: Codable {
    var laminacy: String
    var worldan: String?
    var raceast: raceastModel?
}

class raceastModel: Codable {
    var esee: String?
    var stigmative: String?
    var xyz: String?
    var includeety: String?
    var rubrative: rubrativeModel?
}

class rubrativeModel: Codable {
    var corticoence: String?
    var gardenitude: String?
    var quiship: String?
    var whoseive: String?
}
