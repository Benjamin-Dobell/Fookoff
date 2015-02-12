# Fookoff

An extremely simple SIMBL plugin to stop apps stealing focus.

At the moment the plugin is enabled for *all apps*, which is by no means ideal as it interferes with normal window swapping behaviour.

# Installation

Install EasySIMBL with [Homebrew](http://brew.sh/):

    brew install Caskroom/cask/easysimbl

Add a SIMBL plugins directory:

    mkdir "~/Library/Application Support/SIMBL/Plugins"


Compile the Fookoff.bundle by opening Fookoff.xcodeproj and building. Then copy the compiled Fookoff.bundle to ~/Library/Application Support/SIMBL/Plugins.

# TODO

* Make this user friendly.
* Add optional whitelist/blacklist files that can be used to enable or disable certain apps (by bundle identifier).
* Make this easy to install (say via Homebrew).

