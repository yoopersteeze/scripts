#Determine current logged in user
User="$(who|awk '/console/ {print $1}')"

#Run command if user is logged in
if [ "$User" != "" ]; then
    echo "A user is logged in."
    #Insert command you wish to run here
    exit 0
else
    echo "A user is not logged in."
    exit 1
fi
