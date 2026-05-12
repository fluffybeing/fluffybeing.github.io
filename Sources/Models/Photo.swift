import Foundation

struct Photo: Codable, Identifiable {
	var id: Int
	var imageSrc: String
	var title: String

	/// Cloudinary thumbnail (400px, auto quality, auto format)
	var thumbSrc: String {
		imageSrc.replacingOccurrences(of: "/upload/", with: "/upload/w_400,q_auto,f_auto/")
	}
}

struct PhotoCollection: Codable {
	var title: String
	var content: String
	var publishedAt: String
	var images: [Photo]

	var slug: String {
		title.lowercased().replacingOccurrences(of: " ", with: "-")
	}
}
