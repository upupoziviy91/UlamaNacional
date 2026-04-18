import Foundation
import SwiftUI

enum AppData {
    static let rules: [RuleCard] = [
        RuleCard(title: "Narrow court", detail: "The court works like a long lane. Keeping the ball alive matters more than hitting hard.", systemImage: "rectangle.split.3x1"),
        RuleCard(title: "Hip strike", detail: "The traditional style uses the hip to drive the ball. Clean contact keeps the rhythm safe and readable.", systemImage: "figure.core.training"),
        RuleCard(title: "Points by error", detail: "A team scores when the opponent sends the ball out, misses the return, or breaks the agreed sequence.", systemImage: "plus.forwardslash.minus"),
        RuleCard(title: "Local agreement", detail: "Ulama varies by community. Before serve, set the target, valid zone, rotation, and foul rules.", systemImage: "person.3.sequence"),
        RuleCard(title: "Safe zone", detail: "Leave at least two steps free on each side. The ball can be heavier than a modern gym ball.", systemImage: "exclamationmark.shield"),
        RuleCard(title: "Rally first", detail: "For beginners, count clean rallies before adding match pressure.", systemImage: "repeat")
    ]

    static let topics: [InfoTopic] = [
        InfoTopic(title: "Suggested format", detail: "Play to 15, win by two. For school demos, use 7-minute blocks.", tag: "Match", systemImage: "timer"),
        InfoTopic(title: "Minimum kit", detail: "Center line, two side zones, a durable ball, and hip protection for beginners.", tag: "Gear", systemImage: "duffle.bag"),
        InfoTopic(title: "Club intro", detail: "Start with three rules: valid zone, allowed contact, and how a point is scored.", tag: "Onboarding", systemImage: "person.2.badge.gearshape"),
        InfoTopic(title: "Quick glossary", detail: "Rally: live exchange. Serve: agreed start. Foul: out ball, double hit, or invalid contact.", tag: "Guide", systemImage: "book.closed")
    ]

    static let drills: [Drill] = [
        Drill(title: "Stable hip line", duration: "8 min", focus: "Base and balance", steps: ["Mark a center line.", "Move side to side slowly.", "Finish each move with soft knees."], color: BrandPalette.yellow),
        Drill(title: "Short reaction", duration: "10 min", focus: "First step", steps: ["A partner points left or right.", "Answer with two quick steps.", "Return to center without crossing feet."], color: BrandPalette.sky),
        Drill(title: "Clean rally", duration: "12 min", focus: "Control", steps: ["Play for five clean contacts.", "Reduce power when control drops.", "Score only rallies without a fall."], color: BrandPalette.clay),
        Drill(title: "Breathe and rotate", duration: "6 min", focus: "Recovery", steps: ["Inhale before serve.", "Exhale on contact.", "Change roles every three rallies."], color: BrandPalette.cardSoft)
    ]

    static let venues: [Venue] = [
        Venue(city: "Mazatlan", country: "Mexico", note: "A living reference point for communities that keep modern ulama forms active.", tag: "History"),
        Venue(city: "Culiacan", country: "Mexico", note: "A strong setting for training logs, school events, and community showcases.", tag: "School"),
        Venue(city: "Guadalajara", country: "Mexico", note: "Useful for small clubs that want to invite new players into the sport.", tag: "Club"),
        Venue(city: "Mexico City", country: "Mexico", note: "A good stage for cultural events, museums, and sport activations.", tag: "Event")
    ]

    static let history: [HistoryItem] = [
        HistoryItem(period: "Before colonization", title: "Ritual and community play", detail: "Mesoamerican cultures practiced ball games with different rules, courts, and social meanings. It was not one uniform sport; it changed by region, period, and community.", systemImage: "sparkles"),
        HistoryItem(period: "16th-19th centuries", title: "Fragmented continuity", detail: "After the conquest, many practices changed, merged, or became less visible. Some forms survived through local memory, celebration, and competition.", systemImage: "leaf"),
        HistoryItem(period: "20th century", title: "Modern ulama", detail: "In parts of Sinaloa, living forms of the game remained active, especially hip-strike play. Transmission moved through families, neighborhoods, and community matches.", systemImage: "figure.core.training"),
        HistoryItem(period: "Today", title: "A living sport", detail: "Ulama can be presented in schools, clubs, festivals, and museums as a current practice: something people learn, train, and adapt with respect for its roots.", systemImage: "sportscourt")
    ]

