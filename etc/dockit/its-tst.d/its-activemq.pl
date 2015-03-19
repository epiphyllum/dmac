{
    image => 'itsbase:1.0',    # 用什么image启动
    order => 1,   # 启动顺序
    ip    => '172.17.102.1',
    port  => { },
    start => 'service memcached start',     # 需要启动的系统服务
    stop  => 'service memcached stop',
    clean => undef,

    # 全局级挂载
    mount => {
        jdk => {
            from => '$HOME/opt/jdk1.6.0_43',
            to   => '/opt/jdk',
        },
        activemq => {
            from => '$HOME/opt/apache-activemq-5.10.0',
            to   => '/opt/activemq',
        }
    },

    # 用户级配置
    users => {

        # 新建用户itsapp
        itsapp => {
            order => 1,                                       # 启动顺序
            home  => {
                from => '$HOME/appstore/tst/its-activemq',
                to   => '/itsapp',                            # 应用用户的home路径
            },
            start => 'activemq start',  # 启动命令
            stop  => 'activemq stop',   # 停止命令
            env => [
                [ 'JAVA_HOME',     '/opt/jdk' ],
                [ 'ACTIVEMQ_HOME', '/opt/activemq' ],
                [ 'PATH',          '/opt/jdk/bin:$ACTIVEMQ_HOME/bin:$HOME/bin:/sbin:$PATH' ],
            ],
        },
    }
},

