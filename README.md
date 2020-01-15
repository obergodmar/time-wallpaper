# Time Wallpaper
This script allows you to change wallpaper by time. For example, if time between 6 am and 10 am, the wallpaper set to `morning.jpg`. You can use script directly or start a `systemctl unit`.

### Table of Contents
- [Demonstration](#demonstration)
- [Usage](#usage)
- [Changelog](#changelog)

## Demonstration
![Demo](demo.gif)
## Usage
### Dependencies
*Time wallpaper supports only KDE.*

Time check uses `dateutils`, so you need to install it.

___
### Installation
1. Define your wallpaper set and change time in `time-wallpaper.sh`.
2. Put `time-wallpaper-user.service` to your `~/.config/systemd/user/` directory.
3. Enable and start service: 
```bash
$ systemctl --user enable time-wallpaper-user.service
$ systemctl --user start time-wallpaper-user.service
```
4. You can check the status by using `systemctl` or `journalctl`:
```bash
$ systemctl --user status time-wallpaper-user.service
$ journalctl -xe --user
```
___
### Usage
```bash
$ ./time-wallpaper.sh -h

Usage: ./time-wallpaper.sh [option]
Options:
        -h              output usage information
        -q              quiet mode
```
To stop and disable `systemctl unit`:
```bash
$ systemctl --user disable time-wallpaper-user.service
$ systemctl --user stop time-wallpaper-user.service
```
## Changelog
### 15.01.20 
* Initial Commit