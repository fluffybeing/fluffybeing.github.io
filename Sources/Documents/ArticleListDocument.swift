import SwiftHtml

let articleListDocument = Document(.html) {
	VStack(alignment: .stretch, spacing: .s32) {
		for page in articles.sorted(by: >) {
			ArticleItem(page: page)
		}
	}
}
