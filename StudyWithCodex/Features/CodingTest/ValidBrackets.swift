import Foundation

enum ValidBrackets {
    /// (), [], {}의 종류와 닫히는 순서가 모두 올바르면 true를 반환하세요.
    /// 예: "([]){}" → true, "([)]" → false, "" → true
    
    static func solve(_ brackets: String) -> Bool {
        // 열리는거 체크한 후에 닫히는 문자 들어왔을 때 틀리면 false 맞으면 true
        // 배열에 opens를 append 해주다가 close를 만났을 때 last와 일치하면 true겠지
        var opens: [Character] = []
        var result = true
        
        let bracketsDic: [Character: Character] = ["(":")", "[":"]", "{":"}"]
        
        print("\(brackets)")
        
        for char in brackets {
            if char == "(" || char == "[" || char == "{" {
                opens.append(char)
            } else {
                if let last = opens.last, char != bracketsDic[last] {
                    result = false
                    break // 열린 것과 일치하지 않는 경우
                } else {
                    if opens.count > 0 {
                        opens.removeLast()
                    } else {
                        result = false
                        break // 열지도 않았는데 닫힌 경우
                    }
                }
            }
        }
        
        // 마지막이 열려 있는 경우로 끝날 경우
        if opens.count > 0 {
            bracketsDic.keys.forEach { char in
                if opens.last == char {
                    result = false
                }
            }
        }
        
        return result
        // AI 제안 마지막 조건 확인 할 때 닫히는 경우에는 append가 되지 않기 때문에 키 전체를 확인하지 않고
        // return result && opens.isEmpty 로도 확인 가능
    }
}
