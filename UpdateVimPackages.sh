for  dir in ~/.vim/pack/packages/start/*/
do
    #statements
    echo $dir
    cd $dir
    git pull
done