    static let cultureNotes: [CultureNote] = [
        CultureNote(title: "Not just archaeology", detail: "Ulama gains power when it is practiced and explained as living culture, not only as an ancient image.", tag: "Key idea"),
        CultureNote(title: "Local rules matter", detail: "The app proposes simple starting formats, but each community can agree on serve, zone, and scoring variants.", tag: "Play"),
        CultureNote(title: "Safety first", detail: "The ball can be heavy. Beginners should use protection, lower intensity, and prioritize control.", tag: "Care"),
        CultureNote(title: "A strong event story", detail: "A demo works best with three layers: short history, guided practice, and a visible scoreboard.", tag: "Event")
    ]

    static let glossary: [GlossaryTerm] = [
        GlossaryTerm(term: "Ulama", meaning: "A modern name associated with living forms of the Mesoamerican ballgame."),
        GlossaryTerm(term: "Rally", meaning: "A live exchange where the ball remains in play between both sides."),
        GlossaryTerm(term: "Serve", meaning: "The agreed action that starts a point or rally."),
        GlossaryTerm(term: "Foul", meaning: "An error that breaks the sequence: out ball, invalid contact, or double hit, depending on local rules."),
        GlossaryTerm(term: "Court", meaning: "The long, narrow space where valid zone, center, and side areas are defined."),
        GlossaryTerm(term: "Hip strike", meaning: "A characteristic contact in one ulama style, used to return the ball.")
    ]

    static let quiz: [QuizQuestion] = [
        QuizQuestion(prompt: "What makes Ulama Nacional useful during a showcase?", options: ["Selling tickets", "Explaining rules and keeping score", "Streaming live video"], correctIndex: 1, explanation: "The app is built to explain the game, run a demo, and track points without a technical table."),
        QuizQuestion(prompt: "Why should ulama not be presented only as a museum piece?", options: ["Because it can also be practiced today", "Because it has no history", "Because it does not use a ball"], correctIndex: 0, explanation: "The core idea is living culture: history, training, and current play."),
        QuizQuestion(prompt: "What should be agreed before a match starts?", options: ["Jersey color only", "Target, valid zone, and allowed contact", "Photographer name"], correctIndex: 1, explanation: "Local variants matter, so target, zone, serve, and foul rules should be agreed before play."),
        QuizQuestion(prompt: "What does rally mean in the app?", options: ["A live exchange", "A host city", "An automatic foul"], correctIndex: 0, explanation: "A rally is the exchange while the ball stays in play."),
        QuizQuestion(prompt: "What is a good beginner recommendation?", options: ["Hit as hard as possible", "Prioritize control and safe space", "Play without explaining rules"], correctIndex: 1, explanation: "For learning, the app emphasizes control, free space, and safe progression."),
        QuizQuestion(prompt: "Where have modern forms of ulama remained active?", options: ["Only in Olympic stadiums", "In communities, especially associated with Sinaloa", "Only in video games"], correctIndex: 1, explanation: "Modern continuity is linked to local communities, with strong references in Sinaloa.")
    ]

