import { Address, useContractWrite } from 'wagmi';
import { OPENFILE_CHESS_BETTING_ABI } from '../utils/abis/openfile-chess-betting';
import { OPENFILE_CHESS_BETTING_CONTRACT_ADDRESS } from '../utils/abis/constants';

import type { AbiParametersToPrimitiveTypes, ExtractAbiFunction, ExtractAbiFunctionNames, Abi } from 'abitype'

type FunctionNames = ExtractAbiFunctionNames<typeof OPENFILE_CHESS_BETTING_ABI, 'view'>

export type TmpCreateMatchInputTypes = AbiParametersToPrimitiveTypes<
    ExtractAbiFunction<typeof OPENFILE_CHESS_BETTING_ABI, 'tmpCreateMatch'>['inputs']
>

type TmpCreateMatchOutputTypes = AbiParametersToPrimitiveTypes<
    ExtractAbiFunction<typeof OPENFILE_CHESS_BETTING_ABI, 'tmpCreateMatch'>['outputs']
>

export const useCreateMatch = () => {
    const { data, isError, isLoading, write } = useContractWrite({
        address: OPENFILE_CHESS_BETTING_CONTRACT_ADDRESS,
        abi: OPENFILE_CHESS_BETTING_ABI,
        functionName: 'tmpCreateMatch',
    })

    return {
        data,
        isError,
        isLoading,
        write,
    }
}
