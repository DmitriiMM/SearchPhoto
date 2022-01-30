import Foundation
import Alamofire

enum Constants {
    static let accessKey: String = "NKcv6JyRa2QdbqSLQWAR4QRgymGxVDsHaRDGVJh9gg0"
    static let baseURL: String = "https://meet.google.com/ndd-vyaq-yaw"
}

protocol ClientProtocol {
    func request<Response: Decodable>(_ endpoint: Endpoint<Response>, completion: @escaping (Result<Response, Error>) -> Void)
}

final class Client: ClientProtocol {
    private let session: Alamofire.Session
    private let baseURL = URL(string: Constants.baseURL)!
    private let queue = DispatchQueue(label: "white-and-fluffy-test.networking-serial-queue")

    init(accessKey: String) {
        URLSessionConfiguration.af.default.headers.add(name: "Authorization", value: accessKey)

        let configuration = URLSessionConfiguration.default

        session = Alamofire.Session(configuration: configuration)
    }

    func request<Response: Decodable>(_ endpoint: Endpoint<Response>, completion: @escaping (Result<Response, Error>) -> Void) {
        let request = session.request(
            url(path: endpoint.path),
            method: httpMethod(from: endpoint.method),
            parameters: endpoint.parameters
        )

        request
            .validate()
            .responseDecodable(of: Response.self, queue: queue) { response in
               
                switch response.result {
                case let .success(data): completion(.success(data))
                case let .failure(error): completion(.failure(error))
                }
            }
    }

    private func url(path: Path) -> URL {
        return baseURL.appendingPathComponent(path)
    }
}

private func httpMethod(from method: Method) -> Alamofire.HTTPMethod {
    switch method {
    case .get: return .get
    case .post: return .post
    case .put: return .put
    case .patch: return .patch
    case .delete: return .delete
    }
}
