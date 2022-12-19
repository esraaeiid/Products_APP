//
//  DownloadImageDataService.swift
//  Challenge_Thirdwayv
//
//  Created by Esraa Eid on 19/12/2022.
//

import Foundation
import Combine

final class DownloadImageDataService {
    static let shared = DownloadImageDataService()
    
    @Published var photoModels: [ProductsModel.Image] = []
    var cancellables = Set<AnyCancellable>()
    
    private init() { downloadData() }
    
    private func downloadData() {
        guard let url = URL(string: Request.baseURL) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleTryMapOutput)
            .decode(type: [ProductsModel.Image].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error downloading data: \(error)")
                }
            } receiveValue: { [weak self] resultData in
                self?.photoModels = resultData
            }
            .store(in: &cancellables)
    }
    
    private func handleTryMapOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        
        return output.data
    }
}
