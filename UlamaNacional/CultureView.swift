import SwiftUI

struct CultureView: View {
    @EnvironmentObject private var store: MatchStore
    @State private var showingClearAlert = false
    @State private var quizIndex = 0
    @State private var selectedAnswer: Int?
    @State private var correctAnswers = 0
    @AppStorage("app.language") private var languageRawValue = AppLanguage.english.rawValue

    private var language: AppLanguage {
        AppLanguage.from(languageRawValue)
    }

    private var quiz: [QuizQuestion] {
        AppData.quiz(for: language)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    NacionalHeader(
                        eyebrow: language == .portugueseBrazil ? "Rede Nacional" : "National Network",
                        title: language == .portugueseBrazil ? "Quadras pequenas, memória grande." : "Small courts, deep memory.",
                        subtitle: language == .portugueseBrazil ? "Um espaço para apresentar o ulama como esporte vivo, não como peça estática de museu." : "A place to present ulama as a living sport, not a static museum piece."
                    )

                    languagePicker

                    Image("Ball")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .frame(height: 170)
                        .padding(.vertical, 12)
                        .background(BrandPalette.card)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .accessibilityLabel("Ulama ball")

                    SectionTitle(title: language == .portugueseBrazil ? "Por Que Importa" : "Why It Matters", detail: language == .portugueseBrazil ? "Uma leitura rápida para explicar o jogo antes de uma demo." : "A quick read for explaining the game before a demo.")

                    VStack(spacing: 12) {
                        ForEach(AppData.cultureNotes(for: language)) { note in
                            cultureNoteRow(note)
                        }
                    }

                    SectionTitle(title: language == .portugueseBrazil ? "História Curta" : "Short History", detail: language == .portugueseBrazil ? "Da memória mesoamericana à prática comunitária atual." : "From Mesoamerican memory to current community practice.")

                    VStack(spacing: 12) {
                        ForEach(AppData.history(for: language)) { item in
                            historyRow(item)
                        }
                    }

                    quizCard

                    SectionTitle(title: language == .portugueseBrazil ? "Glossário" : "Glossary", detail: language == .portugueseBrazil ? "Palavras úteis para explicar uma primeira prática." : "Useful words for explaining a first practice.")

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        ForEach(AppData.glossary(for: language)) { term in
                            glossaryCard(term)
                        }
                    }

                    SectionTitle(title: language == .portugueseBrazil ? "Mapa Editorial" : "Editorial Map", detail: language == .portugueseBrazil ? "Lugares sugeridos para ativar uma comunidade." : "Suggested places for activating a community.")

                    VStack(spacing: 12) {
                        ForEach(AppData.venues(for: language)) { venue in
                            venueRow(venue)
                        }
                    }

                    SectionTitle(title: language == .portugueseBrazil ? "Privacidade" : "Privacy", detail: language == .portugueseBrazil ? "O placar e o histórico ficam apenas neste dispositivo." : "The scoreboard and history live only on this device.")

