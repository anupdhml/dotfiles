# Alias definitions.

##################
#Usability Tweaks#
##################

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    # no colors for tty1
    #if [ $TERM == linux ] && [ $(tty) == /dev/tty1 ] ; then
      #alias ls='ls -hCF'
    #else
      test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
      alias ls='ls --color=auto -hCF'
      alias dir='dir --color=auto'
      alias vdir='vdir --color=auto'
    #fi

    alias grep='grep -i --color=auto'
    alias fgrep='fgrep -i --color=auto'
    alias egrep='egrep -i --color=auto'
fi

# Make the commands interactive and verbose 
#alias rm="rm -i"      
alias rm="rm -vI"      
alias rmdir="rmdir -v"      
alias cp="cp -iv"      
alias mv="mv -iv"
alias killall='killall -u $USER -v'

# Make outputs more readable 
alias du='du -kh'
alias df='df -kTh'
alias free='free -m'

# For sending files to trash
#alias rm="trash-rm"
alias trash='rm -fr ~/.Trash'

# Annoying sl?
alias sl="sl -aFe"
alias SL="sl -aFe"

# change calendar default behavior
#alias calendar="calendar -l 0"

# better less
alias vless='/usr/share/vim/vim72/macros/less.sh'

# graphical apps
alias gnome-terminal="gnome-terminal --maximize"
alias google-chrome="google-chrome --incognito"

# vi like behavior
alias :q='exit'
alias :q!='logout'

# what it says
function mkcd() {
    mkdir -p "$1" && cd "$1"
}

# urxvt with tmux
#alias urxvt-tmux='urxvt -e bash -c "tmux -q has-session && exec tmux attach-session -d || exec tmux new-session -n$USER -s$USER@$HOSTNAME"'
alias urxvt-tmux='urxvt -e bash -c "(tmux -q has-session && exec tmux attach-session -d) || (exec tmux new-session)"'
alias tmux-start="(tmux -q has-session && tmux attach-session -d) || (tmux new-session)"

# C
alias gccminenodb="gcc -Wall -pedantic -std=c99"
alias gccmine="gcc -Wall -pedantic -std=c99 -ggdb"
alias valgrind-memcheck="valgrind --leak-check=yes $1"

# others
alias mysql="mysql --sigint-ignore"
alias vi="vim"

# use vim for man
#alias man='vman'

#############################################################################################

#############
#Easy Typing#
#############

# handy stuff
alias p='pwd'
alias c='clear'
alias h='history'
alias j='jobs -l'
alias rd='cd "`pwd -P`"'                # if in directory containing symlink in path, change to "real" path
alias g='gvfs-open'		                # open with default gnome applications
alias psx="ps auxw | grep $1" 
alias ffind='find . -name $1' 
alias tailmsg='tail -50f /var/log/messages'
alias start-dropbox="dropbox start"
alias cleanup-thumbnails='rm -rv ~/.thumbnails/'
alias cleanup-packages='sudo apt-get -y autoclean && sudo apt-get -y autoremove && sudo apt-get -y clean && sudo apt-get -y remove && sudo deborphan | xargs sudo apt-get -y remove --purge'
alias t='todo.sh'
#alias wr='wallpaper-random.sh'
alias ws='wallpaper-show.sh'

# Tired of running apt-get /aptitude everytime?
alias update="sudo apt-get update; sudo apt-get upgrade && sudo apt-get clean && sudo apt-get autoremove"
alias upgrade="sudo apt-get upgrade"
alias install="sudo apt-get install"
alias remove="sudo apt-get remove"
alias search-pkg="sudo apt-cache search"

# some ls aliases
alias l='ls'
alias la='ls -A'
alias ll='ls -lh'
alias lal='ls -Alh'
alias lsl='ls -A --color=always | less -r'      #preserve color when piped through less
alias lsll='ls -Alh --color=always | less -r'   #preserve color when piped through less, log format
alias lsd='ls -l | grep "^d"'                   # list only directories
alias lsf='ls -l | grep -v "^d"'                # list only files

# Make the cd operations less tiring
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

## du related
alias du-dir='du -sc -m * | sort -n'
alias du-dirk='du -sc -k * | sort -n'
alias du-dirh='du -hsc * | sort -n'

# clean spotify cache
alias spotify-storage-clean="rm -rfv $HOME/.cache/spotify/Storage/"
alias spotify-storage-clean-all="rm -rfv $HOME/.cache/spotify/"

