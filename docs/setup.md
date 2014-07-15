#How to build the training environment

## Homebrew

Install [Homebrew](https://github.com/mxcl/homebrew)

## rbenv and its fellows

#### Install [rbenv](https://github.com/sstephenson/rbenv)

```
brew install rbenv
```

然后把下面的代码放到 ~/.bash_profile 里

```
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
```

#### Install [ruby-build](https://github.com/sstephenson/ruby-build)

ruby-build is a plugin to compile and install Ruby

```
brew install ruby-build
rbenv install --list         # 列出所有 ruby 版本
rbenv install 2.1.1          # 安装 ruby 2.1.1
```

#### Install [rbenv-update](https://github.com/rkh/rbenv-update)

rbenv-update is a plugin to update rbenv and plugins

```
mkdir -p $RBENV_ROOT/plugins
git clone https://github.com/rkh/rbenv-update.git $RBENV_ROOT/plugins/rbenv-update
rbenv update                 #更新rbenv  
```

#### 一些常用命令

```
rbenv rehash                 # 每当切换 ruby 版本和执行 bundle install 之后必须执行这个命令
rbenv which irb              # 列出 irb 这个命令的完整路径
rbenv whence irb             # 列出包含 irb 这个命令的版本
```


## Bundler

#### Install Bundler

```
gem install bundler
```
