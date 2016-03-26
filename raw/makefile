.PHONY: common android ios tmx
tmpdir=../tmp
android:common
	make -C effects android
	make -C ui android
	make -C level android
	make -C thumbnails android
	make -C unpack
	make -C demo
	make -C actor
	make -C fonts

ios:common
	make -C effects android
	make -C ui ios
	make -C level ios
	make -C thumbnails ios
	make -C tile_map_image target=ios
	make -C unpack
	make -C demo
	make -C actor

common:
	make -C config_raw
	
	#copy the bgms and effects
	mkdir -p $(tmpdir)/res_android/sounds
	mkdir -p $(tmpdir)/res_ios/sounds
	cp -r ./sounds/* $(tmpdir)/res_android/sounds
	cp -r ./sounds/* $(tmpdir)/res_ios/sounds

	#copy the fonts
	mkdir -p $(tmpdir)/res_android/fonts
	mkdir -p $(tmpdir)/res_ios/fonts
	cp ./fonts/* $(tmpdir)/res_android/fonts
	cp ./fonts/* $(tmpdir)/res_ios/fonts

	#copy the unpacks
	mkdir -p $(tmpdir)/res_android/unpack
	mkdir -p $(tmpdir)/res_ios/unpack
	cp ./unpack/*.png $(tmpdir)/res_android/unpack
	cp ./unpack/*.jpg $(tmpdir)/res_android/unpack
	cp ./unpack/*.png $(tmpdir)/res_ios/unpack
	cp ./unpack/*.jpg $(tmpdir)/res_android/unpack