# mount the filesystems
#alias mount-selected="sudo mount /dev/sda1 || sudo mount /dev/sda7 || sudo mount /dev/sda8"

# aliases for some directories
alias vi-calendar="vi ~/.calendar/calendar.mine"
alias vi-notes="vi /media/DATA/.Personal/Documents/Notes/"
alias vi-ling="vi /media/DATA/.Personal/Documents/Notes/ling/"
alias vi-next="vi /media/DATA/.Personal/Documents/Notes/Next.txt"
alias vi-todo="vi /media/DATA/.Personal/Documents/Notes/TODO.txt"
alias cd-notes="cd /media/DATA/.Personal/Documents/Notes/"
alias cd-ling="cd /media/DATA/.Personal/Documents/Notes/ling/"
alias cd-scribblings="cd /media/DATA/.Personal/Documents/Notes/Scribblings/"
#
alias cd-code="cd $HOME/data/code/"
alias cd-github="cd $HOME/data/code/GITHUB/"
alias cd-dotfiles="cd $HOME/data/code/GITHUB/dotfiles/"
#
alias cd-tf="cd $HOME/public_html/tf/"
alias clear-assets-mcontent="rm -rfv $HOME/public_html/anup-mcontent-nov/www/assets/*"
alias clear-assets-mgame="rm -rfv $HOME/public_html/anup-mgame-nov/www/assets/*"
alias cd-tiltfactor="cd $HOME/Desktop/tiltfactor/"
#
alias cd-php="cd ~/data-local/php/"
alias cd-resources="cd ~/data-local/resources/"
alias cd-wayrunner="cd ~/.virtualenvs/wayrunner/lib/python2.7/site-packages/wayrunner-1.0.5-py2.7.egg/wayrunner/"

# dump enhanced history log
alias hhh="cat $HOME/.bash_log"
# dump history of directories visited
#alias histdirs="cat $HOME/.bash_log | awk -F ' ~~~ ' '{print $2}' | uniq"
hhf () {
    #cat $HOME/.bash_log | awk -F ' ~~~ ' '{print $2}' | uniq
    cat $HOME/.bash_log | awk -F ' ~~~ ' '{print $2}' | cut -d':' -f2 | uniq
}
hh () {
    hhf | tail
}

#############################################################################################

###################
#Hard to Remember?#
###################

## handy stuff
alias pdf-combine='gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=output.pdf *.pdf' 		#combine pdfs
alias image2pdf='convert -adjoin -page A4 *.jp*g multipage.pdf'       # convert images to a multi-page pdf
alias mencoder-join='mencoder -forceidx -ovc copy -oac copy -o'       # just add: whatever.avi whatever.pt1.avi whatever.pt2.avi ...
alias webcam='mplayer -cache 128 -tv driver=v4l2:width=176:height=177 -vo xv tv:// -noborder -geometry "95%:93%" -ontop'  # mplayer webcam window for screencasts
alias xsnow='(killall xsnow ; sleep 3 ; exec xsnow -nosanta -notrees -norudolf -nokeepsnow >& /dev/null &)' # xsnow
alias wma2wav='for i in *.wma; do mplayer -vo null -vc dummy -af resample=44100 -ao pcm:waveheader:file="${i%.wma}.wav" "$i" ; done'  # convert wma to wav
alias kernelcleanup="dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge"                   # remove all unused Linux Kernel headers, images & modules
alias phonesearch='grep '[0-9]\{3\}-[0-9]\{4\}' "$1"'         # search phone #'s in file (requires XXX-XXX-XXXX format)
alias biggest='BLOCKSIZE=1048576; du -x | sort -nr | head -10'        # show biggest directories
alias webshare='python -c "import SimpleHTTPServer; SimpleHTTPServer.test();"'
alias lo='locate'

## handy stuff, info related
alias showallaliases='compgen -A alias'                 # list bash alias defined in .bash_profile or .bashrc
alias showallfunctions='compgen -A function'            # list bash functions defined in .bash_profile or .bashrc
alias env2='for _a in {A..Z} {a..z};do _z=\${!${_a}*};for _i in `eval echo "${_z}"`;do echo -e "$_i: ${!_i}";done;done|cat -Tsv'  # print all environment variables, including hidden ones
alias sete='set|sed -n "/^`declare -F|sed -n "s/^declare -f \(.*\)/\1 ()/p;q"`/q;p"'  # display environment vars only, using set

