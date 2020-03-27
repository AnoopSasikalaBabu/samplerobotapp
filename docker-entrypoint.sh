#!/bin/sh

# In real world we'd clear the database between runs since not all our tests clean up after themselves properly

# echo Resetting database
# wget --spider -q -T 90 $RESET_DB

echo "Executing tests"
#pabot --processes 3 --outputdir ./results ./robot/tests/
#pabot --processes 3 --outputdir /usr/local/bin/rslt  Cust*.robot
#cd  /usr/local/bin/
#tar xvzf UIV3.tar

cd  /usr/local/bin/UIV3/src
robot Custom_stats_UI  --variable BROWSER:chrome --outputdir results tests