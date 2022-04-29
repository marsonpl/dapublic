#!/bin/sh
if [ "$spam" = "ON" ]; then
  DIR=/home/$username/.spamassassin
  mkdir -p $DIR
  UP=$DIR/user_prefs
  if [ ! -s ${UP} ]; then
     echo 'required_score 5.0' > ${UP}
     echo 'report_safe 1' >> ${UP}
     chown $username:$username  ${UP}
     chmod 644 ${UP}
  fi
  chown  ${username}:mail $DIR
  chmod 771 $DIR

  if grep -m1 -q "^spamd=rspamd$" /usr/local/directadmin/custombuild/options.conf; then
      echo "action=rewrite&value=rspamd&user=${username}" >> /usr/local/directadmin/data/task.queue
  fi

  if [ "${domain}" != "" ]; then
     FCONF=/etc/virtual/${domain}/filter.conf
     if [ ! -s ${FCONF} ]; then
        echo 'high_score=15' > ${FCONF}
        echo 'high_score_block=no' >> ${FCONF}
        echo 'where=inbox' >> ${FCONF}
        chown mail:mail ${FCONF}

        echo "action=rewrite&value=filter&user=$username" >> /usr/local/directadmin/data/task.queue
     fi
  fi
fi
exit 0;
