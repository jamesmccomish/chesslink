import React from "react";
import styles from "./styles/Home.module.css";

import { useQuery } from "@tanstack/react-query";

import { LichessClient } from "../../services/api/lichess/client";
import { useCreateMatch } from "../hooks/use-create-match";

const lichessClient = new LichessClient();

export const Player = () => {
    const { data, isLoading, error } = useQuery({
        queryKey: "todos",
        //queryFn: () => lichessClient.getUser("jamco535"),
        //queryFn: () => lichessClient.getGame("q7ZvsdUF"), // api example finished game
        queryFn: () => lichessClient.getCurrentGame("jamtest"),
    });

    console.log({ data });

    const { write } = useCreateMatch();

    return (
        <div className={styles.container}>
            <div className={styles.player_section}>
                <div className={styles.section_info}>
                    <p className={styles.section_info_title}>Details</p>
                    <p className={styles.section_info_text}>Deploy your own player contract, or check out your stats</p>
                </div>
                <div className={styles.top_section_right}>
                    {/* // TODO link to api and get deployed player for connected address */}
                    <span className={styles.info_field_text}>Contract:</span>
                    <span className={styles.section_info_text}>0x508d15a8A798c72a33557ddE529209ff5c9DCfb8</span>
                    <p className={styles.info_field_text}>Holders: 1</p>
                    <p className={styles.info_field_text}>Matches: 1</p>
                </div>
            </div>

            <div className={styles.player_section}>
                <div className={styles.section_info}>
                    <p className={styles.section_info_title}>Matches</p>
                    <p className={styles.section_info_text}>Check out your past matches, or deploy another</p>
                </div>
                <div className={styles.section_info}>
                    <div className={styles.matches_section}>
                        <div className={styles.card}>
                            {data && data.Termination != "Abandoned" ? (
                                <div
                                    style={{
                                        display: "flex",
                                        flexDirection: "column",
                                        justifyContent: "center",
                                        alignItems: "center",
                                    }}
                                >
                                    <h2 className={styles.info_field_text}>Current Game:</h2>
                                    <h2 className={styles.section_info_title}>{data?.White}</h2>
                                    <p className={styles.section_info_text}>vs</p>
                                    <h2 className={styles.section_info_title}>{data?.Black}</h2>
                                    <button
                                        onClick={() =>
                                            write({
                                                args: [
                                                    data?.White as string,
                                                    data?.White as string,
                                                    data?.Date.replaceAll(".", "") as bigint,
                                                    data?.Opening as string,
                                                ],
                                            })
                                        }
                                    >
                                        DEPLOY MATCH
                                    </button>
                                </div>
                            ) : (
                                <h2 className={styles.section_info_title}>No Current Game </h2>
                            )}
                        </div>
                    </div>
                </div>
            </div>

            <div className={styles.player_section}>
                <div className={styles.section_info}>
                    <p className={styles.section_info_title}>Market</p>
                    <p className={styles.section_info_text}>Check out the other players you can buy!</p>
                </div>
                <div className={styles.matches_section}>
                    <p className={styles.card}>Wins:</p>
                    <p className={styles.card}>Losses:</p>
                    <p className={styles.card}>Ties:</p>
                    <p className={styles.card}>Ties:</p>
                    <p className={styles.card}>Ties:</p>
                </div>
            </div>
        </div>
    );
};
