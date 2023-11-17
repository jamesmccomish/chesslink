
import { fetcher } from './utils'

export class LichessClient {
    private fetcher: Function

    constructor(private readonly token?: string) {
        this.fetcher = (endpoint: string, post?: boolean, body?: URLSearchParams) =>
            fetcher({ endpoint, token: this.token, post, body })


    }

    async getUser(user: string): Promise<any> {
        console.log('getUser', user)
        return this.fetcher(`/user/${user}`)
    }

}