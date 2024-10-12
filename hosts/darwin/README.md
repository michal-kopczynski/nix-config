# MacOS setup

## Install Nix
1. Not with official installer but instead with
https://github.com/DeterminateSystems/nix-installer

2. Check if it is working
nix run "nixpkgs#hello"

3. If there is an error
error: unable to download 'https://channels.nixos.org/flake-registry.json': SSL peer certificate or SSH remote key was not OK (60)

Follow this guide:
https://github.com/NixOS/nix/issues/8081#issuecomment-1962419263

```
Got the same issue on my company mac M1 laptop that uses netskope to "secure" internet traffic(doing man-in-the-middle using company certificate). I guess many companies uses similar proxy software that will break nix the same way. I was able to fix the installation by following those steps ( based on last post in https://discourse.nixos.org/t/ssl-ca-cert-error-on-macos/31171/6)
Run the installer that will fail due to SSL errors, and then fix the install by:
1. First you generate a new bundle containing all your custom certificates to be used by nix
security export -t certs -f pemseq -k /Library/Keychains/System.keychain -o /tmp/certs-system.pem
security export -t certs -f pemseq -k /System/Library/Keychains/SystemRootCertificates.keychain -o /tmp/certs-root.pem
cat /tmp/certs-root.pem /tmp/certs-system.pem > /tmp/ca_cert.pem
sudo mv /tmp/ca_cert.pem /etc/nix/

2. Update the conf file /etc/nix/nix.conf to reference the bundle
ssl-cert-file = /etc/nix/ca_cert.pem

3. Relaunch the daemon
sudo launchctl unload /Library/LaunchDaemons/org.nixos.nix-daemon.plist
sudo launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist

You should now be able to resume the install by running the command displayed at the end of the installer output
sudo -i nix-channel --update nixpkgs
```

# Enable flakes
cat <<EOF > ~/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF

Add this line to your /etc/nix/nix.conf file
experimental-features = nix-command flakes


## Install nix-darwin (set of nix modules that you can use to manage your MacOS environment)
https://github.com/LnL7/nix-darwin/blob/master/README.md#step-2-installing-nix-darwin
Enter nix-darwin directory and run
nix run nix-darwin -- switch --flake .
nix run nix-darwin --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake .

* bu some files if needed as prompt to
* Answer to questions
Change the defaults -> N
Manage channels -> Y
Load darwin configuration in bash/zshrc -> Y


## git clone nixos-config repository
git clone git@github.com:michal-kopczynski/nixos-config.git

And install configuration
make build



To rebuild nix config run:
darwin-rebuild switch --flake .


# Set up OS




## NEW VERSION Remaping MacOs keys to be similar as on Linux

## Keyboard layout
Whenever asked choose ANSI

## Remap keys (settings -> keyboard -> keyboard shortcuts -> modifier keys)
* for USB keyboard 
caps lock -> escape (consider hyper key instead?)
control -> command
option -> option
command -> control

* For internal keyboard
caps lock -> escape
control -> command
option -> control
command -> option
(consider switching command and fn(global)

Result: Command ⌘ (Ctrl) | Control ^ (Win) | Alt ⌥ (Alt)


## Enable shortcuts to switch to different desktops/spaces
(settings -> keyboard -> keyboard shortcuts -> mission control -> mission control)
Note: first need to create those desktops (Win + up arrow and create desktops)
Set Shortcut to Ctrl+number for all desktop

## Spotlight search
Remap to ^Space or consider other launchers (i.e. Raycast)

# Disable changing input source shortcut 

# Disable emoji search shortcut (Command + Ctrl + space)
TODO

# In Raycast settings change launch shortcut to ^ + space

## Additional setting

## Desktop setting
* Disable "Automatically rearange Spaces based on most recent use
* Disable "Displays have seperate spaces"?
* Disable "Group windows by application"

## iTerm2 setup
* remap keys (control -> command, command -> control)
* but in order to allow the system switch desktop shortcuts to work
    * (Keys -> Key Bindings) -> "+" - add Don ot Remap Modifiers for ^Space, ^AltSpace, ^0, ^1, ^<- etc
    * See: https://gitlab.com/gnachman/iterm2/-/issues/8135
    * Also check option with sending HexCodes?
* Disable closing with WIN(Control) + W TODO?
* Disable Navigation shorcuts
* Create new profile (i.e. tmux), set as acive, in Keys -> General -> Set "Left Option Key" -> Esc+
* iTerm2 when it’s active doesn’t allow to switch another desktop with shortcut TODO

# TODO:
* skhd not working
* do we want to manage home-brew with Nix (only for Casks)? Seems ok, bu it blocks use of brew from command line to i.e. search packages?
* yabai - do we really need to disable SIP? Seems to be working enough with SIP enabled-> but check with skid working

## Articles:
* https://heywoodlh.io/linux-macos-setup
Config:
https://github.com/heywoodlh/nixos-builds/blob/master/darwin/wm.nix

* (not followed but looks nice)
https://juliu.is/tidying-your-home-with-nix/

* https://www.reddit.com/r/Nix/comments/zdcteb/should_i_migrate_from_homebrew_to_nix/




# Goland
* Disable Search man page Index in Terminal https://intellij-support.jetbrains.com/hc/en-us/articles/360005137400-Cmd-Shift-A-hotkey-opens-Terminal-with-apropos-search-instead-of-the-Find-Action-dialog
