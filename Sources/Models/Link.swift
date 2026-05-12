import Foundation

enum Link {
	case home
	case apps(String)
	case notes(String)
	case articles(String)
	case photos(String)
	case lifeLessons(String)

	var label: String {
		switch self {
		case .home:
			"Home"
		case let .apps(label):
			label
		case let .notes(label):
			label
		case let .articles(label):
			label
		case let .photos(label):
			label
		case let .lifeLessons(label):
			label
		}
	}

	var href: String {
		switch self {
		case .home:
			"/"
		case .apps:
			"/apps/"
		case .notes:
			"/notes/"
		case .articles:
			"/articles/"
		case .photos:
			"/photos/"
		case .lifeLessons:
			"/life-lessons/"
		}
	}
}
