#!/bin/sh
for i in `ls /usr/local/directadmin/data/users`; do
{
         for d in `cat /usr/local/directadmin/data/users/$i/domains.list`; do
         {
                     username=$i domain=$d spam=ON /usr/local/directadmin/scripts/custom/user_create_post.sh
         };
         done;
};
done;
exit 0;
