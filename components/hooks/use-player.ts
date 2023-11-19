import { useContractRead } from 'wagmi';
import { OPENFILE_CHESS_BETTING_ABI } from '../utils/abis/openfile-chess-betting';
import { OPENFILE_CHESS_BETTING_CONTRACT_ADDRESS } from '../utils/abis/constants';
import { PLAYER_ABI } from '../utils/abis/player';

export const usePlayer = (playerAddress: any) => {
    const { data, isError, isLoading } = useContractRead({
        address: playerAddress,
        abi: PLAYER_ABI,
        functionName: 'uri',
        args: [BigInt(0)],
    })

    //const
    console.log({ data })

    return {
        data,
        isError,
        isLoading,
    }
}
