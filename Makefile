all: install

install:
	@mkdir -p ${HOME}/.dockerdata/data
	@mkdir -p ${HOME}/.dockerdata/run
	@mkdir -p ${HOME}/.dockerdata/log
	@mkdir -p ${HOME}/.dockerdata/bin
	@mkdir -p ${HOME}/.dockerdata/etc
	@sed "s/{{user}}/${USER}/g" template/docker.tpl   > ${HOME}/.dockerdata/bin/docker
	@sed "s/{{user}}/${USER}/g" template/dockerd.tpl  > ${HOME}/.dockerdata/bin/dockerd
	@sed "s/{{user}}/${USER}/g" template/pipework.tpl > ${HOME}/.dockerdata/bin/pipework
	@cp bin/dockit       ${HOME}/.dockerdata/bin/dockit
	@cp etc/dockerd.conf ${HOME}/.dockerdata/etc/dockerd.conf
	@cp etc/profile      ${HOME}/.dockerdata/etc/profile
	@chmod +x ${HOME}/.dockerdata/bin/*
	@echo 'export PATH=${HOME}/.dockerdata/bin:$$PATH' >> ${HOME}/.profile
	@echo ". ${HOME}/.dockerdata/etc/profile" >> ${HOME}/.profile
	@banner done
	@echo "to config dockerd, please edit ${HOME}/etc/dockerd.conf";
	@echo "to start dockerd,  please start ${HOME}/bin/dockerd with root!!!"