    static func rules(for language: AppLanguage) -> [RuleCard] {
        guard language == .portugueseBrazil else { return rules }
        return [
            RuleCard(title: "Quadra estreita", detail: "A quadra funciona como uma faixa longa. Manter a bola viva importa mais do que bater forte.", systemImage: "rectangle.split.3x1"),
            RuleCard(title: "Golpe de quadril", detail: "A modalidade tradicional usa o quadril para impulsionar a bola. O contato limpo mantém o ritmo seguro e fácil de entender.", systemImage: "figure.core.training"),
            RuleCard(title: "Pontos por erro", detail: "Uma equipe pontua quando a outra manda a bola para fora, erra a devolução ou quebra a sequência combinada.", systemImage: "plus.forwardslash.minus"),
            RuleCard(title: "Acordo local", detail: "O ulama varia por comunidade. Antes do saque, defina meta, zona válida, rotação e faltas.", systemImage: "person.3.sequence"),
            RuleCard(title: "Zona segura", detail: "Deixe ao menos dois passos livres de cada lado. A bola pode ser mais pesada que uma bola moderna de ginásio.", systemImage: "exclamationmark.shield"),
            RuleCard(title: "Rally primeiro", detail: "Para iniciantes, conte rallies limpos antes de adicionar pressão de placar.", systemImage: "repeat")
        ]
    }

    static func topics(for language: AppLanguage) -> [InfoTopic] {
        guard language == .portugueseBrazil else { return topics }
        return [
            InfoTopic(title: "Formato sugerido", detail: "Jogue até 15, vencendo por dois. Para demos escolares, use blocos de 7 minutos.", tag: "Partida", systemImage: "timer"),
            InfoTopic(title: "Kit mínimo", detail: "Linha central, duas zonas laterais, bola resistente e proteção de quadril para iniciantes.", tag: "Equipamento", systemImage: "duffle.bag"),
            InfoTopic(title: "Entrada no clube", detail: "Comece com três regras: zona válida, contato permitido e como se marca ponto.", tag: "Boas-vindas", systemImage: "person.2.badge.gearshape"),
            InfoTopic(title: "Glossário rápido", detail: "Rally: troca viva. Saque: início combinado. Falta: bola fora, toque duplo ou contato inválido.", tag: "Guia", systemImage: "book.closed")
        ]
    }

    static func drills(for language: AppLanguage) -> [Drill] {
        guard language == .portugueseBrazil else { return drills }
        return [
            Drill(title: "Linha de quadril estável", duration: "8 min", focus: "Base e equilíbrio", steps: ["Marque uma linha central.", "Mova-se lateralmente devagar.", "Finalize cada movimento com joelhos flexíveis."], color: BrandPalette.yellow),
            Drill(title: "Reação curta", duration: "10 min", focus: "Primeiro passo", steps: ["Um parceiro aponta esquerda ou direita.", "Responda com dois passos rápidos.", "Volte ao centro sem cruzar os pés."], color: BrandPalette.sky),
            Drill(title: "Rally limpo", duration: "12 min", focus: "Controle", steps: ["Jogue por cinco contatos limpos.", "Reduza a força quando perder controle.", "Pontue apenas rallies sem queda."], color: BrandPalette.clay),
            Drill(title: "Respirar e rodar", duration: "6 min", focus: "Recuperação", steps: ["Inspire antes do saque.", "Expire no contato.", "Troque de função a cada três rallies."], color: BrandPalette.cardSoft)
        ]
    }

    static func venues(for language: AppLanguage) -> [Venue] {
        guard language == .portugueseBrazil else { return venues }
        return [
            Venue(city: "Mazatlán", country: "México", note: "Uma referência viva para comunidades que mantêm formas modernas de ulama ativas.", tag: "História"),
            Venue(city: "Culiacán", country: "México", note: "Um bom cenário para registros de treino, eventos escolares e demonstrações comunitárias.", tag: "Escola"),
            Venue(city: "Guadalajara", country: "México", note: "Útil para clubes pequenos que querem convidar novos jogadores para o esporte.", tag: "Clube"),
            Venue(city: "Cidade do México", country: "México", note: "Um palco forte para eventos culturais, museus e ativações esportivas.", tag: "Evento")
        ]
    }

