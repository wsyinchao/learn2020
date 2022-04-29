#!/bin/bash

# 定期删除日志，默认维持一个月的日志
# 配置到contab里面定期执行，默认一星期执行一次(每周日执行)

# 清除策略，
# 目标是维持30天日志，删除超出三十天的日志
# 最好是有一个基准点，所有时间都换算成距离那个基准点已经过了多少天
# 没有可以直接换算成天的系统命令，改成秒计算，一天是 60 * 60 * 24 = 86400

# 因为一些原因(包括但不限于 不知道具体代码目录)
# 所以，需要将该文件放置 与 log 文件夹同一目录

# 不传参数，默认执行删除，如需测试，传递任意参数(推荐 -c )

# some config
# 非常重要 very important!!!
log_path=/home/yinchao/workspace/game/ff_server/log # 因为要在定时器crontab里面运行，所以需要配置绝对路径

hold_day=31                                         #只持有30天日志
seconds_of_day=86400                                #一天86400秒
current_time_seconds=$(date +%s)                    #当前时间秒数，从1970-01-01开始

echo "start"
echo 'current_time_seconds', $current_time_seconds

##########################
#创建文件去删除
create_files(){
    _date=(
        2021-02-22
        2021-02-23
        2021-02-24
        2021-02-25
        2021-02-26
        2021-02-27
        2021-02-28

        2022-02-22
        2022-02-23
        2022-02-24
        2022-02-25
        2022-02-26
        2022-02-27
        2022-02-28

        2022-03-22
        2022-03-23
        2022-03-24
        2022-03-25
        2022-03-26
        2022-03-27
        2022-03-28

        2022-04-27
    )

    for dir in ${_date[@]}
    do
        mkdir ./log/${dir}

        cd ./log/${dir}
        touch ${dir}
        cd ../..
    done
}
##########################

# 删除日志文件
clear_files(){
    # for 里面不能为空，要执行些什么
    for dir in $(ls ${log_path})
    do
        dir_time_seconds=$(date -d ${dir} +%s)                          # 获取日志文件目录时间对应的秒，从1970-01-01开始
        different_time=`expr $current_time_seconds - $dir_time_seconds` #当前时间与日志文件时间 的差
        hold_time=`expr $hold_day \* $seconds_of_day`                   #已经维持文件多久了, 乘法运算符需要转义 \*

        if test $different_time -ge $hold_time
        then
            echo "------"
            # echo 'different_time', $different_time
            # echo 'hold_time', $hold_time
            echo "delete this expired dir", $dir, " and it's files."
            rm -rf ${log_path}/${dir}
            echo 'success'
        fi
    done
}

argument=$1         # 参数
if test -z ${argument}
then
    clear_files     # 函数调用不带括号？？，秀儿...
else
    create_files
fi