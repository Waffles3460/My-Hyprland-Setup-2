function fastfetch
    set -l gifs ~/.config/fastfetch/gifler/*.gif
    
    if count $gifs >/dev/null
        set -l random_gif (random choice $gifs)
        command fastfetch --logo $random_gif --logo-type kitty-icat $argv
    else
        command fastfetch $argv
    end
end


if status is-interactive
    fastfetch
end