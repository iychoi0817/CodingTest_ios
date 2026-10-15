import Foundation

enum RemoveConsecutiveDuplicates {
    /// 연속해서 나타나는 같은 숫자를 하나만 남깁니다. 숫자의 순서는 유지하세요.
    /// 예: [1, 1, 3, 3, 0, 1, 1] → [1, 3, 0, 1]
    static func solve(_ numbers: [Int]) -> [Int] {
        // TODO 1: 결과를 담을 빈 Int 배열을 만드세요.
        var result: [Int] = []
        
        // TODO 2: numbers를 순회하며 결과의 마지막 숫자와 현재 숫자를 비교하세요.
        for (index, number) in numbers.enumerated() {
            if index + 1 == numbers.count {
                result.append(number)
                break
            }
            
            let nextNumber = numbers[index + 1]
            if number != nextNumber {
                result.append(number)
            }
        }
        
        // TODO 3: 마지막 숫자와 다를 때만 추가하고, 완성한 배열을 반환하세요.
        
        return result
    }
}
