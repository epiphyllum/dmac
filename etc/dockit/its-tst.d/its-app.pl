{
    image => 'itsbase:1.0',    # 用什么image启动
    order => 5,   # 启动顺序
    ip    => '172.17.102.5',
    port  => { },
    start => 'service memcached start',     # 需要启动的系统服务
    stop  => 'service memcached stop',

    # 全局级挂载
    mount => {
        jdk => {
            from => '$HOME/opt/jdk1.6.0_43',
            to   => '/opt/jdk',
        },
    },

    # 用户级配置
    users => {

        # 新建用户itsapp
        itsapp => {
            order => 1,                                       # 启动顺序
            home  => {
                from => '$HOME/appstore/tst/its-app',
                to   => '/itsapp',                            # 应用用户的home路径
            },
            start => 'jboss-start.sh',  # 启动命令
            stop  => 'jboss-stop.sh',   # 停止命令
            clean => '$HOME/jboss-clean.sh',

            # 需要挂载的数据目录: 如log config data , 默认没有, $HOME直接搞定!!!
            env => [
                [ 'JBOSS_HOME',    '/itsapp/opt/jboss' ],
                [ 'PATH',          '/opt/jdk/bin:$JBOSS_HOME/bin:$HOME/bin:/sbin:$PATH' ],
            ],

            # deploy, 部署到用户那里
            packages => {
                 'its-clearing-app' => {
                     from => "$HOME/warhub/its-clearing-app/its-clearing-app-2.0.0.war",  # 安装包
                     to   => 'jboss-webapps/its-clearing-app.war',                  # 放到哪里
                 },
                 'its-msg-app' => {
                     from => "$HOME/warhub/its-msg-app/its-msg-app-2.0.0.war",  # 安装包
                     to   => 'jboss-webapps/its-msg-app.war',                  # 放到哪里
                 },
                 'its-pg-app' => {
                     from => "$HOME/warhub/its-pg-app/its-pg-app-2.0.0.war",  # 安装包
                     to   => 'jboss-webapps/its-pg-app.war',                  # 放到哪里
                 },
                 'its-tp-app' => {
                     from => "$HOME/warhub/its-tp-app/its-tp-app-2.0.0.war",  # 安装包
                     to   => 'jboss-webapps/its-tp-app.war',                  # 放到哪里
                 },
            }
        },
    }
};

