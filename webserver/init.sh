#!/bin/sh

if [ ! -f wp-config.php ]
then
  # Create the config file.
  cp -p wp-config-sample.php wp-config.php

  # Fill in DB settings according to the database env variables.
  DB_HOST="$(echo $DATABASE_PORT | sed -e 's|.*://\(.*\):\(.*\)|\1|')"
  sed -i "s/define('DB_NAME', 'database_name_here');/define('DB_NAME', '$DATABASE_ENV_MYSQL_DATABASE');/g" wp-config.php
  sed -i "s/define('DB_USER', 'username_here');/define('DB_USER', '$DATABASE_ENV_MYSQL_USER');/g" wp-config.php
  sed -i "s/define('DB_PASSWORD', 'password_here');/define('DB_PASSWORD', '$DATABASE_ENV_MYSQL_PASSWORD');/g" wp-config.php
  sed -i "s/define('DB_HOST', 'localhost');/define('DB_HOST', '$DB_HOST');/g" wp-config.php

  # Generate random hash salts.
  SED_ESCAPE_PATTERN='s/[\/&]/\\&/g'
  PASSPHRASE_PLACEHOLDER='put your unique phrase here'
  grep "$PASSPHRASE_PLACEHOLDER" wp-config.php | while read LINE
  do
    # The salt is escaped twice because of the followig two sed replacements.
    SALT=$(openssl passwd -1 $(date +%s) | sed $SED_ESCAPE_PATTERN | sed $SED_ESCAPE_PATTERN)
    LINE_REPLACEMENT=$(echo $LINE | sed "s/$PASSPHRASE_PLACEHOLDER/$SALT/g")
    sed -i "s/$LINE/$LINE_REPLACEMENT/g" wp-config.php
  done
fi

# Start Apache.
apache2-foreground
