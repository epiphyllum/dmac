install:
	@echo "install..."
	mkdir -p ${HOME}/etc/dsvc.d/
	mkdir -p ${HOME}/.dockerdata/data
	mkdir -p ${HOME}/.dockerdata/run
	mkdir -p ${HOME}/.dockerdata/log
	mkdir -p ${HOME}/.dockerdata/bin
	mkdir -p ${HOME}/.dockerdata/etc
	cp template/docker.tpl     ${HOME}/.dockerdata/bin/docker.tpl
	cp template/dockerd.tpl    ${HOME}/.dockerdata/bin/dockerd.tpl
	cp template/pipework.tpl   ${HOME}/.dockerdata/bin/pipework.tpl
	sed "s/{{user}}/${USER}/g" ${HOME}/.dockerdata/bin/docker
	sed "s/{{user}}/${USER}/g" ${HOME}/.dockerdata/bin/dockerd
	sed "s/{{user}}/${USER}/g" ${HOME}/.dockerdata/bin/pipework
	sed "s/{{home}}/${HOME}/g" ${HOME}/.dockerdata/bin/docker 
	sed "s/{{home}}/${HOME}/g" ${HOME}/.dockerdata/bin/dockerd
	sed "s/{{home}}/${HOME}/g" ${HOME}/.dockerdata/bin/pipework
	chmod +x ${HOME}/.dockerdata/bin/*
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

