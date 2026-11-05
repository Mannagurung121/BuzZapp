import Foundation

final class APIService {
    
    static let shared = APIService()
    
    private init() {}
    
    let urlString = "https://mocki.io/v1/ba892b12-fbe2-4b9a-a510-cb964e3a4f17"
    
    func fetchData() async throws -> APIResponse {
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        print("API call started")
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            print("Data received: \(data.count)")
            
            guard let response = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            
            print("Status code: \(response.statusCode)")
            
            if response.statusCode < 200 || response.statusCode > 299 {
                throw URLError(.badServerResponse)
            }
            
            do {
                let result = try JSONDecoder().decode(
                    APIResponse.self,
                    from: data
                )
                
                print("Restaurants: \(result.restaurants.count)")
                print("Food items: \(result.foodItems.count)")
                print("Categories: \(result.categories.count)")
                
                return result
                
            } catch {
                print("Decode error: \(error)")
                throw error
            }
            
        } catch {
            print("API error: \(error)")
            throw error
        }
    }
}
