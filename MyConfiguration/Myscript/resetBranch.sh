repo forall -c git reset --hard
repo forall -c git clean -df

repo abandon master

repo forall -c git reset --hard
repo forall -c git clean -df

reposync.sh

repo start master --all

reposync.sh
