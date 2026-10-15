import Foundation

enum TwoSum {
    /// 합이 target인 서로 다른 두 원소의 인덱스를 오름차순으로 반환하세요.
    /// 정답 쌍은 최대 하나이며, 없으면 []를 반환합니다.
    /// 예: numbers = [2, 7, 11, 15], target = 9 → [0, 1]
    static func solve(_ numbers: [Int], target: Int) -> [Int] {
        // 첫 번쨰부터 다음 원소 더해가면서 target에 맞으면 return
        var seen: [Int: Int] = [:]
        
        for (index, number) in numbers.enumerated() {
                let complement = target - number

                if let previousIndex = seen[complement] {
                    return [previousIndex, index]
                }

                seen[number] = index
            }
        
        return []
    }
}