## date and time related
alias getDate="date '+%m%d%y'"		# Just to get the date
alias epochdaysleft="perl -e 'printf qq{%d\n}, time/86400;'"        # perl one-liner to determine number of days since the Unix epoch
alias epochtime='date +%s'                # report number of seconds since the Epoch (ex. 1295779549)
alias onthisday='grep -h -d skip `date +%m/%d` /usr/share/calendar/*'

## ssh monitor
alias sshall='logwatch --service sshd --range all --detail high --archives'
alias sshtoday='logwatch --service sshd --range today --detail high --archives'

## ls related
alias l.='ls -d .[[:alnum:]]* 2> /dev/null || echo "No hidden file here..."'       # list only hidden files
alias l.l='ls -lhd .[[:alnum:]]* 2> /dev/null || echo "No hidden file here..."'    # list only hidden files, long format
alias lf="ls -Alh --color=always | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\" %0o \",k);print}'" # full ls with octal+symbolic permissions

## ps related
alias psmine='ps -u "$USER" -o user,pid,ppid,pcpu,pmem,args | less'		             # my processes
alias pstree='ps -e -o pid,args --forest'

## wget related
alias wget-allinone="wget -r -k -nc -nd $1"                 #dump everything in a single dir
alias wget-mirror="wget -m -k $1"                           #mirror a website  
alias wget-apple="wget -U QuickTime/Apple sux Quick Time"   #download from apple trailers
alias wget-dl='wget --random-wait -r -p -e robots=off -U mozilla "$1"'   # download an entire website
alias wget-images='wget -r -l1 --no-parent -nH -nd -P/tmp -A".gif,.jpg" "$1"'  # download all images from a site

## getting the package keys
alias gpg-get-key='gpg --keyserver keyserver.ubuntu.com --recv-keys $1'
alias gpg-apt-add='gpg --armor --export $1 | sudo apt-key add -'

# Shows your public ip
alias pubip='wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1'

# Test network speed (curl-based or wget-based)
alias curlspeed='curl -o /dev/null http://speedtest.wdc01.softlayer.com/downloads/test500.zip'
alias wgetspeed='wget --output-document=/dev/null http://speedtest.wdc01.softlayer.com/downloads/test500.zip'

## dd related
#alias cdcopy='sudo dd if=/dev/cdrom of=cd.iso'            # for cdrom
#alias partitioncopy='sudo dd if=/dev/sda1 of=/dev/sda2 bs=4096 conv=notrunc,noerror'  # to duplicate one hard disk partition to another hard disk partition
#alias backup-sda='sudo dd if=/dev/hda of=/dev/sda bs=64k conv=notrunc,noerror'    # to backup the existing drive to a USB drive
#alias restore-sda='sudo dd if=/dev/sda of=/dev/hda bs=64k conv=notrunc,noerror'   # to restore from the USB drive to the existing drive
#alias dd-sda-full='sudo dd if=/dev/urandom of=/dev/sda bs=8b conv=notrunc,noerror'  # to wipe hard drive with random data option (1)
#alias dd-sda-r='sudo dd if=/dev/urandom of=/dev/sda bs=102400'        # to wipe hard drive with random data option (2)
#alias dd-sda='sudo dd if=/dev/zero of=/dev/sda conv=notrunc'        # to wipe hard drive with zero

## Git stuff          
alias gitouch='find . \( -type d -empty \) -and \( -not -regex ./\.git.* \) -exec touch {}/.gitignore \;'
alias gits='git status -suno'
alias gitsf='git status'
alias gitc='git checkout'
alias gitd='git diff'
alias gitds='git diff --staged'
alias gita='git add'
alias gitp='git pull'
alias gitb='git branch'
alias gitcl='git clone'
alias gitco='git commit'
alias gitca='git commit -a -m'

## svn stuff
#alias svnaddall='svn status | grep "^\?" | awk "{print \$2}" | xargs svn add'
#alias svndelall='svn status | grep "^\!" | awk "{print \$2}" | xargs svn delete'
#alias svnrmallentries='find . -name .svn -print0 | xargs -0 rm -rf'     # remove all .svn directories recursively

#############################################################################################

##################################
## and some functions as well.. ##
##################################

