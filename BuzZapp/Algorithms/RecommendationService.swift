import Foundation

final class RecommendationService {
    
    func calculateScore(
        restaurant: Restaurant,
        festival: Festival?
    ) -> Double {
        
        var score = 0.0
        
        score += restaurant.rating * 10
        score += Double(restaurant.popularity) * 0.1
        score -= restaurant.distance * 2
        
        if let festival = festival {
            
            let hasMatch = restaurant.festivalTags.contains { tag in
                tag.localizedCaseInsensitiveCompare(
                    festival.name
                ) == .orderedSame
            }
            
            if hasMatch {
                score += 20
                print("Festival match: \(restaurant.name)")
            }
        }
        
        return score
    }
}
