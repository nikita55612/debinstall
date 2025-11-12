#!/bin/bash

set -e

[[ $EUID -eq 0 ]] || exec sudo "$0" "$(whoami)" "$HOME" "$@"
ORIGINAL_USER="${1:-$(whoami)}"
ORIGINAL_HOME="${2:-$HOME}"

if ! command -v vim >/dev/null 2>&1; then
	apt install -y vim
fi

if [ ! -f "$ORIGINAL_HOME/.vimrc" ]; then
	cat > "$ORIGINAL_HOME/.vimrc" <<'EOF'
syntax on                          " Подсветка синтаксиса
filetype plugin indent on          " Определение типа файла + плагины + автоотступы
set background=dark                " Тёмная тема (для цветовых схем)
set notermguicolors                " Color (24-бит)
set number                         " Номера строк
set relativenumber                 " Относительные номера (удобно для прыжков)
set hidden                         " Скрывать буферы вместо выгрузки
set encoding=utf-8                 " Кодировка UTF-8
set fileencoding=utf-8             " Сохранять файлы в UTF-8
set noswapfile                     " Без .swp файлов
set expandtab                      " Таб → пробелы
set shiftwidth=4                   " Отступ при >> и << — 4 пробела
set softtabstop=4                  " Таб как 4 пробела при редактировании
set tabstop=4                      " Ширина таба — 4 пробела
set smartindent                    " Умный автоотступ
set wrap                           " Перенос длинных строк
set linebreak                      " Перенос по словам (не по символам)
set scrolloff=8                    " N строк сверху/снизу от курсора при прокрутке
set sidescrolloff=8                " N символов слева/справа при горизонтальной прокрутке
set mouse=a                        " Поддержка мыши (выделение, скролл)
set wildmenu                       " Умное автодополнение в командной строке
set wildmode=longest:full,full     " Режим автодополнения: сначала longest, потом полный список
set ignorecase                     " Игнорировать регистр при поиске
set smartcase                      " ...но если есть заглавная — учитывать
set incsearch                      " Поиск по мере ввода
set hlsearch                       " Подсвечивать все совпадения
set updatetime=300                 " Быстрее обновление (git, автодополнение, курсор)
set timeoutlen=500                 " Время ожидания для <leader> и комбинаций
set belloff=all                    " Отключить все звуки и вспышки
set backspace=indent,eol,start     " Backspace работает через всё
set clipboard=unnamedplus          " Копировать в системный буфер (+clipboard должен быть в :version)
EOF
fi
