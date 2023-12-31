import "../components/ui/styles/globals.css";
import "@rainbow-me/rainbowkit/styles.css";
import { getDefaultWallets, RainbowKitProvider } from "@rainbow-me/rainbowkit";
import type { AppProps } from "next/app";
import { configureChains, createConfig, WagmiConfig } from "wagmi";
import { goerli, polygonMumbai } from "wagmi/chains";
import { publicProvider } from "wagmi/providers/public";
import { Layout } from "../components/ui/Layout";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";

import Providers from "../components/providers/providers";
import { createPublicClient, http } from "viem";

const { chains, publicClient, webSocketPublicClient } = configureChains([polygonMumbai], [publicProvider()]);

const { connectors } = getDefaultWallets({
    appName: "RainbowKit App",
    projectId: "YOUR_PROJECT_ID",
    chains,
});

const wagmiConfig = createConfig({
    autoConnect: true,
    connectors,
    publicClient,
    webSocketPublicClient,
});

const queryClient = new QueryClient();

function MyApp({ Component, pageProps }: AppProps) {
    return (
        <WagmiConfig config={wagmiConfig}>
            <RainbowKitProvider chains={chains}>
                <Providers>
                    <QueryClientProvider client={queryClient}>
                        <Layout>
                            <Component {...pageProps} />
                        </Layout>
                    </QueryClientProvider>
                </Providers>
            </RainbowKitProvider>
        </WagmiConfig>
    );
}

export default MyApp;
