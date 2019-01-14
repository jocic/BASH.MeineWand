# Meine Wand

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/b33d8a0308ee4f15b187a06c614cbd82)](https://www.codacy.com/app/jocic/BASH.MeineWand?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=jocic/BASH.MeineWand&amp;utm_campaign=Badge_Grade) [![License](https://poser.pugx.org/jocic/google-authenticator/license)](https://packagist.org/packages/jocic/google-authenticator)

Collection of personal scripts for Firewall management.

## Notes

**Note #1:** Some of these scripts may only work with my hardware, and some may look seemingly random. Once I upload my entire collection, I will start polishing & documenting them.

**Note #2:** Also, as I use TunnelBear (it was generally proven to be the best VPN available) you may notice that IP addresses of their servers are used in some scripts ex. the one for creating an Onion-like environment. I'll try to change that in the future and support other VPN providers ex. HMA, NordVPN, etc. BEAR with me for now.

**Note #3:** All scripts are POSIX-compliant.

## Usage

*   [init-basic.sh](src/init-basic.sh) Basic initialization script will activate UFW, remove existing rules, and set basic rules for Ubuntu distribution - denying inbound and outbound traffic except traffic to Google DNS servers and Ubuntu repositories in the United States. You can pass an interface as a parameter.
*   [init-advanced.sh](src/init-advanced.sh) Advanced initialization script will do everything as the basic one. In addition it will allow HTTP, HTTPS & Mail-related outbound traffic.
*   [check.sh](src/check.sh) Script is used for checking UFW status every second in a minute. If the UFW is inactive, all network interfaces are immediately shut down to prevent a potential breach. It should be ran by a CRON job.