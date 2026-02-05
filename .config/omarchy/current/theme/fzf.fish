set -l color00 '#1A1B26'
set -l color01 '#977DC8'
set -l color02 '#8E92AE'
set -l color03 '#8678B1'
set -l color04 '#9d9db9'
set -l color05 '#9C90C6'
set -l color06 '#adb0c7'
set -l color07 '#ABAFCF'
set -l color08 '#898a9d'
set -l color09 '#cabce5'
set -l color0A '#c3c5d5'
set -l color0B '#b9b1d4'
set -l color0C '#d2d2e0'
set -l color0D '#d1cbe6'
set -l color0E '#e3e4ed'
set -l color0F '#e5e6f1'

set -l FZF_NON_COLOR_OPTS

for arg in (echo $FZF_DEFAULT_OPTS | tr " " "\n")
    if not string match -q -- "--color*" $arg
        set -a FZF_NON_COLOR_OPTS $arg
    end
end

set -Ux FZF_DEFAULT_OPTS "$FZF_NON_COLOR_OPTS"" --color=bg+:$color00,bg:$color00,spinner:$color0E,hl:$color0D"" --color=fg:$color07,header:$color0D,info:$color0A,pointer:$color0E"" --color=marker:$color0E,fg+:$color06,prompt:$color0A,hl+:$color0D"
