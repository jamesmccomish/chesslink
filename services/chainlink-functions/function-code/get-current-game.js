const playerWhite = args[0]
const playerBlack = args[1]
const formatLichessGameResponse = (data) => {
    const lines = data.split('\n');
    let formattedDataObject = {};
    lines.forEach(line => {
        if (line.trim() === "") {
            return;
        }
        const [key, value] = line.slice(1, -1).split(' ');
        formattedDataObject[key] = value.replace(/['"]/g, '');
    });
    return formattedDataObject;
}
const lichessRequest = await Functions.makeHttpRequest({
    url: `https://lichess.org/api/user/${playerWhite}/current-game`,
})
if (lichessRequest.error) {
    console.log(JSON.stringify(lichessRequest, null, 2));
    throw new Error('Paraswap Request error')
}
const formattedDataObject = formatLichessGameResponse(await lichessRequest.data)
if (formattedDataObject.Black != playerBlack) throw new Error('Invalid Game: Players dont match!')
return Functions.encodeString(formattedDataObject.Site.split('/').at(-1))