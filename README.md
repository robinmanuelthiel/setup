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

## Configure tools

### Command line

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

### Visual Studio Code

1. log in to Visual Studio Code with your GitHub Account and enable Settings Sync
2. If not already in the settings, copy the content of `.vscode/settings.json` to the settings JSON, which can be opened with (`CMD+Shift+P` -> `Preferences: Open Settings (JSON)`)
3. If not already in the key bindings, copy the content of `.vscode/keybindings.json` to the keybindings JSON, which can be opened with (`CMD+Shift+P` -> `Preferences: Open Keyboard Shortcuts (JSON)`)
4. Open this repository in Visual Studio code and install the recommended extensions

Add the following settings to enable the correct styling for Powerlevel10k in your Terminal:

```json
"terminal.integrated.fontFamily": "MesloLGS NF",
```

### Android Studio

Needs to be started once to install and configure the Android SDK tools.

### Karabiner-Elements

![](img/karabiner-1.png)

![](img/karabiner-2.png)

### iTerm

~~Allow Option + Arrow Keymappings: https://apple.stackexchange.com/a/293988~~

### Spotlight

To increase performance and reduce battery drain, remove the folder where you store the source code from Spotlight indexing.

<img width="780" alt="spotlight" src="https://user-images.githubusercontent.com/5874465/140032291-fdcf6c0d-c9c8-4df6-bb1e-e1c893a1ac9f.png">

## What needs to be installed manually

- [Microsoft Company Portal](https://go.microsoft.com/fwlink/?linkid=853070)
- [Segoe UI Font](https://developer.microsoft.com/en-us/fluentui#/resources) incl. [Segoe MDL2 Assets](https://learn.microsoft.com/en-us/windows/apps/design/style/segoe-ui-symbol-font)
- [Global Protect](https://microsoft.sharepoint.com/sites/Network_Connectivity/SitePages/RemoteAccess/GlobalProtect-Desktop-VPN-app-for-Mac.aspx)
- [Elgato Stream Deck Sonos Plugin](https://github.com/GenericMale/streamdeck-sonos)

## Setup a new device

In case, a new device needs to be set up, the following steps are requires

- [ ] Run Company Portal to Domain Join the device
- [ ] Configure Bitwarden
- [ ] Configure Authenticator (Auto-Start and Menu Bar)
- [ ] Add Internet Accounts to System Settings
- [ ] Import Raycast Backup
- [ ] Replace Spotlight Search with Raycast
- [ ] Add E-Mail Accounts to Outlook
- [ ] Adjust Notification Settings to Outlook
- [ ] Add and configure Extensions to the Browser(s)
- [ ] Configure Microsoft Teams Notification Settings
- [ ] Visual Studio Code Settings Sync