# Add ppa and then update
#alias add-apt-repositor="sudo add-apt-repository \""$*"\"; sudo apt-get updat"
#alias add-apt-repository="add-apt-repositor"
ppa-add(){ sudo add-apt-repository "$@" ; sudo apt-get update ;} #a function actually.

#xkcd
#alias xkcd=wget -qO- xkcd.com|tee >(feh $(grep -Po '(?<=")http://imgs[^/]+/comics/[^"]+\.\w{3}'))|grep -Po '(?<=(\w{3})" title=").*(?=" alt)';
xkcd(){ wget -qO- xkcd.com|tee >(feh $(grep -Po '(?<=")http://imgs[^/]+/comics/[^"]+\.\w{3}'))|grep -Po '(?<=(\w{3})" title=").*(?=" alt)';}

#conky-colors
conky-colors-default-setup(){ conky-colors --lang=english --theme=elementary --cpu=2 --battery --cputemp --hdtemp1=sda --proc=4 --network --ubuntu --unit=C --side=left --clock=lucky --weather=USNH0102 --calendar;}
conky-colors-all-setup(){ conky-colors --lang=english --theme=elementary --cpu=2 --battery --cputemp --hdtemp1=sda --proc=3 --network --ubuntu --hd=default --unit=C --side=left --swap --updates --photord --clementine=simple --gmail --calendar --clock=lucky;}

###### anagrams
function anagrams()
{
cat > "/tmp/anagrams.py" <<"End-of-message"
#!/usr/bin/python
infile = open ("/usr/share/dict/words", "r")
## "dict" is a reserved word
words_in = infile.readlines()
scrambled = raw_input("Enter the scrambled word: ")
scrambled = scrambled.lower()
scrambled_list = list(scrambled)
scrambled_list.sort()
for word in words_in:
    word_list = list(word.strip().lower())
    word_list.sort()
    ## you don't really have to compare lengths when using lists as the
    ## extra compare takes about as long as finding the first difference
    if word_list == scrambled_list:
        print word, scrambled
End-of-message
chmod +x "/tmp/anagrams.py"
"/tmp/anagrams.py" "$1"
rm "/tmp/anagrams.py"
}

function anagram_() { function s() { sed 's/[[:space:]]*//g;s/./\n\0/g'<<<"$@"|tr A-Z a-z|sort;};cmp -s <(s $1) <(s $2)||echo -n "not ";echo anagram; }

###### fake error string
function error()
{
while true; do awk '{ print ; system("let R=$RANDOM%10; sleep $R") }' compiler.log; done
}

###### stupid funny face
function funny_face() {
  _ret=$?; if test $_ret -ne 0; then echo "0_0->ret=$_ret"; set ?=$_ret; unset _ret; else echo "^_^"; fi
}

###### pretend to be busy in office to enjoy a cup of coffee
function grepcolor()
{
cat /dev/urandom | hexdump -C | grep --color=auto "ca fe"
}

function oneliners()
{
w3m -dump_source http://www.onelinerz.net/random-one-liners/1/ | awk ' /.*<div id=\"oneliner_[0-9].*/ {while (! /\/div/ ) { gsub("\n", ""); getline; }; gsub (/<[^>][^>]*>/, "", $0); print $0}'
}

