  #!/usr/local/bin/bash
  password=$(cat $1)
  score=${#password}
  error="Error: Password length invalid."
 
  if [ $score -gt '32' ]; then
 
          echo $error
 
  else
          if [ $score -lt '6' ]; then
 
                  echo $error
 
          else
                  egrep "[#$\+%@]" $1 > output.txt
                  if [ -s output.txt ]; then
                          let score=$score+5
                  fi
                  egrep "[0-9]" $1 > output.txt
                  if [ -s output.txt ]; then
                          let score=$score+5
                  fi
                  egrep "[A-Za-z]" $1 > output.txt
                  if [ -s output.txt ]; then
                          let score=$score+5
                  fi
                  egrep "[a-z][a-z][a-z]" $1 > output.txt
                  if [ -s output.txt ]; then
                          let score=$score-3
                  fi
                  egrep "[A-Z][A-Z][A-Z]" $1 > output.txt
                  if [ -s output.txt ]; then
                          let score=$score-3
                  fi
                  egrep "[0-9][0-9][0-9]" $1 > output.txt
                  if [ -s output.txt ]; then
                          let score=$score-3
                  fi
                  egrep "([A-Za-z0-9])\1\1+" $1 > output.txt
                  if [ -s output.txt ]; then
                          let score=$score-10
                  fi
                  echo "Password Score: $score"
          fi
  fi
 rm output.txt
