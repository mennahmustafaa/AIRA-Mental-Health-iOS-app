//
//  ScriptService.swift
//  AIRA
//
//  Created by Mennah on 10/10/2025.
//

import Foundation

class ScriptService {
    static let shared = ScriptService()
    
    private var scripts: [String: String] = [:]
    
    private init() {
        loadScripts()
    }
    
    private func loadScripts() {
        guard let url = Bundle.main.url(forResource: "scripts", withExtension: "json") else {
            print("ScriptService: scripts.json not found in bundle.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            scripts = try JSONDecoder().decode([String: String].self, from: data)
        } catch {
            print("ScriptService: Failed to decode scripts.json - \(error)")
        }
    }
    
    func getScript(for mood: String) -> String {
        return scripts[mood.lowercased()] ?? scripts["default"] ?? "You are a helpful AI assistant."
    }
    
    func getScript(for mood: Mood) -> String {
        return getScript(for: mood.title)
    }
}
