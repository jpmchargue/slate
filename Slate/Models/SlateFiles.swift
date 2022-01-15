//
//  SlateFiles.swift
//  Slate
//
//  Created by James McHargue on 1/14/22.
//

import Foundation
import SwiftUI

class SlateFiles: ObservableObject {
    @Published var tasks: [TaskData] = []
    
    private static func saveLocation() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("tasks.data")
    }
    
    static func save(tasks: [TaskData], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(tasks)
                let outfile = try saveLocation()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(tasks.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func load(completion: @escaping (Result<[TaskData], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try saveLocation()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let retrievedTasks = try JSONDecoder().decode([TaskData].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(retrievedTasks))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
