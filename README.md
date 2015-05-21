dockit
====

### $HOME/etc/dsvc.d/demo/

    demo.main   : 配置IP地址/子网掩码, 启动image,

    demo.option : 容器创建的参数: -v, -p, 参见docker run的参数

    demo.config : 容器启动后的配置脚本: 如配置/etc/hosts. 注意他会在docker run与docker start都运行, 注意防止start的重复配置

    demo.run    : 应用的启动脚本
