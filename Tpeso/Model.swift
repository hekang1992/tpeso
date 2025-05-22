//
//  Model.swift
//  Tpeso
//
//  Created by 何康 on 2025/5/22.
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
}
