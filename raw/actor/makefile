dirs=$(shell ls -l | grep ^d | awk '{print $$9}')
.PHONY:android ios $(dirs)
target = android
android:$(dirs)

ios:$(dirs)

$(dirs):
	make -C $@ $(target)