function ll --description='alias ls to exa'
    command exa -al --color=always --group-directories-first $argv
end
