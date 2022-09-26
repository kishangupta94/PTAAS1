#!/bin/bash
if [[ -n $1 && -n $2 && -n $3 ]] #not provide enough parameters to launch
then
	SCHEME=$1
	FQDN=$2
	PORT=$3
	if [[ -n $4 ]]
	then
		FOLDER=$4
	fi

	if [[ -n $5 ]]
	then
		EMAIL=$5
		echo Launching Scan against $1://$2:$3$4 E-Mailing reports to $5
		java -javaagent:BurpSuiteLoader_v2022.1.jar -noverify -jar burpsuite_pro_v2022.1.jar $SCHEME $FQDN $PORT $FOLDER
		echo 'Your scan results are attached to this email.' | mutt $5 -s 'PTAAS Results' -a PTAAS_$1_$2_$3.html
		#mutt -s 'PTAAS Results' $5 -a PTAAS_$1_$2_$3.html
		echo 'Scan Result Send Successfully'
	else
		echo Launching Scan against $1://$2:$3$4
		java -javaagent:BurpSuiteLoader_v2022.1.jar -noverify -jar burpsuite_pro_v2022.1.jar $SCHEME $FQDN $PORT $FOLDER
	fi
else
	echo Usage: $0 scheme fqdn port path email
	echo '    'Example: $0 http localhost 80 /folder PTASS@PTAAS.com
	echo '    Scan multiple sites: cat scheme_fqdn_port.txt | xargs -L1 '$0
fi

exit
