import Foundation
import SwiftHtml

func noteListDocument(notes: [Note]) -> Document {
	Document(.html) {
		VStack(alignment: .stretch, spacing: .s48) {
			for note in notes.sorted(by: >) {
				NoteItem(note: note, withPermalink: true)
			}
		}
	}
}
