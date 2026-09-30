import Foundation

struct ScoredRestaurant {
    let restaurant: Restaurant
    let score: Double
}

struct MinHeap {
    
    private var heap: [ScoredRestaurant] = []
    
    var count: Int {
        heap.count
    }
    
    mutating func insert(_ item: ScoredRestaurant) {
        heap.append(item)
        
        var index = heap.count - 1
        
        while index > 0 {
            let parent = (index - 1) / 2
            
            if heap[parent].score <= heap[index].score {
                break
            }
            
            heap.swapAt(parent, index)
            index = parent
        }
    }
    
    mutating func remove() -> ScoredRestaurant? {
        
        if heap.isEmpty {
            return nil
        }
        
        if heap.count == 1 {
            return heap.removeLast()
        }
        
        let result = heap[0]
        heap[0] = heap.removeLast()
        
        var index = 0
        
        while true {
            let left = index * 2 + 1
            let right = index * 2 + 2
            
            var smallest = index
            
            if left < heap.count &&
                heap[left].score < heap[smallest].score {
                smallest = left
            }
            
            if right < heap.count &&
                heap[right].score < heap[smallest].score {
                smallest = right
            }
            
            if smallest == index {
                break
            }
            
            heap.swapAt(index, smallest)
            index = smallest
        }
        
        return result
    }
}