###### random cowsay stuff
function random_cow()
{
  files=(/usr/share/cowsay/cows/*)
  printf "%s\n" "${files[RANDOM % ${#files}]}"
}

# Temporarily add to PATH 
function apath()
{
    if [ $# -lt 1 ] || [ $# -gt 2 ]; then
        echo "Temporarily add to PATH"
        echo "usage: apath [dir]"
    else
        PATH=$1:$PATH
    fi
}

### Good bash tips for everyone
function bashtips() {
# copyright 2007 - 2010 Christopher Bratusek
cat <<EOF
DIRECTORIES
-----------
~-          Previous working directory
pushd tmp   Push tmp && cd tmp
popd        Pop && cd
GLOBBING AND OUTPUT SUBSTITUTION
--------------------------------
ls a[b-dx]e Globs abe, ace, ade, axe
ls a{c,bl}e Globs ace, able
\$(ls)      \`ls\` (but nestable!)
HISTORY MANIPULATION
--------------------
!!        Last command
!?foo     Last command containing \`foo'
^foo^bar^ Last command containing \`foo', but substitute \`bar'
!!:0      Last command word
!!:^      Last command's first argument
!\$       Last command's last argument
!!:*      Last command's arguments
!!:x-y    Arguments x to y of last command
C-s       search forwards in history
C-r       search backwards in history
LINE EDITING
------------
M-d     kill to end of word
C-w     kill to beginning of word
C-k     kill to end of line
C-u     kill to beginning of line
M-r     revert all modifications to current line
C-]     search forwards in line
M-C-]   search backwards in line
C-t     transpose characters
M-t     transpose words
M-u     uppercase word
M-l     lowercase word
M-c     capitalize word
COMPLETION
----------
M-/     complete filename
M-~     complete user name
M-@     complete host name
M-\$    complete variable name
M-!     complete command name
M-^     complete history
EOF
}

#ex     : Extract files from any archive
ex(){
if [ -f $1 ] ; then
case $1 in
*.tar.bz2) tar xjf $1 ;;
*.tar.gz) tar xzf $1 ;;
*.bz2) bunzip2 $1 ;;
*.rar) rar x $1 ;;
*.gz) gunzip $1 ;;
*.tar) tar xf $1 ;;
*.tbz2) tar xjf $1 ;;
*.tgz) tar xzf $1 ;;
*.zip) unzip $1 ;;
*.Z) uncompress $1 ;;
*.7z) 7z x $1 ;;
*) echo "'$1' cannot be extracted via extract()" ;;
esac
else
    echo "'$1' is not a valid file"
fi
}

# restore old working dir
function cd_
{
  [[ -d "$@" ]] || return 1
  echo "$@" > ~/.last_dir
  cd "$@"
}

# find in files anywhere
function gcode() { grep --color=always -rnC3 -- "$@" . | less -R; }

# folder nav like in a web browser
function up() { pushd .. > /dev/null; }
function down() { popd > /dev/null; }

# get the etymology
function etym(){
    for term in "$@"
    do
        url="etymonline.com/index.php?term=$term"
        curl -s $url | grep "<dd " |
                sed -e 's/<a[^>]*>\([^<]*\)<[^>]*>/:\1:/g' -e 's/<[^>]*>//g' |
                fold -sw `[ $COLUMNS -lt 80 ] && echo $COLUMNS || echo 79 `
        echo
    done
}

# really cool
function gmailcheck() {
    if [ -z $1 ]; then
      echo "Please provide your username as the parameter."
    else
      #curl -u $1 --silent "https://mail.google.com/mail/feed/atom" | perl -ne 'print "\t" if /<name>/; print "$2\n" if /<(title|name)>(.*)<\/\1>/;'
      curl -u $1 --silent "https://mail.google.com/mail/feed/atom" | tr -d '\n' | awk -F '<entry>' '{for (i=2; i<=NF; i++) {print $i}}' | perl -pe 's/^<title>(.*)<\/title><summary>(.*)<\/summary>.*?<name>(.*?)<\/name>.*$/\n$3\n\t$1\n\t$2/'
    fi
}

#############################################################################################

#####################
# Miscellaneous Fun #
#####################

alias futurama='curl -Is slashdot.org | sed -n '5p' | sed 's/^X-//''        # get Futurama quotations from slashdot.org servers
alias funfacts='wget http://www.randomfunfacts.com -O - 2>/dev/null | grep \<strong\> | sed "s;^.*<i>\(.*\)</i>.*$;\1;";'
alias insults='wget http://www.randominsults.net -O - 2>/dev/null | grep \<strong\> | sed "s;^.*<i>\(.*\)</i>.*$;\1;";'

alias 99bottles='x="bottles of beer";y="on the wall";for b in {99..1};do echo "$b $x $y, $b $x. Take one down pass it around, $(($b-1)) $x $y"; sleep 3;done'
alias addictive='count="1" ; while true ; do read next ; if [[ "$next" = "$last" ]] ; then count=$(($count+1)) ; echo "$count" ; else count="1" ; echo $count ; fi ; last="$next" ; done'               # simple addicting bash game
alias awesome='while $i;do `notify-send -t 200 "You are awesome :)"`;sleep 60; done;'   # get informed periodically by your box that you are awesome
alias busy='for i in `seq 0 100`;do timeout 6 dialog --gauge "Install..." 6 40 "$i";done' # pretend to be busy in office to enjoy a cup of coffee
alias busy2='my_file=$(find /usr/include -type f | sort -R | head -n 1); my_len=$(wc -l $my_file | awk "{print $1}"); let "r = $RANDOM % $my_len" 2>/dev/null; vim +$r $my_file'
alias busy3='cat /dev/urandom | hexdump -C | highlight ca fe 3d 42 e1 b3 ae f8 | perl -MTime::HiRes -pnE "Time::HiRes::usleep(rand()*1000000)"'
alias einsteiny='A=1;B=100;X=0;C=0;N=$[$RANDOM%$B+1];until [ $X -eq $N ];do read -p "N between $A and $B. Guess? " X;C=$(($C+1));A=$(($X<$N?$X:$A));B=$(($X>$N?$X:$B));done;echo "Took you $C tries, Einstein";'            # numbers guessing game
alias etchasketch='c=12322123;x=20;y=20;while read -sn1 p;do k=${c:(p-1)*2:2};let x+=$((k/10-2));let y+=$((k%10-2));echo -en \\033[$y\;"$x"HX;done' # use the 1 2 3 and 4 keys to move the cursor around the screen (It's an etch-a-sketch for your terminal!)
alias excuses='echo `telnet bofh.jeffballard.us 666 2>/dev/null` |grep --color -o "Your excuse is:.*$"'   # excuses
alias freechess='telnet fics.freechess.org 5000'            # connects to a telnet server for free internet chess
alias funknet='telnet the-funk.net 7000'              # Access to Funk.net
alias guitartune='for n in E2 A2 D3 G3 B3 E4;do play -n synth 4 pluck $n repeat 2;done'   # tune your guitar from the command line
alias lotto='shuf -i 1-49 -n 6 | sort -n | xargs'           # lotto generator
alias matrix='echo -e "\e[32m"; while :; do for i in {1..16}; do r="$(($RANDOM % 2))"; if [[ $(($RANDOM % 5)) == 1 ]]; then if [[ $(($RANDOM % 4)) == 1 ]]; then v+="\e[1m $r   "; else v+="\e[2m $r   "; fi; else v+="     "; fi; done; echo -e "$v"; v=""; done'
alias matrix2='echo -e "\e[31m"; while $t; do for i in `seq 1 30`;do r="$[($RANDOM % 2)]";h="$[($RANDOM % 4)]";if [ $h -eq 1 ]; then v="\e[1m $r";else v="\e[2m $r";fi;v2="$v2 $v";done;echo -e $v2;v2="";done;'
alias matrix3='COL=$(( $(tput cols) / 2 )); clear; tput setaf 2; while :; do tput cup $((RANDOM%COL)) $((RANDOM%COL)); printf "%$((RANDOM%COL))s" $((RANDOM%2)); done'
alias matrix4='echo -ne "\e[32m" ; while true ; do echo -ne "\e[$(($RANDOM % 2 + 1))m" ; tr -c "[:print:]" " " < /dev/urandom | dd count=1 bs=50 2> /dev/null ; done'
alias matrix5='tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=lcase,unblock | GREP_COLOR="1;32" grep --color "[^ ]"'

#############################################################################################

function drush-remove-module() {
  drush pm-disable -y "$1"
  drush pm-uninstall -y "$1"
}

alias viml='vim -c "normal '\''0"'
#alias vi -='vim -c "normal '\''0"'

alias wr='wayrunner'

# makes branch switching less painful, with partial keyword matches
function gitch() {
  # only look at local branches
  branch=$(git for-each-ref --format=%\(refname:short\) refs/heads/*"$1"*)
  no_of_branches=$(wc -l <<< "$branch")

  if [ -z "$branch" ]; then
    echo "Could not find a local branch matching \"$1\" :("
  elif [ "$no_of_branches" -gt 1 ]; then 
    echo "$branch"
    echo ""
    echo "Found ${no_of_branches} local branches. Narrow down with a different keyword."
  else
    git checkout "$branch"
  fi
}

alias gitselect='git for-each-ref --format="%(refname:short)" refs/heads/\* | while read -r line; do read -p "select branch: $line (y/N)?" answer </dev/tty; case "$answer" in y|Y) echo "$line";; esac; done'

alias beez="beeline -i /csnzoo/adhamala/.hiverc -u jdbc:hive2://bigdatahive.service.bo1.csnzoo.com:10000 -n adhamala --verbose=true --showWarnings=true showNestedErrs=true --color=true --silent=false"
