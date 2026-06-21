克隆 SageAttention
git clone --depth=1 https://github.com/thu-ml/SageAttention.git

安装 triton
pip install -U "triton-windows<3.8"

woct0rdho/triton-windows提供python补充包libs/include

https://github.com/woct0rdho/triton-windows/releases/download/v3.0.0-windows.post1/python_3.13.2_include_libs.zip

编译前可先去除系统环境变量的python

build_sage.bat是一键安装SageAttention脚本，部分路径可能需要替换

vs_BuildTools.exe是vs 2022

setup.py是SageAttention克隆后修补bug的安装脚本，替换自带的脚本

下面是预编译的SageAttention2.2 适用于python3.13.12+torch2.12.0+cuda13.0+win+64位

https://github.com/yinyues2/Comfyui/blob/main/sageattention-2.2.0%2Bcu130torch2.12.0-cp313-cp313-win_amd64.whl
