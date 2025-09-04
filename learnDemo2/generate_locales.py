import os
import subprocess
import sys

# 确保中文显示正常
sys.stdout = open(sys.stdout.fileno(), mode='w', encoding='utf8', buffering=1)
sys.stderr = open(sys.stderr.fileno(), mode='w', encoding='utf8', buffering=1)

try:
    # 激活intl_utils插件
    print("正在激活intl_utils插件...")
    subprocess.run(["flutter", "pub", "global", "activate", "intl_utils"], check=True)
    
    # 安装依赖
    print("正在安装项目依赖...")
    subprocess.run(["flutter", "pub", "get"], check=True)
    
    # 生成本地化代码
    print("正在生成本地化代码...")
    subprocess.run(["flutter", "pub", "run", "intl_utils:generate"], check=True)
    
    print("本地化代码生成成功！")
    
except subprocess.CalledProcessError as e:
    print(f"命令执行失败: {e}")
    sys.exit(1)
except Exception as e:
    print(f"发生错误: {e}")
    sys.exit(1)

# 等待用户按任意键继续
if os.name == 'nt':  # Windows系统
    os.system("pause")