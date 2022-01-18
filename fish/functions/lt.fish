function lt --description='alias ls to exa'
    command exa -al --tree --level=2 --color=always --group-directories-first $argv
end
