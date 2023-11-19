import React from "react";
import styles from "./styles/Home.module.css";

import { useQuery } from "@tanstack/react-query";
import { Match, useMatches } from "../hooks/use-matches";
import { usePlayer } from "../hooks/use-player";
import { useBetOnMatch } from "../hooks/use-bet";

const MatchCard = ({ match, makeBet }: { match: Match; makeBet: (betCallback: any) => any }) => {
    return (
        <div
            style={{
                display: "flex",
                flexDirection: "column",
                justifyContent: "center",
                alignItems: "center",
                backgroundColor: "white",
                border: "1px solid #bacdd8",
                padding: "8px",
                margin: "10px",
                borderRadius: "12px",
                width: "100%",
            }}
        >
            <h2 style={{ fontSize: "24px", fontWeight: 600, marginTop: "16px" }}>{match?.description}</h2>
            <div
                style={{
                    display: "flex",
                    flexDirection: "row",
                    justifyContent: "center",
                    alignItems: "center",
                    width: "100%",
                    padding: "4px",
                }}
            >
                <p style={{ fontSize: "14px", color: "#7f8c9b", lineHeight: "150%" }}>{match?.player1}</p>
                <button
                    onClick={() => makeBet(match?.player1)}
                    style={{ fontSize: "14px", color: "#7f8c9b", lineHeight: "150%", margin: "8px" }}
                >
                    {"BET"}
                </button>
            </div>
            <p style={{ fontSize: "14px", color: "#7f8c9b", lineHeight: "150%" }}>vs</p>
            <div
                style={{
                    display: "flex",
                    flexDirection: "row",
                    justifyContent: "center",
                    alignItems: "center",
                    width: "100%",
                    padding: "4px",
                }}
            >
                <p style={{ fontSize: "14px", color: "#7f8c9b", lineHeight: "150%" }}>{match?.player2}</p>
                <button
                    onClick={() => makeBet(match?.player2)}
                    style={{ fontSize: "14px", color: "#7f8c9b", lineHeight: "150%", margin: "8px" }}
                >
                    {"BET"}
                </button>
            </div>
        </div>
    );
};

export const Matches = () => {
    const { data: matches, isLoading } = useMatches();
    const { write: bet } = useBetOnMatch();

    const [loadedMatches, setloadedMatches] = React.useState<Match[]>();

    React.useEffect(() => {
        if (!isLoading) setloadedMatches(matches);
    }, [isLoading]);

    const betCallback = React.useCallback(
        (a: any) => {
            bet({ args: [a, BigInt(1)] });
        },
        [bet]
    );

    return (
        <div className={styles.container}>
            <div className={styles.matches_page}>
                <div className={styles.section_info}>
                    <p className={styles.section_info_title}>Matches</p>
                    <p className={styles.section_info_text}>Check out all live matches and bet 0.1eth!</p>
                </div>
                <div className={styles.matches_list}>
                    {!loadedMatches ? (
                        <p>Loading...</p>
                    ) : (
                        matches?.map((m) => {
                            return <MatchCard match={m} makeBet={betCallback} />;
                        })
                    )}
                </div>
            </div>
        </div>
    );
};
