@echo off

:: 把系统 Python314 从 PATH 里踢掉
set PATH=%PATH:C:\Program Files\Python314;=%
set PATH=%PATH:C:\Program Files\Python314\Scripts;=%

:: 删除 torch 的 ninja 缓存（这是关键）
for /d /r "%TEMP%" %%d in (torch_extensions*) do rd /s /q "%%d" 2>nul
for /d /r "%LOCALAPPDATA%" %%d in (torch_extensions*) do rd /s /q "%%d" 2>nul

:: 删除源码目录下所有缓存
cd /d F:\ComfyUI_windows_portable\python_embeded\SageAttention
rd /s /q build 2>nul
rd /s /q dist 2>nul
rd /s /q sageattention.egg-info 2>nul

:: ===== 1. 初始化 VS 编译环境 =====
call "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" x64 -vcvars_ver=14.40

:: ===== 2. 强制便携版 Python 优先，覆盖系统 Python 3.14 =====
set PATH=F:\ComfyUI_windows_portable\python_embeded;C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v13.1\bin;%PATH%

:: ===== 3. 进入源码目录 =====
cd /d F:\ComfyUI_windows_portable\python_embeded\SageAttention

:: ===== 4. 清理旧编译产物（避免残留 cp314 缓存）=====
rd /s /q build 2>nul
rd /s /q dist 2>nul
rd /s /q sageattention.egg-info 2>nul

:: ===== 5. 告知编译器头文件和库位置 =====
set INCLUDE=F:\ComfyUI_windows_portable\python_embeded\Include;C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v13.1\include;%INCLUDE%
set LIB=F:\ComfyUI_windows_portable\python_embeded\libs;C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v13.1\lib\x64;%LIB%

:: ===== 6. Python 包路径 =====
set PYTHONPATH=F:\ComfyUI_windows_portable\python_embeded\Lib\site-packages

:: ===== 7. 编译优化参数 =====
set DISTUTILS_USE_SDK=1
set NVCC_APPEND_FLAGS=--threads 8
set _CL_=/Zc:__cplusplus /std:c++17
set EXT_PARALLEL=4
set MAX_JOBS=32

:: ===== 8. 验证 python 指向正确版本 =====
echo 当前 python 路径：
where python
echo 当前 python 版本：
python --version
echo 如果上面不是 3.13，请 Ctrl+C 中止！
pause

:: ===== 9. 执行编译 =====
F:\ComfyUI_windows_portable\python_embeded\python.exe setup.py bdist_wheel

echo.
echo ===== 完成，whl 文件在 dist\ 目录 =====
pause