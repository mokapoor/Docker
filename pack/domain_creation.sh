#!/bin/bash
#. $DOMAIN_HOME/bin/setDomainEnv.sh
. "/data/Oracle/Middleware/Oracle_Home/wlserver/server/bin/setWLSEnv.sh"
# Create the cluster.
/usr/java/jdk1.8.0_291/bin/java weblogic.WLST /data/deploy.py
