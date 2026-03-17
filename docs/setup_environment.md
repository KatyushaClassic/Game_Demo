# 开发环境配置（Windows / Linux）

> 目标：确保可以在命令行执行 Godot 4，并能对本项目做基础检查。

## 1. 推荐版本

- Godot `4.2.x` 或 `4.3.x`
- 语言：GDScript

## 2. Windows 配置步骤

### 2.1 安装

可选任一方式：

1. 官网下载 Godot 4.x（标准版，非 Mono 版即可）。
2. Steam 安装 Godot。

### 2.2 配置 PATH（可选但强烈推荐）

将 `Godot_v4.x-stable_win64.exe` 所在目录加入系统 PATH。

完成后重新打开终端，运行：

```powershell
godot --version
```

如果你把文件名改成了 `godot4.exe`，也可以用：

```powershell
godot4 --version
```

## 3. Linux 配置步骤（Ubuntu）

```bash
sudo apt update
sudo apt install -y wget unzip
mkdir -p ~/tools/godot && cd ~/tools/godot
wget https://github.com/godotengine/godot/releases/download/4.2.2-stable/Godot_v4.2.2-stable_linux.x86_64.zip
unzip Godot_v4.2.2-stable_linux.x86_64.zip
chmod +x Godot_v4.2.2-stable_linux.x86_64
sudo ln -sf "$HOME/tools/godot/Godot_v4.2.2-stable_linux.x86_64" /usr/local/bin/godot
godot --version
```

## 4. 项目自检

在项目根目录执行：

```bash
bash tools/check_godot_env.sh
```

该脚本会：

1. 自动寻找 `godot` 或 `godot4`。
2. 输出 Godot 版本。
3. 使用 headless 模式导入项目（验证项目可被引擎识别）。
