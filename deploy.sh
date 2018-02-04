 #!/bin/sh
# deploy.sh
set -e

export SSHPASS=$DEPLOY_PASS

# Copy the new files on
sshpass -e rsync -raz $(pwd)/www/ $DEPLOY_USER@$DEPLOY_HOST:/www/

# Tell one.com to clear the cache
sshpass -e ssh $DEPLOY_USER@$DEPLOY_HOST cache-purge http://bgill.eu
