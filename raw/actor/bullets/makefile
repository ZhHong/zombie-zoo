.PHONY: android ios
filename=$(shell pwd | sed 's/^\(.*\)[/]//')
android:
	sh ${ZOMBIE_ZOO_CLIENT_ROOT}/tools/make_res.sh android ${filename}
	cp ../../../tmp/res_android/${filename}/* "../../../raw/spritebuilder_zombie-zoo.spritebuilder/Packages/SpriteBuilder Resources.sbpack/images"

ios:
	sh ${ZOMBIE_ZOO_CLIENT_ROOT}/tools/make_res.sh ios ${filename}
	cp ../../../tmp/res_ios/ui/${filename}/* "../../../raw/spritebuilder_zombie-zoo.spritebuilder/Packages/SpriteBuilder Resources.sbpack/images"
