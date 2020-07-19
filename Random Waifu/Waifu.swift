struct Image: Decodable {
    enum CodingKeys: String, CodingKey {
        case url = "large_file_url"
    }
    let url: String
    
}
