#!/bin/bash

## note: $? 显示最后命令的退出状态， 0 表示没有错误，其他值表明有错误

# command=$1

# ${command}

# if test $? -eq 0
# then 
#     echo 'execute success!!'
# else
#     echo 'execute failed!!'
# fi

# 备份，为了防止错误拷贝，进行备份
# 将当前所有文件进行备份

# 检查是否有 back_up_dir_shell_ 名字复杂一点，防止冲突
back_up_dir='back_up_dir_shell_'
# expired_ret='directory'

# deprecated 直接删除，然后备份即可，不做这么多复杂的判断
# check_is_back_up_dir_shell_exist() {
#     ret=`file back_up_dir_shell_`   # 这个命令永远执行成功，
#     # echo ${ret:0:$[${#dir} + 2]}    # 需要加2， 有一个冒号，有一个空格
#     # echo ${ret:$[${#dir} + 1]:${#ret}}  # 有可能会是一个串，有可能会是中间带有空格的字符串
#     # echo ${ret}
    
#     # 字符替换
#     # $ret = ${ret//_/-}
#     # echo $ret

#     # $ret=${ret:$[${#dir} + 1]:${#ret}}

#     # if test ${ret} = ${expired_ret} # ${test}返回串太长,之间有空格
#     # then 
#     #     echo 'exist dir'
#     # fi
# }

# ret=`check_is_back_up_dir_shell_exist` ## 获取命令的执行结果
# ret=`file back_up_dir_shell_` ## 获取命令的执行结果
# echo ret, ${ret}

# check_is_back_up_dir_shell_exist

# 删除备份，不论是否存在，
rm -rf ${back_up_dir}

# 创建，
mkdir ${back_up_dir}

# 备份
for file in `ls`
do 
    if test ${file} != $back_up_dir
    then 
        cp -rvf ${file} ${back_up_dir}/
    fi
done
