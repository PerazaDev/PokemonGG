//
//  APIManager.swift
//  PokemonGG
//
//  Created by Daniel Sanchez Peraza on 05/04/23.
//

import Foundation
import UIKit



class APIManager{
    
    static let shared = APIManager()
    
   /* public func request<T: Codable>(api: APIConfiguration) async -> Result<T,APIError> {
        do{
            let session = URLSession.shared
            let (data, response) = try await session.data(for: api.urlRequest)
            guard let httpResponse = response as? HTTPURLResponse else{
                return .failure(.noContent)
            }
            debugPrint(String(data: data, encoding: .utf8) ?? "")
            switch httpResponse.statusCode{
            case 200...299:
                do{
                    let decodedObject = try api.jsonDecoder.decode(T.self, from: data)
                    return .success(decodedObject)
                }catch{
                    return .failure(.jsonDecodingError)
                }
            default:
                return .failure(.badRequest)
            }
        }catch{
            return .failure(.badRequest)
        }

    }*/
    public func requestData(api: APIConfiguration) async ->  Result<Data,APIError> {
        do{
            let session = URLSession.shared
            let (data, response) = try await session.data(for: api.urlRequest)
            guard let httpResponse = response as? HTTPURLResponse else{
                return .failure(.noContent)
            }
            debugPrint(String(data: data, encoding: .utf8) ?? "")
            switch httpResponse.statusCode{
            case 200...299:
                return .success(data)
            default:
                return .failure(.badRequest)
            }
        }catch{
            return .failure(.badRequest)
        }

    }
    
    public func request<T: Codable>(api: APIConfiguration) async throws -> T {
        do{
            debugPrint("‼️‼️[URL: \(api.path)]‼️‼️")
            let session = URLSession.shared
            let (data, response) = try await session.data(for: api.urlRequest)
            guard let httpResponse = response as? HTTPURLResponse else{
                throw APIError.noContent
                
            }
            debugPrint(String(data: data, encoding: .utf8) ?? "")
            switch httpResponse.statusCode{
            case 200...299:
                do{
                    let decodedObject = try api.jsonDecoder.decode(T.self, from: data)
                    return decodedObject
                }catch{
                   throw APIError.jsonDecodingError
                }
            default:
                throw APIError.badRequest
            }
        }catch{
            throw APIError.badRequest
        }

    }
    
}
 
enum MethodRequest: String{
    case GET
    case POST
    case PUT
    case DELETE
}

protocol APIConfiguration {
    var method: MethodRequest { get }
    var path: String { get }
    var parameters: [String:Any]? { get }
    var jsonDecoder: JSONDecoder { get }
    var urlRequest: URLRequest{get}
    
}
enum APIError: Error {
    case jsonDecodingError
    case badRequest
    case noContent
}
