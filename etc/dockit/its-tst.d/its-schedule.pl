{
    image => 'itsbase:1.0',    # 用什么image启动
    order => 6,   # 启动顺序
    ip    => '172.17.102.6',
    port  => { },
    start => 'service memcached start',
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
                from => '$HOME/appstore/tst/its-schedule',
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
                 'schedule-batch' => {
                     from => "$HOME/warhub/schedule-batch/schedule-batch-2.0.0.war",  # 安装包
                     to   => 'jboss-webapps/schedule-batch.war',                  # 放到哪里
                 },
                 'its-task-schedule-tx-checking' => {
                     from => "$HOME/warhub/its-task-schedule-tx-checking/its-task-schedule-tx-checking-2.0.0.war",
                     to   => 'jboss-webapps/its-task-schedule-tx-checking.war',                  # 放到哪里
                 },
            }
        },
    }
};

