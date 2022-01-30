import Foundation

typealias Parameters = [String: Any]
typealias Path = String

final class Endpoint<Response: Decodable> {
    let method: Method
    let path: Path
    let parameters: Parameters?
    
    init(
        method: Method = .get,
        path: Path,
        parameters: Parameters? = nil
    ) {
        self.method = method
        self.path = path
        self.parameters = parameters
    }
}
