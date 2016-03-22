platform=$1
filename=$2
DST_DIR_ROOT_ANDROID=${ZOMBIE_ZOO_CLIENT_ROOT}/tmp/res_android/${filename}
DST_DIR_ROOT_IOS=${ZOMBIE_ZOO_CLIENT_ROOT}/tmp/res_ios/${filename}
texturepacker=/Applications/TexturePacker.app/Contents/MacOS/TexturePacker
if [ "$platform" = "android" ]; then
	echo buiding Resources Android start
	mkdir -p ${DST_DIR_ROOT_ANDROID}
	rm -rf ${filename}.png ${filename}.plist 
	${texturepacker} --data ${filename}.plist  --allow-free-size --algorithm MaxRects --maxrects-heuristics best --shape-padding 2 --border-padding 0 --padding 0 --inner-padding 0 --disable-rotation --opt RGBA8888 --dither-none-nn --dpi 72 --format cocos2d ../${filename} --sheet ${filename}.png
	mv ${filename}.plist ${filename}.png ${DST_DIR_ROOT_ANDROID}
	echo @@@@ building common resource done!
fi
	
if [ "$platform" = "ios" ]; then
	echo buiding Resources ios start
	mkdir -p ${DST_DIR_ROOT_IOS}
	rm -rf ${filename}.pvr.ccz ${filename}.plist 
	${texturepacker} --texture-format pvr2ccz --data ${filename}.plist  --allow-free-size --algorithm MaxRects --maxrects-heuristics best --shape-padding 2 --border-padding 0 --padding 0 --inner-padding 0 --disable-rotation --opt PVRTC4 --dither-none-nn --dpi 72 --format cocos2d ../${filename} --sheet ${filename}.pvr.ccz
	mv ${filename}.plist ${filename}.pvr.ccz ${DST_DIR_ROOT_IOS}
	echo @@@@ building common resource done!
fi
	