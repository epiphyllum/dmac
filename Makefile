# 采用单独的docker daemon
install:
	@echo "install..."
	mkdir -p ${HOME}/etc/dmac.d/
	mkdir -p ${HOME}/.dockerdata/data
	mkdir -p ${HOME}/.dockerdata/run
	mkdir -p ${HOME}/.dockerdata/log
	mkdir -p ${HOME}/.dockerdata/bin
	mkdir -p ${HOME}/.dockerdata/etc
	cp bin/dmac ${HOME}/.dockerdata/bin/
	cp template/docker.tpl     ${HOME}/.dockerdata/bin/docker
	cp template/dockerd.tpl    ${HOME}/.dockerdata/bin/dockerd
	cp template/pipework.tpl   ${HOME}/.dockerdata/bin/pipework
	sed "s|{{user}}|${USER}|g" -i ${HOME}/.dockerdata/bin/docker
	sed "s|{{user}}|${USER}|g" -i ${HOME}/.dockerdata/bin/dockerd
	sed "s|{{user}}|${USER}|g" -i ${HOME}/.dockerdata/bin/pipework
	sed "s|{{home}}|${HOME}|g" -i ${HOME}/.dockerdata/bin/docker 
	sed "s|{{home}}|${HOME}|g" -i ${HOME}/.dockerdata/bin/dockerd
	sed "s|{{home}}|${HOME}|g" -i ${HOME}/.dockerdata/bin/pipework
	chmod +x ${HOME}/.dockerdata/bin/*
	cp etc/dockerd.conf ${HOME}/.dockerdata/etc/dockerd.conf
	cp etc/profile      ${HOME}/.dockerdata/etc/profile
	cp -r etc/dmac.d/*     ${HOME}/etc/dmac.d/
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
	@echo "请确保: 1) ssh root@localhost的无密码登陆"
	@echo "        2) dmac配置的image安装了当前用户的public key"
	@echo "        3) to config dockerd, please edit ${HOME}/.dockerdata/etc/dockerd.conf";
	@echo "        4) to start dockerd,  please start ${HOME}/.dockerdata/bin/dockerd with root!!!"

# 采用默认的docker daemon
master:
	@echo "install ..."
	mkdir -p ${HOME}/etc/dmac.d/
	mkdir -p ${HOME}/.dockerdata/bin
	mkdir -p ${HOME}/.dockerdata/etc
	cp bin/dmac.master ${HOME}/.dockerdata/bin/dmac
	chmod +x ${HOME}/.dockerdata/bin/*
	cp etc/profile      ${HOME}/.dockerdata/etc/profile
	cp -r etc/dmac.d/*     ${HOME}/etc/dmac.d/
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
	@echo "请确保: 1) ssh root@localhost的无密码登陆"
	@echo "        2) dmac配置的image安装了当前用户的public key"

