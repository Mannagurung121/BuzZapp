import Foundation

struct LocalImageService {
    
    static func foodImage(for food: FoodItem) -> String {
        
        let imageName = food.imageName
            .lowercased()
            .replacingOccurrences(of: " ", with: "_")
            .replacingOccurrences(of: "-", with: "_")
        
        switch imageName {
            
        // Main Food
        case "biryani":
            return "biryani"
            
        case "butter_chicken":
            return "butter_chicken"
            
        case "paneer_tikka":
            return "paneer_tikka"
            
        case "pizza":
            return "pizza"
            
        case "burger":
            return "burger"
            
        case "momos":
            return "momos"
            
        case "noodles":
            return "noodles"
            
        case "dosa":
            return "dosa"
            
        case "chole_bhature":
            return "chole_bhature"
            
        case "samosa":
            return "samosa"
            
        case "pasta":
            return "pasta"
            
        case "fries":
            return "fries"
            
        case "gulab_jamun":
            return "gulab_jamun"
            
        case "ice_cream":
            return "ice_cream"
            
        case "sandwich":
            return "sandwich"
            
            
        // Indian Food
        case "tandoori_chicken":
            return "butter_chicken"
            
        case "chicken_tikka":
            return "butter_chicken"
            
        case "kebab":
            return "butter_chicken"
            
        case "mutton_korma":
            return "butter_chicken"
            
        case "dal_makhani":
            return "butter_chicken"
            
        case "paneer":
            return "paneer_tikka"
            
        case "rajma_chawal":
            return "chole_bhature"
            
        case "kulcha":
            return "chole_bhature"
            
        case "litti_chokha":
            return "chole_bhature"
            
        case "sattu_paratha":
            return "chole_bhature"
            
            
        // South Indian
        case "idli":
            return "dosa"
            
        case "vada":
            return "dosa"
            
        case "medu_vada":
            return "dosa"
            
        case "pongal":
            return "dosa"
            
        case "appam":
            return "dosa"
            
        case "bisi_bele_bath":
            return "chole_bhature"
            
        case "sabudana_khichdi":
            return "dosa"
            
            
        // Sweets
        case "rosogolla":
            return "gulab_jamun"
            
        case "rasgulla":
            return "gulab_jamun"
            
        case "mishti_doi":
            return "ice_cream"
            
        case "modak":
            return "gulab_jamun"
            
        case "payasam":
            return "ice_cream"
            
        case "double_ka_meetha":
            return "gulab_jamun"
            
        case "sevai":
            return "gulab_jamun"
            
            
        // Street Food
        case "aloo_tikki":
            return "samosa"
            
        case "pani_puri":
            return "samosa"
            
        case "misal_pav":
            return "chole_bhature"
            
        case "kathi_roll":
            return "sandwich"
            
        case "pitha":
            return "chole_bhature"
            
        case "kuttu_pakora":
            return "samosa"
            
            
        // Other Food
        case "haleem":
            return "biryani"
            
        case "onam_sadya":
            return "chole_bhature"
            
        case "cold_coffee":
            return "ice_cream"
            
        case "brownie":
            return "ice_cream"
            
        case "plum_cake":
            return "ice_cream"
            
        case "chocolate_cake":
            return "ice_cream"
            
        case "lassi":
            return "ice_cream"
            
            
        // Chinese / Non Veg
        case "chilli_chicken":
            return "butter_chicken"
            
        case "prawn_curry":
            return "butter_chicken"
            
        case "prawn_fry":
            return "butter_chicken"
            
        case "fish_curry":
            return "butter_chicken"
            
        case "smoked_pork":
            return "butter_chicken"
            
        case "naga_chicken":
            return "butter_chicken"
            
        case "chicken_cafreal":
            return "butter_chicken"
            
        case "khar":
            return "butter_chicken"
            
            
        default:
            print("Unknown food image: \(food.imageName)")
            return "pizza"
        }
    }
    
    
    static func restaurantImage(for restaurant: Restaurant) -> String {
        
        let name = restaurant.name.lowercased()
        
        let cuisine = restaurant.cuisine
            .joined(separator: " ")
            .lowercased()
        
        if name.contains("pizza") || cuisine.contains("pizza") {
            return "restaurant_pizza"
        }
        
        if name.contains("burger") || cuisine.contains("burger") {
            return "restaurant_burger"
        }
        
        if name.contains("chinese") || cuisine.contains("chinese") {
            return "restaurant_chinese"
        }
        
        if name.contains("biryani") || cuisine.contains("biryani") {
            return "restaurant_biryani"
        }
        
        if name.contains("cafe") || cuisine.contains("cafe") {
            return "restaurant_cafe"
        }
        
        return "restaurant_indian"
    }
    
    
    static func festivalImage(for festival: Festival) -> String {
        
        switch festival.name.lowercased() {
            
        case "diwali":
            return "diwali_food"
            
        case "holi":
            return "holi_food"
            
        case "eid":
            return "eid_food"
            
        case "christmas":
            return "christmas_food"
            
        default:
            return "diwali_food"
        }
    }
}