                    Button(language == .portugueseBrazil ? "Apagar histórico local" : "Delete local history", role: .destructive) {
                        showingClearAlert = true
                    }
                    .buttonStyle(.bordered)
                    .disabled(store.logs.isEmpty)
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(BrandPalette.navy.ignoresSafeArea())
            .navigationTitle(Copy.nationalTab(language))
            .navigationBarTitleDisplayMode(.inline)
            .alert(language == .portugueseBrazil ? "Apagar histórico" : "Delete history", isPresented: $showingClearAlert) {
                Button(language == .portugueseBrazil ? "Cancelar" : "Cancel", role: .cancel) {}
                Button(language == .portugueseBrazil ? "Apagar" : "Delete", role: .destructive) {
                    store.clearHistory()
                }
            } message: {
                Text(language == .portugueseBrazil ? "Isso remove as partidas salvas deste dispositivo." : "This removes saved matches from this device.")
            }
        }
    }

    private var languagePicker: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(language == .portugueseBrazil ? "Idioma do app" : "App Language")
                .font(.headline)
                .foregroundStyle(BrandPalette.white)

            Picker(language == .portugueseBrazil ? "Idioma" : "Language", selection: $languageRawValue) {
                ForEach(AppLanguage.allCases) { language in
                    Text(language.displayName).tag(language.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: languageRawValue) { _ in
                quizIndex = 0
                selectedAnswer = nil
                correctAnswers = 0
            }
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(BrandPalette.card)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }

    private var quizCard: some View {
        let question = quiz[quizIndex]
        let answered = selectedAnswer != nil

        return VStack(alignment: .leading, spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Quiz Nacional")
                        .font(.title3.weight(.black))
                        .foregroundStyle(BrandPalette.white)
                    Text(language == .portugueseBrazil ? "Pergunta \(quizIndex + 1) de \(quiz.count) · \(correctAnswers) corretas" : "Question \(quizIndex + 1) of \(quiz.count) · \(correctAnswers) correct")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(BrandPalette.secondaryText)
                }
                Spacer()
                Image(systemName: "questionmark.circle.fill")
                    .font(.title2)
                    .foregroundStyle(BrandPalette.yellow)
            }

            Text(question.prompt)
                .font(.headline)
                .foregroundStyle(BrandPalette.white)
                .fixedSize(horizontal: false, vertical: true)

            VStack(spacing: 10) {
                ForEach(question.options.indices, id: \.self) { index in
                    Button {
                        guard selectedAnswer == nil else { return }
                        selectedAnswer = index
                        if index == question.correctIndex {
                            correctAnswers += 1
                        }
                    } label: {
                        HStack(spacing: 10) {
                            Image(systemName: answerIcon(for: index, question: question))
                                .font(.headline)
                            Text(question.options[index])
                                .font(.subheadline.weight(.semibold))
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer(minLength: 0)
                        }
                        .padding(12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(answerBackground(for: index, question: question))
                        .foregroundStyle(answerForeground(for: index, question: question))
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                    .buttonStyle(.plain)
                }
            }

            if answered {
                Text(question.explanation)
                    .font(.footnote)
                    .foregroundStyle(BrandPalette.secondaryText)
                    .fixedSize(horizontal: false, vertical: true)

                Button(quizIndex == quiz.count - 1 ? (language == .portugueseBrazil ? "Reiniciar quiz" : "Restart quiz") : (language == .portugueseBrazil ? "Próxima pergunta" : "Next question")) {
                    advanceQuiz()
                }
                .buttonStyle(.borderedProminent)
                .tint(BrandPalette.yellow)
                .foregroundStyle(BrandPalette.navy)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(BrandPalette.card)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }

    private func cultureNoteRow(_ note: CultureNote) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(note.tag.uppercased())
                .font(.caption2.weight(.black))
                .foregroundStyle(BrandPalette.yellow)
            Text(note.title)
                .font(.headline)
                .foregroundStyle(BrandPalette.white)
            Text(note.detail)
                .font(.subheadline)
                .foregroundStyle(BrandPalette.secondaryText)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(BrandPalette.card)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }

    private func historyRow(_ item: HistoryItem) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: item.systemImage)
                .font(.headline)
                .foregroundStyle(BrandPalette.navy)
                .frame(width: 38, height: 38)
                .background(BrandPalette.yellow)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

            VStack(alignment: .leading, spacing: 5) {
                Text(item.period.uppercased())
                    .font(.caption2.weight(.black))
                    .foregroundStyle(BrandPalette.yellow)
                Text(item.title)
                    .font(.headline)
                    .foregroundStyle(BrandPalette.white)
                Text(item.detail)
                    .font(.subheadline)
                    .foregroundStyle(BrandPalette.secondaryText)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 0)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(BrandPalette.card)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }

    private func glossaryCard(_ term: GlossaryTerm) -> some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(term.term)
                .font(.headline)
                .foregroundStyle(BrandPalette.yellow)
            Text(term.meaning)
                .font(.caption)
                .foregroundStyle(BrandPalette.secondaryText)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(12)
        .frame(maxWidth: .infinity, minHeight: 116, alignment: .topLeading)
        .background(BrandPalette.card)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }

    private func venueRow(_ venue: Venue) -> some View {
        HStack(alignment: .top, spacing: 12) {
            VStack {
                Text(venue.tag)
                    .font(.caption.weight(.black))
                    .foregroundStyle(BrandPalette.navy)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 6)
                    .background(BrandPalette.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                Spacer(minLength: 0)
            }

            VStack(alignment: .leading, spacing: 5) {
                Text("\(venue.city), \(venue.country)")
                    .font(.headline)
                    .foregroundStyle(BrandPalette.white)
                Text(venue.note)
                    .font(.subheadline)
                    .foregroundStyle(BrandPalette.secondaryText)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 0)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(BrandPalette.card)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }

    private func answerIcon(for index: Int, question: QuizQuestion) -> String {
        guard let selectedAnswer else { return "circle" }
        if index == question.correctIndex { return "checkmark.circle.fill" }
        if index == selectedAnswer { return "xmark.circle.fill" }
        return "circle"
    }

    private func answerBackground(for index: Int, question: QuizQuestion) -> Color {
        guard let selectedAnswer else { return BrandPalette.deepNavy }
        if index == question.correctIndex { return Color.green.opacity(0.16) }
        if index == selectedAnswer { return Color.red.opacity(0.13) }
        return BrandPalette.deepNavy
    }

    private func answerForeground(for index: Int, question: QuizQuestion) -> Color {
        guard let selectedAnswer else { return BrandPalette.white }
        if index == question.correctIndex { return .green }
        if index == selectedAnswer { return .red }
        return BrandPalette.secondaryText
    }

    private func advanceQuiz() {
        if quizIndex == quiz.count - 1 {
            quizIndex = 0
            correctAnswers = 0
        } else {
            quizIndex += 1
        }
        selectedAnswer = nil
    }
}