    static func history(for language: AppLanguage) -> [HistoryItem] {
        guard language == .portugueseBrazil else { return history }
        return [
            HistoryItem(period: "Antes da colonização", title: "Jogo ritual e comunitário", detail: "Culturas mesoamericanas praticaram jogos de bola com regras, quadras e sentidos sociais diferentes. Não era um esporte uniforme; mudava por região, período e comunidade.", systemImage: "sparkles"),
            HistoryItem(period: "Séculos XVI-XIX", title: "Continuidade fragmentada", detail: "Depois da conquista, muitas práticas mudaram, se misturaram ou ficaram menos visíveis. Algumas formas sobreviveram pela memória local, celebração e competição.", systemImage: "leaf"),
            HistoryItem(period: "Século XX", title: "Ulama moderno", detail: "Em partes de Sinaloa, formas vivas do jogo permaneceram ativas, especialmente com golpe de quadril. A transmissão passou por famílias, bairros e partidas comunitárias.", systemImage: "figure.core.training"),
            HistoryItem(period: "Hoje", title: "Um esporte vivo", detail: "O ulama pode aparecer em escolas, clubes, festivais e museus como prática atual: algo que as pessoas aprendem, treinam e adaptam com respeito às raízes.", systemImage: "sportscourt")
        ]
    }

    static func cultureNotes(for language: AppLanguage) -> [CultureNote] {
        guard language == .portugueseBrazil else { return cultureNotes }
        return [
            CultureNote(title: "Não é só arqueologia", detail: "O ulama ganha força quando é praticado e explicado como cultura viva, não apenas como imagem antiga.", tag: "Ideia-chave"),
            CultureNote(title: "Regras locais importam", detail: "O app propõe formatos simples para começar, mas cada comunidade pode combinar variações de saque, zona e pontuação.", tag: "Jogo"),
            CultureNote(title: "Segurança primeiro", detail: "A bola pode ser pesada. Iniciantes devem usar proteção, reduzir intensidade e priorizar controle.", tag: "Cuidado"),
            CultureNote(title: "Uma boa narrativa de evento", detail: "Uma demo funciona melhor com três camadas: história curta, prática guiada e placar visível.", tag: "Evento")
        ]
    }

    static func glossary(for language: AppLanguage) -> [GlossaryTerm] {
        guard language == .portugueseBrazil else { return glossary }
        return [
            GlossaryTerm(term: "Ulama", meaning: "Nome moderno associado a formas vivas do jogo de bola mesoamericano."),
            GlossaryTerm(term: "Rally", meaning: "Troca viva em que a bola continua em jogo entre os dois lados."),
            GlossaryTerm(term: "Saque", meaning: "Ação combinada que inicia um ponto ou rally."),
            GlossaryTerm(term: "Falta", meaning: "Erro que quebra a sequência: bola fora, contato inválido ou toque duplo, conforme a regra local."),
            GlossaryTerm(term: "Quadra", meaning: "Espaço longo e estreito onde se definem zona válida, centro e laterais."),
            GlossaryTerm(term: "Golpe de quadril", meaning: "Contato característico de uma modalidade de ulama, usado para devolver a bola.")
        ]
    }

