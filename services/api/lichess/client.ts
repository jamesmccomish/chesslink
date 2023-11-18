
import { fetcher } from './utils'

// enum GameStatus {
//     "created",
//     "started",
//     "aborted",
//     "mate",
//     "resign",
//     "stalemate",
//     "timeout",
//     "draw",
//     "outoftime",
//     "cheat",
//     "noStart",
//     "unknownFinish",
//     "variantEnd"
// }

export class LichessClient {
    private fetcher: Function

    constructor(private readonly token?: string) {
        this.fetcher = (params: any) =>
            fetcher(params)
    }

    async getUser(user: string): Promise<any> {
        return this.fetcher({ endpoint: `/user/${user}` })
    }

    async getCurrentGame(user: string): Promise<any> {
        return this.fetcher({ endpoint: `/user/${user}/current-game` })
    }

    async getGame(gameId: string): Promise<any> {
        return this.fetcher({ endpoint: `/game/${gameId}` })
    }
}