# udm-strongswan
StrongSwan podman container for Unifi routers.

For usage, please see the StrongSwan section in the [split-vpn project](https://github.com/peacey/split-vpn#how-do-i-use-this).

This container uses an entry script to start StrongSwan configs from a specific directory, then watches the connections and restarts them on disconnect or failure. Please see [start.sh](https://github.com/peacey/udm-strongswan/blob/main/start.sh) for details.