    static func quiz(for language: AppLanguage) -> [QuizQuestion] {
        guard language == .portugueseBrazil else { return quiz }
        return [
            QuizQuestion(prompt: "O que torna o Ulama Nacional útil durante uma demonstração?", options: ["Vender ingressos", "Explicar regras e marcar pontos", "Transmitir vídeo ao vivo"], correctIndex: 1, explanation: "O app foi feito para explicar o jogo, organizar uma demo e registrar pontos sem mesa técnica."),
            QuizQuestion(prompt: "Por que o ulama não deve ser apresentado só como peça de museu?", options: ["Porque também pode ser praticado hoje", "Porque não tem história", "Porque não usa bola"], correctIndex: 0, explanation: "A ideia central é cultura viva: história, treino e jogo atual."),
            QuizQuestion(prompt: "O que deve ser combinado antes de uma partida?", options: ["Apenas cor da camisa", "Meta, zona válida e contato permitido", "Nome do fotógrafo"], correctIndex: 1, explanation: "As variações locais importam; por isso meta, zona, saque e faltas devem ser definidos antes do jogo."),
            QuizQuestion(prompt: "O que significa rally no app?", options: ["Uma troca viva", "Uma cidade-sede", "Uma falta automática"], correctIndex: 0, explanation: "Rally é a troca enquanto a bola continua em jogo."),
            QuizQuestion(prompt: "Qual é uma boa recomendação para iniciantes?", options: ["Bater o mais forte possível", "Priorizar controle e espaço seguro", "Jogar sem explicar regras"], correctIndex: 1, explanation: "Para aprender, o app enfatiza controle, espaço livre e progressão segura."),
            QuizQuestion(prompt: "Onde formas modernas de ulama permaneceram ativas?", options: ["Só em estádios olímpicos", "Em comunidades, especialmente associadas a Sinaloa", "Só em videogames"], correctIndex: 1, explanation: "A continuidade moderna está ligada a comunidades locais, com referências fortes em Sinaloa.")
        ]
    }
}

@MainActor
final class MatchStore: ObservableObject {
    @Published var score: ScoreState {
        didSet { saveScore() }
    }

    @Published var logs: [MatchLog] {
        didSet { saveLogs() }
    }

    private let scoreKey = "ulama.nacional.score"
    private let logsKey = "ulama.nacional.logs"

    init() {
        if let data = UserDefaults.standard.data(forKey: scoreKey),
           let decoded = try? JSONDecoder().decode(ScoreState.self, from: data) {
            score = decoded
        } else {
            score = ScoreState()
        }

        if let data = UserDefaults.standard.data(forKey: logsKey),
           let decoded = try? JSONDecoder().decode([MatchLog].self, from: data) {
            logs = decoded
        } else {
            logs = []
        }
    }

    func addPoint(toHome: Bool) {
        if toHome {
            score.homeScore += 1
        } else {
            score.awayScore += 1
        }
        score.rallies += 1
        score.servingHome = toHome
        score.pointHistory.append(toHome)
    }

    func toggleServer() {
        score.servingHome.toggle()
    }

    func undoPoint() {
        guard score.rallies > 0 else { return }

        if let lastPointWasHome = score.pointHistory.popLast() {
            if lastPointWasHome {
                score.homeScore = max(0, score.homeScore - 1)
            } else {
                score.awayScore = max(0, score.awayScore - 1)
            }
            score.servingHome = score.pointHistory.last ?? true
        } else if score.homeScore >= score.awayScore, score.homeScore > 0 {
            score.homeScore = max(0, score.homeScore - 1)
        } else if score.awayScore > 0 {
            score.awayScore = max(0, score.awayScore - 1)
        }
        score.rallies = max(0, score.rallies - 1)
    }

    func saveMatch() {
        let log = MatchLog(
            id: UUID(),
            date: Date(),
            homeName: cleanTeamName(score.homeName, fallback: "Jaguar"),
            awayName: cleanTeamName(score.awayName, fallback: "Ceiba"),
            homeScore: score.homeScore,
            awayScore: score.awayScore
        )
        logs.insert(log, at: 0)
        score.homeScore = 0
        score.awayScore = 0
        score.rallies = 0
        score.servingHome = true
        score.pointHistory = []
    }

    func resetCurrentMatch() {
        score.homeScore = 0
        score.awayScore = 0
        score.rallies = 0
        score.servingHome = true
        score.pointHistory = []
    }

    func clearHistory() {
        logs = []
    }

    private func saveScore() {
        guard let data = try? JSONEncoder().encode(score) else { return }
        UserDefaults.standard.set(data, forKey: scoreKey)
    }

    private func saveLogs() {
        guard let data = try? JSONEncoder().encode(logs) else { return }
        UserDefaults.standard.set(data, forKey: logsKey)
    }

    private func cleanTeamName(_ value: String, fallback: String) -> String {
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? fallback : trimmed
    }
}
