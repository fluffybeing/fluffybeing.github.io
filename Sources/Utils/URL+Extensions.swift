import Foundation

extension URL {
	var withoutRootPath: URL {
		URL(string: self.relativePath.replacingOccurrences(of: rootPath, with: ""))!
	}
}
