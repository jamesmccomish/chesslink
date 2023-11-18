import { LICHESS_API_URL } from './constants';

export async function fetcher({
    endpoint,
    method = 'GET',
    body,
    headers: additionalHeaders = {},
}: {
    endpoint: string
    method?: 'GET' | 'POST' | 'PUT' | 'DELETE'
    body?: URLSearchParams
    headers?: Record<string, string>
}) {

    const headers = new Headers(additionalHeaders);

    //console.log({ endpoint, method, body, headers })

    const response = await fetch(`${LICHESS_API_URL}${endpoint}`, {
        headers: { 'Content-Type': 'application/json' },
        method,
        body,
    });

    // console.log({ response })

    if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
    }

    // if the response can be .json(), return it
    if (response.headers.get('Content-Type')?.includes('application/json')) {
        return await response.json();
    }

    // else format the text respone
    return formatStringResponses(await response.text());

}

// TODO improve handling of this and correctly type lichess responses
const formatStringResponses = (text: string) => {
    const lines = text.split('\n');
    let data = {};

    console.log({ lines })

    lines.forEach(line => {
        if (line.trim() === "") {
            return;
        }
        const [key, value] = line.slice(1, -1).split(' ');
        data[key] = value.replace(/"/g, '');
    });

    console.log(data);

    return data;
}
