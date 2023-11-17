import { LICHESS_API_URL } from './constants'

export async function fetcher({
    endpoint,
    token,
    post,
    body,
}: {
    endpoint: string
    token?: string
    post?: boolean
    body?: URLSearchParams
}) {

    const headers = {};

    if (token) {
        headers['Authorization'] = `Bearer ${token}`;
    }

    return (
        await fetch(`${LICHESS_API_URL}${endpoint}`, {
            headers,
            method: post ? 'POST' : 'GET',
            body,
        })
    ).json()
}