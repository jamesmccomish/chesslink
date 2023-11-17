import React from "react";
import styles from "../styles/Home.module.css";

export const Player = () => {
    return (
        <div className={styles.container}>
            <div className={styles.player_section}>
                <div className={styles.section_info}>
                    <p className={styles.section_info_title}>Details</p>
                    <p className={styles.section_info_text}>Deploy your own player contract, or check out your stats</p>
                </div>
                <div className={styles.top_section_right}>
                    <p className={styles.info_field_text}>Contract:</p>
                    <p className={styles.info_field_text}>Holders:</p>
                    <p className={styles.info_field_text}>Matches:</p>
                </div>
            </div>

            <div className={styles.player_section}>
                <div className={styles.section_info}>
                    <p className={styles.section_info_title}>Matches</p>
                    <p className={styles.section_info_text}>Check out your past matches, or deploy another</p>
                </div>
                <div className={styles.matches_section}>
                    <p className={styles.card}>Wins:</p>
                    <p className={styles.card}>Losses:</p>
                    <p className={styles.card}>Ties:</p>
                    <p className={styles.card}>Ties:</p>
                    <p className={styles.card}>Ties:</p>
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
