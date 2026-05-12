import Foundation
import Ink
import SwiftHtml

let fileManager = FileManager.default
let documentRenderer = DocumentRenderer(minify: true)

let markdownParser = MarkdownParser()

let rootPath = fileManager.currentDirectoryPath
let assetsDirectory = URL(fileURLWithPath: "\(rootPath)/Assets", isDirectory: true)
let contentDirectory = URL(fileURLWithPath: "\(rootPath)/Content", isDirectory: true)
let outputDirectory = URL(fileURLWithPath: "\(rootPath)/.output", isDirectory: true)

enum Site {
	static let url = "https://fluffybeing.github.io"
	static let author = "Rahul Ranjan"
	static let bio = "<em>An eclectic soul</em>. Learning, building, and crafting simple, <span class='nowrap'>beautiful apps</span>."
	static let email = "hi@rrahul.cc"
	static let cdn = "https://fluffybeing.github.io"
	static let cssFileName = "styles.css"
}

var assetsHashes: [String : String] = [:]

let documentPages = [
	Page(
		path: "",
		contentHtmlString: documentRenderer.render(homeDocument, withLinkSuffixes: true)
	),
	Page(
		path: "about",
		layout: .page(title: "About"),
		contentHtmlString: documentRenderer.render(aboutDocument, withLinkSuffixes: true)
	),
	Page(
		path: "articles",
		layout: .list(title: "Articles"),
		contentHtmlString: documentRenderer.render(articleListDocument, withLinkSuffixes: true)
	),
	Page(
		path: "apps",
		layout: .page(title: "Apps"),
		contentHtmlString: documentRenderer.render(appsDocument, withLinkSuffixes: true)
	)
]
let indieApps: [LinkedResource] = []
var pages: [Page] = []
var articles: [Page] = []
var notes: [Note] = []
var photoCollections: [PhotoCollection] = []

@main
struct Main {
	static func main() async throws {
		prepareOutputFolder()
		await prepareAssets()
		buildNotes()
		buildPhotos()
		buildLifeLessons()
		await buildContent()
		makePages()
		makeFeed()
	}
}

func prepareOutputFolder() {
	do {
		if fileManager.fileExists(atPath: outputDirectory.path) {
			try fileManager.removeItem(at: outputDirectory)
		}
		try fileManager.createDirectory(at: outputDirectory, withIntermediateDirectories: true)
	} catch {
		fatalError("\(#function): \(error)")
	}
}

func prepareAssets() async {
	do {
		let contentFiles = fileManager.walkDirectory(at: assetsDirectory)
		for await contentFile in contentFiles {
			let relativePath = contentFile.path.replacingOccurrences(of: assetsDirectory.path + "/", with: "")
			let destinationURL = outputDirectory.appendingPathComponent(relativePath)

			let destinationDir = destinationURL.deletingLastPathComponent()
			if !fileManager.fileExists(atPath: destinationDir.path) {
				try fileManager.createDirectory(at: destinationDir, withIntermediateDirectories: true)
			}

			try fileManager.copyItem(at: contentFile, to: destinationURL)

			if contentFile.pathExtension == "css" {
				let cssString = try String(contentsOf: contentFile)
				assetsHashes[contentFile.lastPathComponent] = cssString.md5Hash
			}
		}
	} catch {
		fatalError("\(#function): \(error)")
	}
}

func buildNotes() {
	var noteItems = JSONDecoder().decode([Note].self, from: "notes.json")

	noteItems = noteItems.map {
		var note = $0
		note.contentHtmlString = markdownParser.parse(note.markdown).html
		return note
	}
	.sorted(by: >)

	notes = noteItems

	let noteListPage = Page(
		path: "notes",
		layout: .list(title: "Notes"),
		updatedAt: noteItems.first?.publishedAt,
		contentHtmlString: documentRenderer.render(noteListDocument(notes: noteItems), withLinkSuffixes: true)
	)
	pages.append(noteListPage)
}

func buildPhotos() {
	photoCollections = [JSONDecoder().decode(PhotoCollection.self, from: "photos.json")]

	// Individual album pages
	for album in photoCollections {
		let albumPage = Page(
			path: "photos/\(album.slug)",
			layout: .list(title: album.title, description: album.content),
			updatedAt: nil,
			contentHtmlString: documentRenderer.render(photoGalleryDocument(photos: album), withLinkSuffixes: true)
		)
		pages.append(albumPage)
	}

	// Archive page listing all albums
	let archivePage = Page(
		path: "photos",
		layout: .list(title: "Photos"),
		updatedAt: nil,
		contentHtmlString: documentRenderer.render(photoArchiveDocument(albums: photoCollections), withLinkSuffixes: true)
	)
	pages.append(archivePage)
}

func buildLifeLessons() {
	let lessons = JSONDecoder().decode([LifeLesson].self, from: "life_lessons.json")
	let categories = lessons.reduce(into: [:]) { $0[$1.category, default: []].append($1) }

	let lifeLessonListPage = Page(
		path: "life-lessons",
		layout: .list(title: "Life lessons"),
		contentHtmlString: documentRenderer.render(lifeLessonListDocument(categories: categories), withLinkSuffixes: true)
	)
	pages.append(lifeLessonListPage)

	for (category, lessons) in categories {
		let contentHtmlString = lessons.map { lesson in
			let markdown = markdownParser.parse(lesson.markdown)
			let lessonDocument = Document(.html) {
				LifeLessonItem(lesson: lesson, contentHtmlString: markdown.html)
			}
			return documentRenderer.render(lessonDocument, withLinkSuffixes: true)
		}.joined()
		let page = Page(
			path: category.path,
			layout: .lifeLessonCategory(title: category.title, lessonCount: lessons.count),
			contentHtmlString: contentHtmlString
		)

		pages.append(page)
	}
}

func buildContent() async {
	do {
		let contentFiles = fileManager.walkDirectory(at: contentDirectory)
		for await contentFile in contentFiles {
			guard contentFile.pathExtension == "md" else {
				print("\(contentDirectory) only supports .md files; skipping \(contentFile.withoutRootPath)")
				continue
			}

			let page = try Page(from: contentFile)

			pages.append(page)

			if case .article = page.layout {
				articles.append(page)
			}
		}
	} catch {
		fatalError("\(#function): \(error)")
	}
}

func makePages() {
	do {
		pages.append(contentsOf: documentPages)

		for page in pages {
			try page.htmlString.writeToOutputDirectory(path: page.path, prettyURL: page.prettyURL)
		}
	} catch {
		fatalError("\(#function): \(error)")
	}
}

func makeFeed() {
	do {
		let rssString = documentRenderer.render(rssDocument)
		try rssString.writeToOutputDirectory(path: "feed.rss", prettyURL: false)
	} catch {
		fatalError("\(#function): \(error)")
	}
}
