import SwiftUI

struct OnboardingView: View {
    let onFinish: () -> Void

    @AppStorage("app.language") private var languageRawValue = AppLanguage.english.rawValue
    @State private var selection = 0

    private var language: AppLanguage {
        AppLanguage.from(languageRawValue)
    }

    private var pages: [OnboardingPage] {
        [
            OnboardingPage(
                icon: "sportscourt",
                imageName: "Field",
                title: language == .portugueseBrazil ? "Monte uma quadra em minutos." : "Set up a court in minutes.",
                detail: language == .portugueseBrazil ? "Use o guia para explicar zona de jogo, bola, saque e regras básicas antes da primeira partida." : "Use the guide to explain the play zone, ball, serve, and basic rules before the first match."
            ),
            OnboardingPage(
                icon: "plus.forwardslash.minus",
                imageName: nil,
                title: language == .portugueseBrazil ? "Controle o placar sem papel." : "Run the score without paper.",
                detail: language == .portugueseBrazil ? "Defina a meta, marque o saque, some pontos, desfaça erros e salve o resultado no histórico local." : "Set the target, mark the server, add points, undo mistakes, and save the result to local history."
            ),
            OnboardingPage(
                icon: "questionmark.circle",
                imageName: "Ball",
                title: language == .portugueseBrazil ? "Aprenda com treino e quiz." : "Learn with drills and quizzes.",
                detail: language == .portugueseBrazil ? "Siga uma sessão curta, leia a história do jogo e teste o grupo com perguntas rápidas." : "Follow a short session, read the game's story, and test the group with quick questions."
            )
        ]
    }

    var body: some View {
        VStack(spacing: 18) {
            header

            TabView(selection: $selection) {
                ForEach(pages.indices, id: \.self) { index in
                    pageView(pages[index])
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .frame(maxWidth: .infinity)

            controls
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 22)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BrandPalette.navy.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("NACIONAL")
                        .font(.caption.weight(.black))
                        .foregroundStyle(BrandPalette.yellow)
                    Text(language == .portugueseBrazil ? "Primeiros passos" : "First steps")
                        .font(.title.weight(.black))
                        .foregroundStyle(BrandPalette.white)
                }

                Spacer()

                Picker(language == .portugueseBrazil ? "Idioma" : "Language", selection: $languageRawValue) {
                    ForEach(AppLanguage.allCases) { language in
                        Text(language.rawValue == "pt-BR" ? "PT" : "EN").tag(language.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 112)
            }

            Text(language == .portugueseBrazil ? "Um app offline para apresentar, ensinar e conduzir partidas de ulama." : "An offline app for presenting, teaching, and running ulama matches.")
                .font(.body)
                .foregroundStyle(BrandPalette.secondaryText)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func pageView(_ page: OnboardingPage) -> some View {
        VStack(spacing: 18) {
            visual(for: page)

            VStack(alignment: .leading, spacing: 12) {
                Label {
                    Text(page.title)
                        .font(.title2.weight(.black))
                        .foregroundStyle(BrandPalette.white)
                        .fixedSize(horizontal: false, vertical: true)
                } icon: {
                    Image(systemName: page.icon)
                        .font(.headline)
                        .foregroundStyle(BrandPalette.navy)
                        .frame(width: 34, height: 34)
                        .background(BrandPalette.yellow)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                }

                Text(page.detail)
                    .font(.body)
                    .foregroundStyle(BrandPalette.secondaryText)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(BrandPalette.card)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

            Spacer(minLength: 0)
        }
        .padding(.top, 8)
        .padding(.bottom, 36)
    }

    @ViewBuilder
    private func visual(for page: OnboardingPage) -> some View {
        if let imageName = page.imageName {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 220)
                .clipped()
                .overlay(alignment: .bottomLeading) {
                    Text(language == .portugueseBrazil ? "Guia pronto para clube, escola e demo" : "Ready for club, school, and demos")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(BrandPalette.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(BrandPalette.navy.opacity(0.78))
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .padding(12)
                }
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        } else {
            VStack(spacing: 14) {
                HStack(spacing: 12) {
                    scoreTile(name: language == .portugueseBrazil ? "Equipe A" : "Team A", score: "08", color: BrandPalette.yellow)
                    scoreTile(name: language == .portugueseBrazil ? "Equipe B" : "Team B", score: "06", color: BrandPalette.sky)
                }

                HStack(spacing: 10) {
                    Image(systemName: "arrow.left.arrow.right")
                    Text(language == .portugueseBrazil ? "Troque saque e salve partidas" : "Switch server and save matches")
                }
                .font(.subheadline.weight(.bold))
                .foregroundStyle(BrandPalette.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(BrandPalette.cardSoft)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
            .padding(14)
            .frame(maxWidth: .infinity)
            .frame(height: 220)
            .background(BrandPalette.card)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
    }

    private func scoreTile(name: String, score: String, color: Color) -> some View {
        VStack(spacing: 8) {
            Text(name)
                .font(.caption.weight(.bold))
                .foregroundStyle(BrandPalette.secondaryText)
            Text(score)
                .font(.system(size: 54, weight: .black, design: .rounded))
                .monospacedDigit()
                .foregroundStyle(BrandPalette.white)
            Text(language == .portugueseBrazil ? "pontos" : "points")
                .font(.caption.weight(.semibold))
                .foregroundStyle(BrandPalette.secondaryText)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 18)
        .background(color.opacity(0.18))
        .overlay(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(color.opacity(0.42), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }

    private var controls: some View {
        VStack(spacing: 12) {
            Button {
                if selection < pages.count - 1 {
                    withAnimation(.easeInOut) {
                        selection += 1
                    }
                } else {
                    onFinish()
                }
            } label: {
                Text(selection == pages.count - 1 ? (language == .portugueseBrazil ? "Começar" : "Start") : (language == .portugueseBrazil ? "Continuar" : "Continue"))
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 4)
            }
            .buttonStyle(.borderedProminent)
            .tint(BrandPalette.yellow)
            .foregroundStyle(BrandPalette.navy)

            Button(language == .portugueseBrazil ? "Pular introdução" : "Skip intro") {
                onFinish()
            }
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(BrandPalette.secondaryText)
        }
    }
}

private struct OnboardingPage {
    let icon: String
    let imageName: String?
    let title: String
    let detail: String
}
