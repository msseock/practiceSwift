//
//  RiverRepository.swift
//  PracticeURLSession
//
//  Created by 석민솔 on 8/20/25.
//

import Foundation

protocol RiverRepositoryProtocol {
    func fetchRiversList() async throws -> [RiverResponse]
    func fetchSingleRiver(name: String) async throws -> RiverResponse
    func fetchErrorData() async throws -> [RiverResponse]
}

class RiverRepository: RiverRepositoryProtocol {
    func fetchRiversList() async throws -> [RiverResponse] {
        let response = try await NetworkService.shared.requestAsync(
            RiverAPI.getAllData,
            type: TotalResponse.self
        )
        
        let resultCode = response.listRiverStageService.result.code
        
        if resultCode != "INFO-000" {
            throw APIResult.init(code: resultCode) ?? .invalidAuthKey
        }
        
        let responseData = response.listRiverStageService.row
        
        return responseData
    }
    
    func fetchSingleRiver(name: String) async throws -> RiverResponse {
        let response = try await NetworkService.shared.requestAsync(
            RiverAPI.getsingleData(riverName: name),
            type: TotalResponse.self
        )
        
        let resultCode = response.listRiverStageService.result.code
        
        if resultCode != "INFO-000" {
            throw APIResult.init(code: resultCode) ?? .invalidAuthKey
        }
        
        if let responseData = response.listRiverStageService.row.first {
            return responseData
        } else {
            throw APIResult.noDataFound
        }
        
        
    }
    
    func fetchErrorData() async throws -> [RiverResponse] {
        let response = try await NetworkService.shared.requestAsync(
            RiverAPI.getError,
            type: TotalResponse.self
        )
        
        let resultCode = response.listRiverStageService.result.code
        
        if resultCode != "INFO-000" {
            throw APIResult.init(code: resultCode) ?? .invalidAuthKey
        }
        
        let responseData = response.listRiverStageService.row
        
        return responseData
    }
}
