.PHONY: all
all:
	mkdir -p ${ZOMBIE_ZOO_CLIENT_ROOT}/tmp/res_android/config/
	mkdir -p ${ZOMBIE_ZOO_CLIENT_ROOT}/tmp/res_ios/config/
	sh ${ZOMBIE_ZOO_CLIENT_ROOT}/tools/xls2json/xls2json.sh ${ZOMBIE_ZOO_CLIENT_ROOT}/raw/config_raw/csv ${ZOMBIE_ZOO_CLIENT_ROOT}/tmp/res_android/config/
	cp ${ZOMBIE_ZOO_CLIENT_ROOT}/tmp/res_android/config/* ${ZOMBIE_ZOO_CLIENT_ROOT}/tmp/res_ios/config/