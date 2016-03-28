# zombie-zoo

# how to use

1. clone the v3quick-classic
https://github.com/tangyiyang/v3quick-classic

2. enter v3quick-classic root, and run  `sh setup_mac.sh`

3. [optional] if you want to build the player yourself, you need set a variable in XCode-Options-Locations
   
   varname is `QUICK_V3_ROOT`, path is `where you download v3quick-classic`
   
4. once you setup and run the player, you may use `cmd+w` to see examples.

5. lanuch the project through cmdline. I prefer an alias set to the ~/.bash_profile.
`alias zz='${where you put v3quick-classic}/v3quick-classic/player3.app/Contents/MacOS/player3 -size 640x1136 -workdir ${where you put this project} -scale 0.5 -disable-console'`
