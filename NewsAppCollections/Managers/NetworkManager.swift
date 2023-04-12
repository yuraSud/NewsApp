
import Foundation
import UIKit

class NetworkManagers {
    
    static let shared = NetworkManagers(); private init(){}
    
    func fetchNewsFromServer(searchText q: String, completion: @escaping (Result<NewsYUra?, Error>)->Void) {
        
        guard let url = getURLforResponse(q) else {completion(.failure(NewsError.badURL)); return}
       
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {completion(.failure(error ?? NewsError.invalidData))
                return}
            
            let newsModel = self.parseJSON(data: data)
            completion(.success(newsModel))
            
        }.resume()
    }
    
    func fetchImageToArticles(_ url: String, completion: @escaping (Result<UIImage, Error>)->Void) {
        
        guard let url = URL(string: url) else {completion(.failure(NewsError.badURLtoImage)); return}
       
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {completion(.failure(error ?? NewsError.invalidDataImage))
                return}
            
            if let imageFromData = UIImage(data: data) {
                completion(.success(imageFromData))
            }
        }.resume()
    }
    
    private func getURLforResponse(_ search: String) -> URL?{
        let resource = "https://newsapi.org/v2/"
        let source = "top-headlines?"
        let search = "q=\(search)"
//        let country = "&country=de"
//        let category = "&category=business"
        let apiKey = "&apiKey=39bb1c4cc7d1491aa7326845becf74a1"
        let urlString = resource + source + search + apiKey
        let url = URL(string: urlString)
        return url
    }
    
    private func parseJSON(data: Data) -> NewsYUra? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do{
            let newsData = try decoder.decode(NewsYUra.self, from: data)
            return newsData
        } catch {
            print(NewsError.errorParsing)
        }
        return nil
    }
}
