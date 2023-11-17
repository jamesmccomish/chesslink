import React from "react";
import styles from "../styles/Home.module.css";

export const HeaderBar = () => {
    return (
        <div className={styles.header_bar}>
            <h1 className={styles.title}>My App</h1>
            <div className={styles.header_buttons}>
                <a href="/" className={styles.header_button}>
                    Home
                </a>
                <a href="player" className={styles.header_button}>
                    Player
                </a>
                <a href="matches" className={styles.header_button}>
                    Matches
                </a>
            </div>
        </div>
    );
};
