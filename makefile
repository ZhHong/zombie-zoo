.PHONY:all ccb cfg android ios create_extra_folders proto

ccb:fonts
	mkdir -p res/ccb
	cd tools && sh ccb2json.sh ../res/ccb && cd ..
fonts:
	# covert to json
	plutil -convert json raw/spritebuilder_zombie-zoo.spritebuilder/Packages/SpriteBuilder\ Resources.sbpack/Strings.ccbLang -o raw/fonts/Strings.json
	cp raw/fonts/Strings.json res/fonts/
cfg:
	make -C raw/config_raw
	rm -rf res/config/*
	mkdir -p res/config
	cp ${ZOMBIE_ZOO_CLIENT_ROOT}/tmp/res_android/config/* ${ZOMBIE_ZOO_CLIENT_ROOT}/res/config
	cp ${ZOMBIE_ZOO_CLIENT_ROOT}/tmp/res_ios/config/* ${ZOMBIE_ZOO_CLIENT_ROOT}/res/config
run-1:
	sed -i '' 's/\("debug_account_id": \)\(.*\)/\11/g' debug_config.json; 
	${QUICK_V3_ROOT}/player3.app/Contents/MacOS/player3 -workdir ${ZOMBIE_ZOO_CLIENT_ROOT}/ -file src/main.lua -size 720x1280 -scale 0.5; 
run-2:
	sed -i '' 's/\("debug_account_id": \)\(.*\)/\12/g' debug_config.json;
	${QUICK_V3_ROOT}/player3.app/Contents/MacOS/player3 -workdir ${ZOMBIE_ZOO_CLIENT_ROOT}/ -file src/main.lua -size 720x1280 -scale 0.5;
tmx:
	make -C raw tmx
	mkdir -p res/tmx
	cp ${ZOMBIE_ZOO_CLIENT_ROOT}/tmp/res_ios/tmx/* ${ZOMBIE_ZOO_CLIENT_ROOT}/res/tmx
proto:
	mkdir -p src/app/share
	-rm -rf ./src/app/share/*.lua
	ln ${ZOMBIE_ZOO_SERVER_ROOT}/share/game_proto.lua ./src/app/share/game_proto.lua
	ln ${ZOMBIE_ZOO_SERVER_ROOT}/share/consts.lua ./src/app/share/consts.lua
	ln ${ZOMBIE_ZOO_SERVER_ROOT}/share/error_code.lua ./src/app/share/error_code.lua
all:android 
	
android:clean create_extra_folders 
	mkdir -p res
	make -C raw android

	#TODO: auto copy someday
	cd ./tmp/res_android && pwd \
	&& find ./ -name 'map*.plist' -exec mv {} ./images \; \
	&& find ./ -name 'map*.png' -exec mv {} ./images \; \
	&& find ./ -name 'thumbnails*.png' -exec mv {} ./images \; \
	&& find ./ -name 'thumbnails*.plist' -exec mv {} ./images \; \
	&& find ./ -name 'ui*.png' -exec mv {} ./images \; \
	&& find ./ -name 'ui*.plist' -exec mv {} ./images \; \
	&& find ./ -name 'level*.png' -exec mv {} ./images \; \
	&& find ./ -name 'level*.plist' -exec mv {} ./images \; \
	&& find ./ -name 'effects*.png' -exec mv {} ./images \; \
	&& find ./ -name 'effects*.plist' -exec mv {} ./images \; \
	&& find ./ -name 'demo*.png' -exec mv {} ./images \; \
	&& find ./ -name 'demo*.plist' -exec mv {} ./images \; \
	&& find ./ -name 'ghost*.png' -exec mv {} ./images \; \
	&& find ./ -name 'ghost*.plist' -exec mv {} ./images \; \
	&& rm -rf map_* \
	&& rm -rf level* \
	&& rm -rf ui* \
	&& rm -rf thumbnails* \
	&& rm -rf effects* \
	&& rm -rf demo* \
	&& rm -rf ghost* \

	@echo  ---- Copy the files
	-rm -rf ./res/*
	cp -r ./tmp/res_android/* ./res
ios:clean create_extra_folders
	make -C raw ios
	# cp -r ./tmp/res_ios/* ./res
spine-filelist:
	ls res/spine/ | grep .json > res/spine/spine_files.txt	
clean:
	rm -rf ./tmp/*
zip:
	sh ${QUICK_V3_ROOT}/quick/bin/compile_scripts.sh -i ${ZOMBIE_ZOO_CLIENT_ROOT}/src/ -o ${ZOMBIE_ZOO_CLIENT_ROOT}/res/game.zip -ek "_FF#@LEAVL_M0X" -es levelmax

create_extra_folders:
	mkdir -p ./tmp/res_android/images
	mkdir -p ./tmp/res_ios/images
	
