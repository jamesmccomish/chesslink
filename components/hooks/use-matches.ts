import { Address, useContractRead } from 'wagmi';
import { OPENFILE_CHESS_BETTING_ABI } from '../utils/abis/openfile-chess-betting';
import { OPENFILE_CHESS_BETTING_CONTRACT_ADDRESS } from '../utils/abis/constants';

import type { AbiParametersToPrimitiveTypes, ExtractAbiFunction, ExtractAbiFunctionNames, Abi } from 'abitype'


type FunctionNames = ExtractAbiFunctionNames<typeof OPENFILE_CHESS_BETTING_ABI, 'view'>

export type MatchesInputTypes = AbiParametersToPrimitiveTypes<
    ExtractAbiFunction<typeof OPENFILE_CHESS_BETTING_ABI, 'getAllMatches'>['inputs']
>

type MatchesOutputTypes = AbiParametersToPrimitiveTypes<
    ExtractAbiFunction<typeof OPENFILE_CHESS_BETTING_ABI, 'getAllMatches'>['outputs']
>

export const useMatches = () => {
    const { data, isError, isLoading } = useContractRead({
        address: OPENFILE_CHESS_BETTING_CONTRACT_ADDRESS,
        abi: OPENFILE_CHESS_BETTING_ABI,
        functionName: 'getAllMatches',
    })

    return {
        data,
        isError,
        isLoading,
    }
}
