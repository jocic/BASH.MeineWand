# Meine Wand

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/b33d8a0308ee4f15b187a06c614cbd82)](https://www.codacy.com/app/jocic/BASH.MeineWand?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=jocic/BASH.MeineWand&amp;utm_campaign=Badge_Grade) [![License](https://poser.pugx.org/jocic/google-authenticator/license)](https://packagist.org/packages/jocic/google-authenticator)

Collection of personal scripts for Firewall management.

## Notes

**Note #1:** As I use TunnelBear (it was generally proven to be the best VPN available) you may notice that IP addresses of their servers are used in some scripts ex. the one for creating an Onion-like environment. I'll try to change that in the future and support other VPN providers ex. HMA, NordVPN, etc. BEAR with me for now.

**Note #2:** All scripts are POSIX-compliant.

## Cheatsheet

Available general chains:

*   INPUT
*   OUTPUT
*   FORWARD

Available NAT chains:

*   PREROUTING
*   POSTROUTING
*   OUTPUT

## General Scripts

*   **init-basic.sh** Basic initialization script will activate UFW, remove existing rules, and set basic rules for Ubuntu distribution - denying inbound and outbound traffic except traffic to Google DNS servers and Ubuntu repositories in the United States. You can pass an interface as a parameter.

[NetFilter](src/nf/init-basic.sh) [UFW](src/ufw/init-basic.sh)

```bash
bash ./init-basic.sh all|network-interface
```

*   **init-advanced.sh** Advanced initialization script will do everything as the basic one. In addition it will allow HTTP, HTTPS & Mail-related outbound traffic.

[NetFilter](src/nf/init-advanced.sh) [UFW](src/ufw/init-advanced.sh)

```bash
bash ./init-advanced.sh all|network-interface
```

*   **sandbox.sh** Sandboxing script allows you to create an environment in which only traffic toward specific online services is allowed - Twitter, GitHub, LinkedIn & GoDaddy (UK). All inbound and outbound traffic that isn't related to the mentioned services is blocked, even DNS-related traffic.

[NetFilter](src/nf/sandbox.sh) [UFW](src/ufw/sandbox.sh)

```bash
bash ./sandbox.sh all|network-interface
```

*   **onion.sh** This script is used for creating an onion-like environment by utilizing 2 or more VPN servers of your desired VPN provider. Number of physical or virtual machines depends on the number layers you selected.

[NetFilter](src/nf/onion.sh) [UFW](src/ufw/onion.sh)

```bash
bash ./sandbox.sh all|network-interface vpn-interface vpn-ip-address
```

## UFW Scripts

*   **check.sh** Script is used for checking UFW status every second in a minute. If the UFW is inactive, all network interfaces are immediately shut down to prevent a potential breach. It should be ran by a CRON job.

[Script](src/ufw/check.sh)

```bash
* * * * * bash /location/to/script/check.sh &
```