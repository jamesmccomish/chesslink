import React from "react";
import styles from "../styles/Home.module.css";

export const HeaderBar = () => {
    return (
        <div className={styles.header_bar}>
            <h1 className={styles.title}>My App</h1>
            <div className={styles.header_buttons}>
                <button>Page 1</button>
                <button>Page 2</button>
                <button>Page 3</button>
            </div>
        </div>
    );
};
