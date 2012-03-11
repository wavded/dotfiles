vim = ~/.vim
all:update

install:
	@mv ~/.vimrc ~/.vimrc_bak || echo "There was no existing .vimrc, so no need to backup"
	@mv ~/.gvimrc ~/.gvimrc_bak || echo "There was no existing .gvimrc, so no need to backup"
	@ln -s ${vim}/vimrc ~/.vimrc
	@git submodule update --init

update:
	@git submodule foreach git checkout master
	@cd bundle/powerline && git checkout develop
	@git submodule foreach git pull
	@make -s pathogen

pathogen:
	@cd ${vim}/autoload && rm pathogen.vim && curl -O https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
