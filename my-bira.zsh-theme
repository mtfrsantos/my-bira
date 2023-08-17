local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
local user_host="%B%F{cyan}%n%f%b%F{8}@%f%F{green}%m%f%B%F{green}:%f%b "
local user_symbol="%(!.#.%{$fg[cyan]%}⚙%{$reset_color%})"
local current_dir="%B%{$fg[blue]%}%~ %{$reset_color%}"
local first_line_semi_square="%{$fg[cyan]%}╭─%{$reset_color%}"
local second_line_semi_square="%{$fg[cyan]%}╰─%{$reset_color%}"

local vcs_branch='$(git_prompt_info)$(hg_prompt_info)'
local rvm_ruby='$(ruby_prompt_info)'
local venv_prompt='$(virtualenv_prompt_info)'

prompt_nix_shell() {
    if [[ -n "$IN_NIX_SHELL" ]]; then
        if [[ $name != "shell" ]]; then
            echo -n "%{$fg[magenta]%}[$name] %{$reset_color%}"
        elif [[ -n $NIX_SHELL_PACKAGES ]]; then
            local package_names=""
            local packages=($NIX_SHELL_PACKAGES)
            for package in $packages; do
                package_names+=" ${package##*.}"
            done
            echo -n "%{$fg[magenta]%}[nix-shell: $package_names] %{$reset_color%}"
        else
            echo -n "%{$fg[magenta]%}[nix-shell] %{$reset_color%}"
        fi
    fi
}
local nix_shell='$(prompt_nix_shell)'

ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"

PROMPT="${first_line_semi_square}${user_host}${current_dir}${rvm_ruby}${vcs_branch}${nix_shell}${venv_prompt}
${second_line_semi_square}%B${user_symbol}%b "
RPROMPT="%B${return_code}%b"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="] %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} ⚠ %{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[yellow]%}"

ZSH_THEME_HG_PROMPT_PREFIX="$ZSH_THEME_GIT_PROMPT_PREFIX"
ZSH_THEME_HG_PROMPT_SUFFIX="$ZSH_THEME_GIT_PROMPT_SUFFIX"
ZSH_THEME_HG_PROMPT_DIRTY="$ZSH_THEME_GIT_PROMPT_DIRTY"
ZSH_THEME_HG_PROMPT_CLEAN="$ZSH_THEME_GIT_PROMPT_CLEAN"

ZSH_THEME_RUBY_PROMPT_PREFIX="%{$fg[red]%}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="› %{$reset_color%}"

ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg[green]%}("
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX=") %{$reset_color%}"
ZSH_THEME_VIRTUALENV_PREFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX"
ZSH_THEME_VIRTUALENV_SUFFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX"
