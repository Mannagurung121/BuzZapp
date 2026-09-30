import Foundation

final class FestivalService {
    
    private var apiKey: String {
        Bundle.main.object(
            forInfoDictionaryKey: "CALENDARIFIC_API_KEY"
        ) as? String ?? ""
    }
    
    func getTodayFestival() async throws -> String? {
          
        let year = Calendar.current.component(
            .year,
            from: Date()
        )
        
        let urlString =
        "https://calendarific.com/api/v2/holidays" +
        "?api_key=\(apiKey)" +
        "&country=IN" +
        "&year=\(year)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        print("Festival API call started")
        
        let (data, response) = try await URLSession.shared.data(
            from: url
        )
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        print("Festival status: \(httpResponse.statusCode)")
        
        guard (200...299).contains(httpResponse.statusCode) else {
            print("Festival API failed")
            throw URLError(.badServerResponse)
        }
        
        do {
            let result = try JSONDecoder().decode(
                CalendarificResponse.self,
                from: data
            )
            
            let today = Calendar.current.dateComponents(
                [.year, .month, .day],
                from: Date()
            )
            
            for holiday in result.response.holidays {
                
                let date = holiday.date.datetime
                
                if date.year == today.year &&
                    date.month == today.month &&
                    date.day == today.day {
                    
                    print("Festival found: \(holiday.name)")
                    return holiday.name
                }
            }
            
            print("No festival today")
            return nil
            
        } catch {
            print("Festival decode error: \(error)")
            throw error
        }
    }
}

