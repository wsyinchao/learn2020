--[[
#!/bin/bash

# 传送文件
# 默认传递到远程机器上的workspace文件夹下
# 设定只能单向，本地想远程传送文件

# 传送到指定文件位置, 且不传递未修改过的文件(通过实践判断)

remote_machine='yinchao@101.37.158.220:'

current_files=$1
remote_files='/home/yinchao/workspace/'

# $1 can't be empty
if test -z $1
then 
    echo 'The file that to be transport can not be empty.'
fi

# 需要做三件事情，(用lua写？shell 实在难写...)
#1忽略有些不需要拷贝的文件(有一个列表)
#2根据时间，没有修改的文件不需要拷贝(需要单个文件比较时间)
#3如果目标地址没有文件夹，应该创建文件夹(远程执行命令 ssh user@host "command")

# 这种方式不好...不能将文件传送到指定位置，
scp -i ~/id_rsa_ff_testter_1140 -r -p ${current_files} ${remote_machine}$remote_files

# 进一步, 识别修改过的文件

# scp -i ~/id_rsa_ff_testter_1140 -r redis-6.2.6/ yinchao@101.37.158.220:/home/yinchao/workspace/

以上是shell 指令，只是简单的实现了文件传递,有点那些，用lua试试看~~
]]

-- 第一步，获取参数
