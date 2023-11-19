import React from "react";
import { HeaderBar } from "./Header";
import styles from "./styles/Home.module.css";

export const Layout = ({ children }) => {
    return (
        <div className={styles.layout}>
            <HeaderBar />
            <div className="content">{children}</div>
            <footer className={styles.footer}>
                <a href="https://rainbow.me" rel="noopener noreferrer" target="_blank">
                    copied from your frens at 🌈
                </a>
            </footer>
        </div>
    );
};
