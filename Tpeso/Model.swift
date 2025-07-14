//
//  Model.swift
//  Tpeso
//
//  Created by tom on 2025/5/22.
//

import Foundation

class BaseModel: Codable {
    var laminacy: String
    var worldan: String?
    var raceast: raceastModel?
}

class raceastModel: Codable {
    var byy: String?
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

class PlaneModel: Codable {
    var title: String?//计划名称
    var time: String?//天数
    var amount: String?//计划的金额
    var starttime: String?//计划的开始时间
    var endtime: String?//计划的结束时间
    var desc: String?//描述
    var listTricp: [listTricpModel]?//旅行花费的小项
}

class listTricpModel: Codable {
    var imageStr: String?//logo
    var title: String?//名字
    var money: String?//金额
    var photolst: [String]?//自己上传的旅行配图
    var timehour: String?//记录的时间
    var hour: String?
}

//计划的管理类
class PlaneManager {
    //保存单个模型到数组中
    static func savePlaneModelToLocalList(_ newModel: PlaneModel) {
        var list = loadPlaneModelListFromUserDefaults() // 先加载已有的数组
        list.insert(newModel, at: 0) // 添加新的模型
        if let encoded = try? JSONEncoder().encode(list) {
            UserDefaults.standard.set(encoded, forKey: "PlaneModelListKey")
            UserDefaults.standard.synchronize()
        }
    }
    
    //读取整个模型数组
    static func loadPlaneModelListFromUserDefaults() -> [PlaneModel] {
        if let data = UserDefaults.standard.data(forKey: "PlaneModelListKey"),
           let models = try? JSONDecoder().decode([PlaneModel].self, from: data) {
            return models
        }
        return []
    }
    
    // 根据 title 删除一个 PlaneModel
    static func deletePlaneModel(withTitle title: String) {
        var list = loadPlaneModelListFromUserDefaults()
        list.removeAll { $0.title == title } // 过滤掉要删除的项
        if let encoded = try? JSONEncoder().encode(list) {
            UserDefaults.standard.set(encoded, forKey: "PlaneModelListKey")
            UserDefaults.standard.synchronize()
        }
    }
    
    // 删除所有 PlaneModel
    static func deleteAllPlaneModels() {
        UserDefaults.standard.removeObject(forKey: "PlaneModelListKey")
        UserDefaults.standard.synchronize()
    }
    
    //更新旅行计划的小项
   static func updateListTricpInPlaneModel(withTitle title: String, newList: [listTricpModel]) {
       let list = loadPlaneModelListFromUserDefaults()
        
        // 查找对应的 PlaneModel（可以按 title 匹配，也可以按 index）
        if let index = list.firstIndex(where: { $0.title == title }) {
            list[index].listTricp = newList // 更新 listTricp
            
            // 保存更新后的列表
            if let encoded = try? JSONEncoder().encode(list) {
                UserDefaults.standard.set(encoded, forKey: "PlaneModelListKey")
                UserDefaults.standard.synchronize()
            }
        } else {
            print("未找到对应的 PlaneModel")
        }
    }
    
}

