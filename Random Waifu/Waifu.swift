struct Image: Decodable {
    enum CodingKeys: String, CodingKey {
        case url = "file_url"
    }
    let url: String
    
}
