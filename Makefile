all: prepare

prepare:
	@echo prepare for ${USER}...
	sed "s/{{user}}/${USER}/g" template/dockerd.tpl  > bin/dockerd
	sed "s/{{user}}/${USER}/g" template/pipework.tpl > bin/pipework

install: prepare
	@echo "install..."
	mkdir -p ${HOME}/etc/dsvc.d/
	mkdir -p ${HOME}/.dockerdata/data
	mkdir -p ${HOME}/.dockerdata/run
	mkdir -p ${HOME}/.dockerdata/log
	mkdir -p ${HOME}/.dockerdata/bin
	mkdir -p ${HOME}/.dockerdata/etc
	cp bin/docker       ${HOME}/.dockerdata/bin/doker
	cp bin/dockerd      ${HOME}/.dockerdata/bin/dokerd
	cp bin/dockit       ${HOME}/.dockerdata/bin/dockit
	cp bin/pipework     ${HOME}/.dockerdata/bin/pipework
	cp bin/dsvc         ${HOME}/.dockerdata/bin/dsvc
	cp etc/dockerd.conf ${HOME}/.dockerdata/etc/dockerd.conf
	cp etc/profile      ${HOME}/.dockerdata/etc/profile
	cp -r etc/dsvc.d/*     ${HOME}/etc/dsvc.d/
	chmod +x ${HOME}/.dockerdata/bin/*
	@echo "###############################################"  >> ${HOME}/.bash_profile
	@echo "# please do not edit those lines below"     >> ${HOME}/.bash_profile 
	@echo "###############################################" >> ${HOME}/.bash_profile 
	@echo 'export PATH=${HOME}/.dockerdata/bin:$$PATH' >> ${HOME}/.bash_profile
	@echo ". ${HOME}/.dockerdata/etc/profile" >> ${HOME}/.bash_profile  
	@echo "###############################################" >> ${HOME}/.bash_profile 
	@echo "# please do not edit those lines above"  >> ${HOME}/.bash_profile 
	@echo "###############################################" >> ${HOME}/.bash_profile 
	@banner done
	@echo "to config dockerd, please edit ${HOME}/.dockerdata/etc/dockerd.conf";
	@echo "to start dockerd,  please start ${HOME}/.dockerdata/bin/dockerd with root!!!"

