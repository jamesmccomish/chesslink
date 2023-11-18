import { AccountAbstractionProvider } from "../contexts/account-abstraction-context";

const Providers = ({ children }: { children: JSX.Element }) => {
    return <AccountAbstractionProvider>{children}</AccountAbstractionProvider>;
};

export default Providers;
