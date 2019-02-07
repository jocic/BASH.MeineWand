# Meine Wand

[![Build Status](https://travis-ci.org/jocic/BASH.MeineWand.svg?branch=master)](https://travis-ci.org/jocic/BASH.MeineWand) [![Coverage Status](https://coveralls.io/repos/github/jocic/BASH.MeineWand/badge.svg?branch=master)](https://coveralls.io/github/jocic/BASH.MeineWand?branch=master) [![Codecov](https://codecov.io/gh/jocic/BASH.MeineWand/branch/master/graph/badge.svg)](https://codecov.io/gh/jocic/BASH.MeineWand) [![Codacy Badge](https://api.codacy.com/project/badge/Grade/b33d8a0308ee4f15b187a06c614cbd82)](https://www.codacy.com/app/jocic/BASH.MeineWand?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=jocic/BASH.MeineWand&amp;utm_campaign=Badge_Grade) [![License](https://poser.pugx.org/jocic/google-authenticator/license)](https://packagist.org/packages/jocic/google-authenticator)

Meine Wand was originally a collection of my personal scripts for Firewall management on Debian and Debian-based Linux distributions, but it evolved into a script that can be used for Firewall configuration, incident logging, etc.

**Project is still under development...slow ride...take it easy...**

![Help Example](images/help.png)

Script has been tested on the following distributions:

*   Ubuntu 18.04
*   Debian 9.5

[![Buy Me Coffee](images/buy-me-coffee.png)](https://www.paypal.me/DjordjeJocic)

## Alias

If you plan to use the script everyday, you should probably create an alias.

### Temporary Alias

```bash
alias meine-wand="/path/to/your/folder/meine-wand.sh"
```

### Permanent Alias

```bash
echo alias meine-wand="/path/to/your/folder/meine-wand.sh" >> ~/.bash_aliases
```

## Installation

Alternatively, you can add my personal APT repository to your machine and install **Meine Wand** like you would anything else.

Add the repository.

```bash
wget -nc https://www.djordjejocic.com/files/apt/Release.key
sudo apt-key add Release.key
sudo echo "deb http://apt.djordjejocic.com general main" >> "/etc/apt/sources.list"
sudo apt-get update
```

Install project.

```bash
sudo apt-get install meine-wand
```

## Contribution

Please review the following documents if you are planning to contribute to the project:

*   [Contributor Covenant Code of Conduct](code-of-conduct.md)
*   [Contribution Guidelines](contributing.md)
*   [Pull Request Template](pull-request-template.md)
*   [MIT License](license.md)

## Support

Please don't hessitate to contact me if you have any questions, ideas, or concerns.

My Twitter account is: [@jocic_91](https://www.twitter.com/jocic_91)

My support E-Mail address is: [support@djordjejocic.com](mailto:support@djordjejocic.com)

## Copyright & License

Copyright (C) 2019 Đorđe Jocić

Licensed under the MIT license.
