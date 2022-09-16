//
//  Network.swift
//  RxWeather
//
//  Created by Дина Турман on 04.09.2022.
//

import UIKit
import RxCocoa
import RxSwift


final class Network {
    private let session = URLSession(configuration: .default)
    
    func execute<T: Request>(request: T,
                             completion: @escaping (NetworkResult<T.ResponseType>) -> Void) {
        call(with: request) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    
    
    //reactive
    func execute<T: Request>(with request: T) -> Observable<T.ResponseType> {
        guard let request = try? NetworkProviderRequest(request: request).getRequest() else {
            
            return Observable.error(NetworkError.missingRequest)
        }
        
        return Observable.create { observer in
            let task = self.session.dataTask(with: request) { data, response, error in
                if let _ = error {
                    observer.onError(NetworkError.taskError)
                    
                    return
                }
                
                guard let response = response as? HTTPURLResponse, case (200...299) = response.statusCode else {
                    observer.onError(NetworkError.responseError)
                    
                    return
                }

                guard let data = data else {
                    observer.onError(NetworkError.dataError)
                    
                    return
                }

                guard let decodableResult = try? JSONDecoder().decode(T.ResponseType.self, from: data) else {
                    observer.onError(NetworkError.decodeError)
                    
                    return
                }
                
                observer.onNext(decodableResult)
                observer.onCompleted()
            }
            
            task.resume()
            
            return Disposables.create { task.cancel() }
        }
    }

    //imperative
    private func call<T: Request>(with request: T,
                                  completion: @escaping (NetworkResult<T.ResponseType>) -> Void) {
        let networkProviderRequest = NetworkProviderRequest(request: request)

        guard let request = try? networkProviderRequest.getRequest() else {
            completion(.failure(.missingRequest))
            return
        }

        let task = session.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(.taskError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, case (200...299) = response.statusCode else {
                completion(.failure(.responseError))
                return
            }

            guard let data = data else {
                completion(.failure(.dataError))
                return
            }

            guard let decodableResult = try? JSONDecoder().decode(T.ResponseType.self, from: data) else {
                completion(.failure(.decodeError))
                return
            }
            
            completion(.success(decodableResult))
        }
        
        task.resume()
    }
}

