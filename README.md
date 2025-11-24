# Machine Setup

My personal collection of configuration files.

## Install XCode

It's recommended to install XCode before installing all other applications, because some of them depend on XCode.

The best way to install XCode is not via Store.

1. [Download XCode](https://developer.apple.com/download/all/?q=Xcode)
1. Run `xip -x Xcode_14.2.xip` to unzip
1. Move the Xcode file to the Applications folder

Needs to be started once to accept the license.

## Install [homebrew](https://brew.sh/)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Install all other applications with homebrew

Use the Brewfile from this repository to install all applications.

```bash
brew bundle --file ./Brewfile
```

After installing, the Brewfile, some additional steps need to be sorted out.

```bash
# To manage multiple .NET versions, reinstall the old ones
brew reinstall dotnet-sdk3-1-400
# brew reinstall dotnet-sdk...
```

## Install Node

```bash
# Install current Node.js TLS version via NVM
nvm install --lts
nvm use --lts
```

## Configure Command line

```bash
# Copy config from this repository to the home directory
cp .zshrc ~
```

Open Shell to install the correct font. (All other settings will be overwritten later.) If it doesn't ask you for a font, you can run

```bash
p10k configure
```

Copy the Powerlevel10k config over

```bash
cp .p10k.zsh ~
```

## What needs to be installed manually

- [Microsoft Company Portal](https://go.microsoft.com/fwlink/?linkid=853070)
- [Segoe UI Font](https://developer.microsoft.com/en-us/fluentui#/resources) incl. [Segoe MDL2 Assets](https://learn.microsoft.com/en-us/windows/apps/design/style/segoe-ui-symbol-font)
- [Global Protect](https://microsoft.sharepoint.com/sites/Network_Connectivity/SitePages/RemoteAccess/GlobalProtect-Desktop-VPN-app-for-Mac.aspx)
- [Elgato Stream Deck Sonos Plugin](https://github.com/GenericMale/streamdeck-sonos) _(might require system restart before is works)_
- [Dee Gateway](https://www.dotec-audio.com/deegate.html) for Microphone
- [VM Ware Fusion](https://support.broadcom.com/group/ecx/productfiles?subFamily=VMware%20Fusion&displayGroup=VMware%20Fusion%2013&release=13.6.2&os=&servicePk=526671&language=EN&freeDownloads=true)
- [Live-Server](https://www.npmjs.com/package/live-server) (via NPM) `npm install -g live-server`
- [Shure Motiv Mix](https://www.shure.com/de-CH/produkte/software/motiv-mix?variant=MOTIV%2520Mix)
- Activate corepack for Yarn support: `corepack enable`

## Setup a new device

In case, a new device needs to be set up, the following steps are requires

- [ ] Run Company Portal to Domain Join the device
- [ ] Set the [System and Application Settings](SETTINGS.md)
