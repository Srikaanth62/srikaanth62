#!/bin/bash
#create variables
A="Srikanth"
B="Varadhi"

#Print variables
echo First name = $A
echo Last name = ${B}

#Printing Date
DATE=$(date +%D)
echo Today date is ${DATE}
#Printing Arithmatic
NETSAL=1500000
TAX=$((1500000/3/2))
echo My Net Salary is $NETSAL and my tax deduction is ${TAX}

