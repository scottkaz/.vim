* clone this repo into ~/.vim
* `cd ~/.vim`
* `mkdir bundle`
* `cd bundle`
* `git clone https://github.com/VundleVim/Vundle.vim.git`
* start vim
* within vim: `:PluginInstall`
* compile the command-t plugin (see `:help command-t`)
    * short version:
```
$ sudo apt install ruby-dev
$ cd ~/.vim/bundle/command-t/ruby/command-t
$ ruby extconf.rb
$ make
```
* restart vim
