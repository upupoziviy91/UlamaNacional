import SwiftUI

struct MatchCenterView: View {
    @EnvironmentObject private var store: MatchStore
    @State private var showingResetAlert = false
    @AppStorage("app.language") private var languageRawValue = AppLanguage.english.rawValue

    private var language: AppLanguage {
        AppLanguage.from(languageRawValue)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    NacionalHeader(
                        eyebrow: language == .portugueseBrazil ? "Placar offline" : "Offline scoreboard",
                        title: language == .portugueseBrazil ? "Conduza a partida sem mesa técnica." : "Run the match without a technical table.",
                        subtitle: language == .portugueseBrazil ? "Registre rallies, salve resultados e mantenha um histórico local do clube." : "Track rallies, save results, and keep a local club history."
                    )

                    howItWorks
                    names
                    matchSetup
                    scoreboard
                    matchStatus
                    controls
                    refereeNotes

                    SectionTitle(title: language == .portugueseBrazil ? "Histórico" : "History", detail: language == .portugueseBrazil ? "Partidas salvas neste dispositivo." : "Matches saved on this device.")

                    if store.logs.isEmpty {
                        EmptyStateCard(
                            title: language == .portugueseBrazil ? "Nenhuma partida salva" : "No saved matches",
                            systemImage: "clock.badge.questionmark",
                            detail: language == .portugueseBrazil ? "Salve o primeiro placar quando o jogo terminar." : "Save the first score when the game ends."
                        )
                    } else {
                        VStack(spacing: 10) {
                            ForEach(store.logs) { log in
                                historyRow(log)
                            }
                        }
                    }
                }
                .padding(20)
                .padding(.bottom, 88)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(BrandPalette.navy.ignoresSafeArea())
            .navigationTitle(Copy.scoreTab(language))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(language == .portugueseBrazil ? "Reiniciar" : "Reset") {
                        showingResetAlert = true
                    }
                    .disabled(store.score.homeScore == 0 && store.score.awayScore == 0)
                }
            }
            .alert(language == .portugueseBrazil ? "Reiniciar placar" : "Reset scoreboard", isPresented: $showingResetAlert) {
                Button(language == .portugueseBrazil ? "Cancelar" : "Cancel", role: .cancel) {}
                Button(language == .portugueseBrazil ? "Reiniciar" : "Reset", role: .destructive) {
                    store.resetCurrentMatch()
                }
            } message: {
                Text(language == .portugueseBrazil ? "O histórico salvo não será apagado." : "Saved match history will not be deleted.")
            }
        }
    }

    private var howItWorks: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label(language == .portugueseBrazil ? "Como funciona" : "How it works", systemImage: "playbook")
                .font(.headline)
                .foregroundStyle(BrandPalette.yellow)

            VStack(alignment: .leading, spacing: 7) {
                useStep("1", language == .portugueseBrazil ? "Escolha a meta da partida." : "Choose the match target.")
                useStep("2", language == .portugueseBrazil ? "Marque quem tem o saque." : "Mark the current server.")
                useStep("3", language == .portugueseBrazil ? "Some cada ponto e salve o resultado final." : "Add each point and save the final result.")
            }

            Text(language == .portugueseBrazil ? "Use em demonstrações, jogos de treino e partidas pequenas sem papel." : "Use it for showcases, training games, and small matches without paper sheets.")
                .font(.footnote)
                .foregroundStyle(BrandPalette.secondaryText)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(BrandPalette.card)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }

    private var names: some View {
        VStack(spacing: 12) {
            TextField(language == .portugueseBrazil ? "Equipe A" : "Team A", text: $store.score.homeName)
                .textFieldStyle(.plain)
                .padding(14)
                .foregroundStyle(BrandPalette.white)
                .background(BrandPalette.card)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                .submitLabel(.done)
            TextField(language == .portugueseBrazil ? "Equipe B" : "Team B", text: $store.score.awayName)
                .textFieldStyle(.plain)
                .padding(14)
                .foregroundStyle(BrandPalette.white)
                .background(BrandPalette.card)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                .submitLabel(.done)
        }
    }

    private var matchSetup: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(language == .portugueseBrazil ? "Configuração do Jogo" : "Game Setup")
                .font(.headline)
                .foregroundStyle(BrandPalette.white)

            Picker(language == .portugueseBrazil ? "Meta" : "Target", selection: $store.score.targetScore) {
                Text("7").tag(7)
                Text("11").tag(11)
                Text("15").tag(15)
                Text("21").tag(21)
            }
            .pickerStyle(.segmented)

            HStack(spacing: 12) {
                serverBadge(name: store.score.homeName, isActive: store.score.servingHome)
                serverBadge(name: store.score.awayName, isActive: !store.score.servingHome)
            }

            Button {
                store.toggleServer()
            } label: {
                Label(language == .portugueseBrazil ? "Trocar saque" : "Switch server", systemImage: "arrow.left.arrow.right")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .tint(BrandPalette.yellow)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(BrandPalette.card)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }

    private var scoreboard: some View {
        HStack(spacing: 12) {
            scorePanel(name: store.score.homeName, score: store.score.homeScore, color: BrandPalette.yellow)
            scorePanel(name: store.score.awayName, score: store.score.awayScore, color: BrandPalette.sky)
        }
    }

    private var matchStatus: some View {
        let leader = leadingText
        let remaining = pointsToClose

        return HStack(spacing: 12) {
            StatPill(value: "\(store.score.targetScore)", label: language == .portugueseBrazil ? "meta" : "target")
            StatPill(value: "\(remaining)", label: language == .portugueseBrazil ? "para fechar" : "to close")

            VStack(spacing: 5) {
                Text(leader)
                    .font(.headline)
                    .foregroundStyle(BrandPalette.white)
                    .lineLimit(2)
                    .minimumScaleFactor(0.72)
                    .multilineTextAlignment(.center)
                Text(language == .portugueseBrazil ? "status" : "status")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(BrandPalette.secondaryText)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(BrandPalette.card)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
    }

    private var controls: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                Button {
                    store.addPoint(toHome: true)
                } label: {
                    Text("+ \(shortName(store.score.homeName))")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(BrandPalette.navy)
                        .lineLimit(1)
                        .minimumScaleFactor(0.72)
                }
                .buttonStyle(.borderedProminent)
                .tint(BrandPalette.yellow)

                Button {
                    store.addPoint(toHome: false)
                } label: {
                    Text("+ \(shortName(store.score.awayName))")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(BrandPalette.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.72)
                }
                .buttonStyle(.borderedProminent)
                .tint(BrandPalette.sky)
            }

            HStack(spacing: 12) {
                Button(language == .portugueseBrazil ? "Desfazer" : "Undo") {
                    store.undoPoint()
                }
                .buttonStyle(.bordered)
                .disabled(store.score.rallies == 0)

                Button(language == .portugueseBrazil ? "Salvar partida" : "Save match") {
                    store.saveMatch()
                }
                .buttonStyle(.borderedProminent)
                .disabled(store.score.homeScore == 0 && store.score.awayScore == 0)
            }

            Text(language == .portugueseBrazil ? "\(store.score.rallies) rallies registrados" : "\(store.score.rallies) rallies recorded")
                .font(.footnote.weight(.semibold))
                .foregroundStyle(BrandPalette.secondaryText)
        }
    }

    private var refereeNotes: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label(language == .portugueseBrazil ? "Notas de Arbitragem" : "Referee Notes", systemImage: "list.clipboard")
                .font(.headline)
                .foregroundStyle(BrandPalette.yellow)

            Text(language == .portugueseBrazil ? "Antes do saque, confirme limite de pontos, zona válida, contato permitido e se uma falta troca o saque ou concede ponto direto." : "Before serve, confirm the point limit, valid zone, allowed contact, and whether a foul changes serve or awards a direct point.")
                .font(.subheadline)
                .foregroundStyle(BrandPalette.secondaryText)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(BrandPalette.card)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }

    private var leadingText: String {
        let home = store.score.homeScore
        let away = store.score.awayScore
        let target = store.score.targetScore

        if hasWinner {
            return home > away ? (language == .portugueseBrazil ? "\(shortName(store.score.homeName)) vence" : "\(shortName(store.score.homeName)) wins") : (language == .portugueseBrazil ? "\(shortName(store.score.awayName)) vence" : "\(shortName(store.score.awayName)) wins")
        }

        if max(home, away) >= target {
            if home == away { return language == .portugueseBrazil ? "Empate alto" : "High tie" }
            return home > away ? (language == .portugueseBrazil ? "Vantagem \(shortName(store.score.homeName))" : "\(shortName(store.score.homeName)) advantage") : (language == .portugueseBrazil ? "Vantagem \(shortName(store.score.awayName))" : "\(shortName(store.score.awayName)) advantage")
        }

        if home == away { return language == .portugueseBrazil ? "Empatado" : "Tied" }
        return home > away ? (language == .portugueseBrazil ? "\(shortName(store.score.homeName)) lidera" : "\(shortName(store.score.homeName)) leads") : (language == .portugueseBrazil ? "\(shortName(store.score.awayName)) lidera" : "\(shortName(store.score.awayName)) leads")
    }

    private var hasWinner: Bool {
        let high = max(store.score.homeScore, store.score.awayScore)
        let lead = abs(store.score.homeScore - store.score.awayScore)
        return high >= store.score.targetScore && lead >= 2
    }

    private var pointsToClose: Int {
        if hasWinner { return 0 }
        let high = max(store.score.homeScore, store.score.awayScore)
        if high >= store.score.targetScore { return 1 }
        return max(0, store.score.targetScore - high)
    }

    private func useStep(_ number: String, _ text: String) -> some View {
        HStack(alignment: .top, spacing: 9) {
            Text(number)
                .font(.caption.weight(.black))
                .foregroundStyle(BrandPalette.navy)
                .frame(width: 22, height: 22)
                .background(BrandPalette.yellow)
                .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
            Text(text)
                .font(.subheadline)
                .foregroundStyle(BrandPalette.white)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private func serverBadge(name: String, isActive: Bool) -> some View {
        HStack(spacing: 7) {
            Circle()
                .fill(isActive ? BrandPalette.yellow : Color(.systemGray4))
                .frame(width: 10, height: 10)
            Text(shortName(name))
                .font(.subheadline.weight(.semibold))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(isActive ? BrandPalette.cardSoft : BrandPalette.deepNavy)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .accessibilityLabel(isActive ? (language == .portugueseBrazil ? "\(name) tem o saque" : "\(name) has serve") : (language == .portugueseBrazil ? "\(name) não tem o saque" : "\(name) does not have serve"))
    }

    private func scorePanel(name: String, score: Int, color: Color) -> some View {
        VStack(spacing: 10) {
            Text(name.isEmpty ? (language == .portugueseBrazil ? "Equipe" : "Team") : name)
                .font(.headline)
                .foregroundStyle(BrandPalette.white)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            Text("\(score)")
                .font(.system(size: 72, weight: .black, design: .rounded))
                .foregroundStyle(BrandPalette.white)
                .monospacedDigit()
                .frame(height: 84)
            Text(score == 1 ? (language == .portugueseBrazil ? "ponto" : "point") : (language == .portugueseBrazil ? "pontos" : "points"))
                .font(.caption.weight(.semibold))
                .foregroundStyle(BrandPalette.secondaryText)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(BrandPalette.card)
        .overlay(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(color.opacity(0.34), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }

    private func historyRow(_ log: MatchLog) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("\(log.homeName) \(log.homeScore) - \(log.awayScore) \(log.awayName)")
                    .font(.headline)
                    .lineLimit(2)
                Text("\(Copy.winnerPrefix(language)): \(log.winner(language: language))")
                    .font(.subheadline)
                    .foregroundStyle(BrandPalette.secondaryText)
            }
            Spacer()
            Text(log.date, style: .date)
                .font(.caption.weight(.semibold))
                .foregroundStyle(BrandPalette.secondaryText)
        }
        .padding(14)
        .background(BrandPalette.card)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }

    private func shortName(_ name: String) -> String {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? (language == .portugueseBrazil ? "Equipe" : "Team") : trimmed
    }
}
