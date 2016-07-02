#!/bin/bash

if [ $# -lt 3 ]
then
	echo "Usage: "$0 "  criterion  -ab[-s]  filename:hist_YYYY_MM_DD_hh...*  [ time: YYYYMMDDHHMMSS | criterion#2 | -MTS | -KS ]  [ criterion#3 | -MTS | -KS ]  [ criterion#4 | -MTS | -KS ]"
	exit 1
fi

result_code=$1
rsa_q='n'
filename=$3
input_time=$4
param_5=$5
param_6=$6
size_of_head=10
let "duble_head = $size_of_head * 2"
var_day=`echo $filename | cut -d '_' -f 4`

if [ $var_day != `date +%d` ] 
then
	path_to_file='/data/scp/backup/'
	command=gzgrep
else
	path_to_file='/data/scp/rel2.7_P000_or_greater/data/history/'
	command=grep
fi


function rsa_key {

	ssh-keygen -t rsa -N "" -f $HOME/.ssh/scp$1
	echo 'Enter your password for scp'$1'.sdab.sn:'
	ssh scp$1 "mkdir $HOME/.ssh 2>/dev/null && touch authorized_keys 2>/dev/null && chmod 600 authorized_keys 2>/dev/null"
	echo 'Enter your password for scp'$1'.sdab.sn again:'
	cat $HOME/.ssh/scp$1.pub  | ssh scp$1 'cat >> .ssh/authorized_keys && echo "Public key was transfered on scp'$1'!"'$'\n'
}

		
if [ -r $HOME/.ssh/scp2 ] && [ -r $HOME/.ssh/scp4 ] && [ -r $HOME/.ssh/scp5 ]
then
	test
else
	read -p "Do you want to create RSA-keys for SCPs? [y/n]" rsa_q
fi

if [ $rsa_q == 'y' ]
then

	rsa_key 2
	rsa_key 4
	rsa_key 5

fi

function processing_a {

	if [ $1 == 1 ]
	then
		
		if [ $# == 6 ]
		then
			local processing_a=( `cd $5 && $command $3 $2 | cut -d ';' -f $4 | sed 's/Ser=//g' | sort | uniq -c | sort -r | head -$6` )
			echo ${processing_a[@]}
		else
			if [ $# == 7 ]
			then
				local processing_a=( `cd $5 && $command $3 $2 | egrep $7 | cut -d ';' -f $4 | sed 's/Ser=//g' | sort | uniq -c | sort -r | head -$6` )
				echo ${processing_a[@]}
			else
				if [ $# == 8 ]
				then
					local processing_a=( `cd $5 && $command $3 $2 | egrep $7 | egrep $8 | cut -d ';' -f $4 | sed 's/Ser=//g' | sort | uniq -c | sort -r | head -$6` )
					echo ${processing_a[@]}
				else
					local processing_a=( `cd $5 && $command $3 $2 | egrep $7 | egrep $8 | egrep $9 |cut -d ';' -f $4 | sed 's/Ser=//g' | sort | uniq -c | sort -r | head -$6` )
					echo ${processing_a[@]}
				fi
			fi
		fi
			
	else
	
		if [ $# == 6 ]
		then
			local processing_a=(`ssh -i $HOME/.ssh/scp$1 scp$1 "cd $5 && $command $3 $2" | cut -d ';' -f $4 | sed 's/Ser=//g' | sort | uniq -c | sort -r | head -$6`)
			echo ${processing_a[@]}
		else
			if [ $# == 7 ]
			then
				local processing_a=(`ssh -i $HOME/.ssh/scp$1 scp$1 "cd $5 && $command $3 $2" | egrep $7 | cut -d ';' -f $4 | sed 's/Ser=//g' | sort | uniq -c | sort -r | head -$6`)
				echo ${processing_a[@]}
			else
				if [ $# == 8 ]
				then
					local processing_a=(`ssh -i $HOME/.ssh/scp$1 scp$1 "cd $5 && $command $3 $2" | egrep $7 | egrep $8 | cut -d ';' -f $4 | sed 's/Ser=//g' | sort | uniq -c | sort -r | head -$6`)
					echo ${processing_a[@]}
				else
					local processing_a=(`ssh -i $HOME/.ssh/scp$1 scp$1 "cd $5 && $command $3 $2" | egrep $7 | egrep $8 | egrep $9 | cut -d ';' -f $4 | sed 's/Ser=//g' | sort | uniq -c | sort -r | head -$6`)
					echo ${processing_a[@]}
				fi
			fi
		fi	
		
	fi
}

function processing_b {

	if [ $1 == 1 ]
	then
		if [ $# == 6 ]
		then
			local processing_b=( `cd $5 && $command $3 $2 | cut -d ';' -f $4 | sed 's/Oth=//g' | sort | uniq -c | sort -r | head -$6` )
			echo ${processing_b[@]}
		else
			if  [ $# == 7 ]
			then
				local processing_b=( `cd $5 && $command $3 $2 | egrep $7 | cut -d ';' -f $4 | sed 's/Oth=//g' | sort | uniq -c | sort -r | head -$6` )
				echo ${processing_b[@]}
			else
				if [ $# == 8 ]
				then
					local processing_b=( `cd $5 && $command $3 $2 | egrep $7 | egrep $8 | cut -d ';' -f $4 | sed 's/Oth=//g' | sort | uniq -c | sort -r | head -$6` )
					echo ${processing_b[@]}
				else
					local processing_b=( `cd $5 && $command $3 $2 | egrep $7 | egrep $8 | egrep $9 |cut -d ';' -f $4 | sed 's/Oth=//g' | sort | uniq -c | sort -r | head -$6` )
					echo ${processing_b[@]}
				fi
			fi
		fi
		
	else
	
		if [ $# == 6 ]
		then
			local processing_b=(`ssh -i $HOME/.ssh/scp$1 scp$1 "cd $5 && $command $3 $2" | cut -d ';' -f $4 | sed 's/Oth=//g' | sort | uniq -c | sort -r | head -$6`)
			echo ${processing_b[@]}
		else
			if [ $# == 7 ]
			then
				local processing_b=(`ssh -i $HOME/.ssh/scp$1 scp$1 "cd $5 && $command $3 $2" | egrep $7 | cut -d ';' -f $4 | sed 's/Oth=//g' | sort | uniq -c | sort -r | head -$6`)
				echo ${processing_b[@]}
			else
				if [ $# == 8 ]
				then
					local processing_b=(`ssh -i $HOME/.ssh/scp$1 scp$1 "cd $5 && $command $3 $2" | egrep $7 | egrep $8 |cut -d ';' -f $4 | sed 's/Oth=//g' | sort | uniq -c | sort -r | head -$6`)
					echo ${processing_b[@]}
				else
					local processing_b=(`ssh -i $HOME/.ssh/scp$1 scp$1 "cd $5 && $command $3 $2" | egrep $7 | egrep $8 | egrep $9 | cut -d ';' -f $4 | sed 's/Oth=//g' | sort | uniq -c | sort -r | head -$6`)
					echo ${processing_b[@]}
				fi
			fi
		fi
		
	fi

}

function echo_processing {

	echo -ne '\033c'
	echo -n Processing $1-Numbers on SCP$2... $3"% "
	n=0
	while [ $n -lt $3 ]
	do
		echo -n '#'
		(( n++ ))
	done
	echo -n " " $4
}


if [ $2 != '-s' ]
then

if [ $4 == '-MTS' ]
then
	input_time="Oth=050|Oth=38050|Oth=066|Oth=38066|Oth=095|Oth=38095|Oth=099|Oth=38099"
else
	if [ $4 == '-KS' ]
	then
		input_time="Oth=067|Oth=38067|Oth=096|Oth=38096|Oth=097|Oth=38097|Oth=098|Oth=38098|Oth=068|Oth=38068"
	fi
fi

if [ $5 == '-MTS' ]
then
	param_5="Oth=050|Oth=38050|Oth=066|Oth=38066|Oth=095|Oth=38095|Oth=099|Oth=38099"
else
	if [ $5 == '-KS' ]
	then
		param_5="Oth=067|Oth=38067|Oth=096|Oth=38096|Oth=097|Oth=38097|Oth=098|Oth=38098|Oth=068|Oth=38068"
	fi
fi

if [ $6 == '-MTS' ]
then
	param_6="Oth=050|Oth=38050|Oth=066|Oth=38066|Oth=095|Oth=38095|Oth=099|Oth=38099"
else
	if [ $6 == '-KS' ]
	then
		param_6="Oth=067|Oth=38067|Oth=096|Oth=38096|Oth=097|Oth=38097|Oth=098|Oth=38098|Oth=068|Oth=38068"
	fi
fi

if [ $# == 3 ]
then
	cmdline=$command" "$result_code" "$path_to_file$filename
else
	if [ $# == 4 ]
	then
		cmdline=$command" "$result_code" "$path_to_file$filename`echo " | "`egrep" "$input_time
	else
		if [ $# == 5 ]
		then
			cmdline=$command" "$result_code" "$path_to_file$filename`echo " | "`egrep" "$input_time`echo " | "`egrep" "$param_5
		else
			cmdline=$command" "$result_code" "$path_to_file$filename`echo " | "`egrep" "$input_time`echo " | "`egrep" "$param_5`echo " | "`egrep" "$param_6
		fi
	fi
fi

echo_processing 'A' 1 0
tmp_array=$(processing_a 1 $filename $result_code 6 $path_to_file $size_of_head $input_time $param_5 $param_6) 
array_scp1_a=(`echo $tmp_array`)

echo_processing 'B' 1 10
tmp_array=$(processing_b 1 $filename $result_code 7 $path_to_file $size_of_head $input_time $param_5 $param_6) 
array_scp1_b=(`echo $tmp_array`)


echo_processing 'A' 2 25
tmp_array=$(processing_a 2 $filename $result_code 6 $path_to_file $size_of_head $input_time $param_5 $param_6) 
array_scp2_a=(`echo $tmp_array`)

echo_processing 'B' 2 40
tmp_array=$(processing_b 2 $filename $result_code 7 $path_to_file $size_of_head $input_time $param_5 $param_6) 
array_scp2_b=(`echo $tmp_array`)


echo_processing 'A' 4 55
tmp_array=$(processing_a 4 $filename $result_code 6 $path_to_file $size_of_head $input_time $param_5 $param_6) 
array_scp4_a=(`echo $tmp_array`)

echo_processing 'B' 4 70
tmp_array=$(processing_b 4 $filename $result_code 7 $path_to_file $size_of_head $input_time $param_5 $param_6) 
array_scp4_b=(`echo $tmp_array`)


echo_processing 'A' 5 85
tmp_array=$(processing_a 5 $filename $result_code 6 $path_to_file $size_of_head $input_time $param_5 $param_6) 
array_scp5_a=(`echo $tmp_array`)

echo_processing 'B' 5 95
tmp_array=$(processing_b 5 $filename $result_code 7 $path_to_file $size_of_head $input_time $param_5 $param_6) 
array_scp5_b=(`echo $tmp_array`)
echo_processing 'B' 5 100 ' done!'


echo $'\n' $'\n''                                    ' `date +%H:%M:%S` $'\n'
echo "cmd-line: "$cmdline

echo $'\n'A-Numbers $'\n'

printf "%-5s\t" 'SCP1'
printf "%-12s\t" ' '
printf "%-5s\t" 'SCP2'
printf "%-12s\t" ' '
printf "%-5s\t" 'SCP4'
printf "%-12s\t" ' '
printf "%-5s\n" 'SCP5'

c=0
q=0
while [ $c -lt $duble_head ]
do
	q=$(($c + 1))
	printf "%-5s\t" ${array_scp1_a[$c]}
	printf "%-12s\t" ${array_scp1_a[$q]}
	printf "%-5s\t" ${array_scp2_a[$c]}
	printf "%-12s\t" ${array_scp2_a[$q]}
	printf "%-5s\t" ${array_scp4_a[$c]}
	printf "%-12s\t" ${array_scp4_a[$q]}
	printf "%-5s\t" ${array_scp5_a[$c]}
	printf "%-12s\n" ${array_scp5_a[$q]}
	c=$(( $q + 1 ))
done

echo $'\n'$'\n'B-Numbers $'\n'
 
printf "%-5s\t" 'SCP1'
printf "%-12s\t" ' '
printf "%-5s\t" 'SCP2'
printf "%-12s\t" ' '
printf "%-5s\t" 'SCP4'
printf "%-12s\t" ' '
printf "%-5s\n" 'SCP5'

d=0
z=0
while [ $d -lt $duble_head ]
do
	z=$(($d + 1))
	printf "%-5s\t" ${array_scp1_b[$d]}
	printf "%-12s\t" ${array_scp1_b[$z]}
	printf "%-5s\t" ${array_scp2_b[$d]}
	printf "%-12s\t" ${array_scp2_b[$z]}
	printf "%-5s\t" ${array_scp4_b[$d]}
	printf "%-12s\t" ${array_scp4_b[$z]}
	printf "%-5s\t" ${array_scp5_b[$d]}
	printf "%-12s\n" ${array_scp5_b[$z]}
	d=$(( $z + 1 ))
done


else


echo -n 'Processing '$result_code 'calls on SCP1...'
array_sur_scp1=( `cd $path_to_file && $command $result_code $filename* | cut -d ';' -f 5 | sed 's/SUR=//g'| sort | uniq -c` )
echo '. done!'

echo -n 'Processing '$result_code 'calls on SCP2...'
array_sur_scp2=( `ssh -i $HOME/.ssh/scp2 scp2 "cd $path_to_file && $command $result_code $filename" | cut -d ';' -f 5 | sed 's/SUR=//g'| sort | uniq -c` )
echo '. done!'

echo -n 'Processing '$result_code 'calls on SCP4...'
array_sur_scp4=( `ssh -i $HOME/.ssh/scp4 scp4 "cd $path_to_file && $command $result_code $filename" | cut -d ';' -f 5 | sed 's/SUR=//g'| sort | uniq -c` )
echo '. done!'

echo -n 'Processing '$result_code 'calls on SCP5...'
array_sur_scp5=( `ssh -i $HOME/.ssh/scp5 scp5 "cd $path_to_file && $command $result_code $filename" | cut -d ';' -f 5 | sed 's/SUR=//g'| sort | uniq -c` )
echo '. done!'

echo $'\n'$'\n' '                                                '  $result_code by SUR $'\n'

i=0
sum_dur0_scp1=0
while [ $i -lt ${#array_sur_scp1[@]} ]
do
	let "sum_dur0_scp1 = $sum_dur0_scp1 + ${array_sur_scp1[$i]}"
	let "i = $i + 2"
done

i=0
sum_dur0_scp2=0
while [ $i -lt ${#array_sur_scp2[@]} ]
do
	let "sum_dur0_scp2 = $sum_dur0_scp2 + ${array_sur_scp2[$i]}"
	let "i = $i + 2"
done

i=0
sum_dur0_scp4=0
while [ $i -lt ${#array_sur_scp4[@]} ]
do
	let "sum_dur0_scp4 = $sum_dur0_scp4 + ${array_sur_scp4[$i]}"
	let "i = $i + 2"
done

i=0
sum_dur0_scp5=0
while [ $i -lt ${#array_sur_scp5[@]} ]
do
	let "sum_dur0_scp5 = $sum_dur0_scp5 + ${array_sur_scp5[$i]}"
	let "i = $i + 2"
done


tmp=0
i=0
q=1
while [ $i -lt ${#array_sur_scp1[@]} ]
do
	tmp=$(echo "scale=2; ${array_sur_scp1[$i]} * 100 / $sum_dur0_scp1" | bc);
	array_stat_scp1+=(${array_sur_scp1[$q]})
	array_stat_scp1+=($tmp)
	let "i = $i + 2"
	let "q = $q + 2"
done


tmp=0
i=0
q=1
while [ $i -lt ${#array_sur_scp2[@]} ]
do
	tmp=$(echo "scale=2; ${array_sur_scp2[$i]} * 100 / $sum_dur0_scp2" | bc);
	array_stat_scp2+=(${array_sur_scp2[$q]})
	array_stat_scp2+=($tmp)
	let "i = $i + 2"
	let "q = $q + 2"
done


tmp=0
i=0
q=1
while [ $i -lt ${#array_sur_scp4[@]} ]
do
	tmp=$(echo "scale=2; ${array_sur_scp4[$i]} * 100 / $sum_dur0_scp4" | bc);
	array_stat_scp4+=(${array_sur_scp4[$q]})
	array_stat_scp4+=($tmp)
	let "i = $i + 2"
	let "q = $q + 2"
done


tmp=0
i=0
q=1
while [ $i -lt ${#array_sur_scp5[@]} ]
do
	tmp=$(echo "scale=2; ${array_sur_scp5[$i]} * 100 / $sum_dur0_scp5" | bc);
	array_stat_scp5+=(${array_sur_scp5[$q]})
	array_stat_scp5+=($tmp)
	let "i = $i + 2"
	let "q = $q + 2"
done


maxlen=${#array_sur_scp1[@]}
if [ $maxlen -lt ${#array_sur_scp2[@]} ] 
then
	maxlen=${#array_sur_scp2[@]}
else
	if [ $maxlen -lt ${#array_sur_scp4[@]} ]
	then
		maxlen=${#array_sur_scp4[@]}
	else
		if [ $maxlen -lt ${#array_sur_scp5[@]} ]
		then
			maxlen=${#array_sur_scp5[@]}
		fi
	fi
fi


printf "%-30s  " 'SCP1'
printf "%-30s  " 'SCP2'
printf "%-30s  " 'SCP4'
printf "%-30s\n" 'SCP5'

i=0
q=0
while [ $i -lt $maxlen ]
do
	q=$(($i + 1))
	printf "%-10s  " ${array_stat_scp1[$i]}
	printf "%-6s  " ${array_stat_scp1[$q]}'%'
	printf "%-10s\t" '('${array_sur_scp1[$i]}')'
	printf "%-10s  " ${array_stat_scp2[$i]}
	printf "%-6s  " ${array_stat_scp2[$q]}'%'
	printf "%-10s\t" '('${array_sur_scp2[$i]}')'
	printf "%-10s  " ${array_stat_scp4[$i]}
	printf "%-6s  " ${array_stat_scp4[$q]}'%'
	printf "%-10s\t" '('${array_sur_scp4[$i]}')'
	printf "%-10s  " ${array_stat_scp5[$i]}
	printf "%-6s  " ${array_stat_scp5[$q]}'%'
	printf "%-10s\n" '('${array_sur_scp5[$i]}')'
	i=$(( $q + 1 ))
done
fi

exit 0