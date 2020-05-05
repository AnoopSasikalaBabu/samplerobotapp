#!/bin/sh

# In real world we'd clear the database between runs since not all our tests clean up after themselves properly

# echo Resetting database
# wget --spider -q -T 90 $RESET_DB

echo "Executing tests"
#pabot --processes 3 --outputdir ./results ./robot/tests/
#pabot --processes 3 --outputdir /usr/local/bin/rslt  Cust*.robot
#cd  /usr/local/bin/
#tar xvzf UIV3.tar

#cd  /usr/local/bin/UIV3/src
#robot  --outputdir /usr/local/bin/rslt  Custom_stats_UI.robot

cd  /usr/local/bin/UIV3/src
pabot --processes 1 --outputdir /usr/local/bin/Execution_Results --output outputs01.xml  Cust*.robot

if [ $? -eq 0 ]
then
  echo "Tests successful, skipping rerun"
  sleep 200
  exit 0
fi

for COUNT in 1 2 3
do
  echo "Some tests failed, starting $COUNT. rerun"
  
  #echo "Resetting database"
  # wget --spider -q -T 90 $RESET_DB

  #if [ $? -ne 0 ]
  #then
    #echo "Error resetting database before rerun"
    #exit 1
  #fi

  echo "Executing failed tests"
  cd  /usr/local/bin/UIV3/src
  pabot --processes 2 --rerunfailed /usr/local/bin/Execution_Results/outputs01.xml --outputdir /usr/local/bin/Execution_Results --output outputs01re.xml  Cust*.robot 

  echo "Merging results"
  cd /usr/local/bin/Execution_Results	
  rebot --merge outputs01.xml outputs01re.xml
  cd  /usr/local/bin/UIV3/src
  if [ $? -eq 0 ]
  then
    echo "All tests passed"
    break
  fi
done

