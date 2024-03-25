#!/bin/bash

	#Student name: Dean Cohen    

	#Check if the user is root
	if [ "$(whoami)" != "root" ]; then
		echo -e "\033[1;32m This script must be run as root.\e[0m"
	exit 

	else 
		echo -e "\033[1;32m You are running as root. Proceeding with the script.\e[0m"

	fi
	
	#a function that asks for a network to scan from the user
	function IP()
	{ 
		echo -e "\033[1;34m enter a network to scan.\e[0m"
		read -p "enter an address to scan: " IP
	}
	
	# Provide the path to the output directory you want to use
	function DIRCT()
{
		echo -e "\033[1;34m Enter the name of the output directory.\e[0m"
		read DIR
		mkdir $DIR >/dev/null 2>&1
		echo -e "\033[1;34m $DIR directory was created all data will be saved in this folder.\e[0m"

}

	#A function to notify which type of scan options exist.
	function PSLT()
	{
		#A selection menu for the user.
		echo -e "\033[1;34m Choose an option: \e[0m"
		echo -e "\033[1;34m 1. insert a pasaword list \e[0m"
		echo -e "\033[1;34m 2. Use the default password list \e[0m"
		read -p "Enter the number of your choice: " LST

		case $LST in
			1)
			#Ask's for the password list path
			read -p "Enter the path to the password list: " PASSLST
        
        ;;
			2)
			#Use the default password list.
			PASSLST=password.lst
			#you can change the list to the rockyou.txt file
			##PASSLST=/usr/share/wordlists/rockyou.txt
			#at first the rockyou file is zipped ,if you didn't unzip it
			#the file won't work 
			#to unzip use the command:  sudo gunzip /usr/share/wordlists/rockyou.txt.gz

        ;;
			*)
			# For any other input, display an error message and exit.
			echo -e "\033[1;34m Invalid choice. Exiting. \e[0m"
			exit 1
        ;;
	esac

	}
	
		#Port scaning with nmap
	function NMAP()
	{
		echo -e "\033[1;33m starting TCP scan please wait. \e[0m"	 
		sudo nmap -sV -F -T5  $IP >>$DIR/TCPscan.txt 
		echo -e "\033[1;33m starting UDP scan please wait. \e[0m"	 
		sudo nmap -sU -sV -F -T5   $IP >$DIR/UDPscan.txt
		

		cat $DIR/TCPscan.txt | grep "open" | awk '{for (i=1; i<=NF; i++) printf "%s ", $i; print ""}'  >$DIR/logscan.txt
		cat $DIR/UDPscan.txt | grep "open" | awk '{for (i=1; i<=NF; i++) printf "%s ", $i; print ""}' >>$DIR/logscan.txt


	
	}
	#a function to scan weak cradensials
	function WC()
	{
		#By default, the username list used is the same as the default password list.
		#To change it, update the path to the file.
		USERLST=password.lst
	echo -e "\033[1;33m starting scan for weak cradensials \e[0m"
	sudo hydra -L $USERLST -P $PASSLST ftp://$IP -o $DIR/hydra >/dev/null 2>&1
	sudo hydra -L $USERLST -P $PASSLST ssh://$IP -o $DIR/hydra  >/dev/null 2>&1
	sudo hydra -L $USERLST -P $PASSLST telnet://$IP -o $DIR/hydra >/dev/null 2>&1
	sudo hydra -L $USERLST -P $PASSLST rdp://$IP -o $DIR/hydra >/dev/null 2>&1
	echo -e "\033[1;32m$(sudo cat $DIR/hydra | grep "login")\e[0m" 
	echo -e "\033[1;32m$(sudo cat $DIR/hydra | grep "login")\e[0m" >$DIR/logins.txt 
	echo -e "\033[1;32m all users and passwords found will be saved in $DIR/logins.txt \e[0m"
	}
	

	#A function of options for the user to chose which file to view.
	function VIWB()
	{
		#A selection menu for the user.
		echo -e "\033[1;34m Choose an option: \e[0m"
		echo -e "\033[1;34m 1. view the scan log \e[0m"
		echo -e "\033[1;34m 2. view the weak cradensials log \e[0m"
		echo -e "\033[1;34m 3.to view both \e[0m"
		read -p "Enter the number of your choice ,any other choice will continue the script: " CHT

		case $CHT in
			1)
			#presents the scan log
			less $DIR/logscan.txt
        
        ;;
			2)
			#presents the logins report.
			less $DIR/logins
        
        ;;
		   3)
		   #presents both of the logs.
		   less $DIR/logscan.txt
		   less $DIR/logins
        ;;
			*)
			# For any other input the script will continue.
			echo -e "\033[1;34m continuing script \e[0m"
        ;;
	esac

	}
	#A function of options for the user to choose which file to view.
	function VIWF()
	{
		#A selection menu for the user.
		echo -e "\033[1;34m Choose an option: \e[0m"
		echo -e "\033[1;34m 1. view the scan log \e[0m"
		echo -e "\033[1;34m 2. view the weak cradensials log \e[0m"
		echo -e "\033[1;34m 3.to view the vnulnrabilities report \e[0m"
		echo -e "\033[1;34m 4.to view all \e[0m"
		read -p "Enter the number of your choice,any other choice will continue the script: " CHT

		case $CHT in
			1)
			#presents the scan log
			less $DIR/logscan.txt
        
        ;;
			2)
			#presents the logins report.
			less $DIR/logins
        
        ;;
			3)
			#presents the vnulnrabilities report.
			less $DIR/vnulnrabilities.txt
        ;;
			4)
		   #presents all of the logs.
		   less $DIR/logscan.txt
		   less $DIR/logins
		   less $DIR/vnulnrabilities.txt
        ;;
			*)
			# For any other input the script will continue.
			echo -e "\033[1;34m continuing script \e[0m"
			
        ;;
	esac

	}


#a function to scan weak cradensials and nulnrabilities
	function FS()
	{
echo -e "\033[1;32m starting vulnerabilities scan and loging \e[0m"
echo -e "\033[1;32m please wait. \e[0m"
sudo nmap --script vuln $IP > $DIR/vnulnrabilities.txt
echo -e "\033[1;32m DONE \e[0m"
echo -e "\033[1;32m all the open ports and vulnerabilities found will be saved in $DIR/vnulnrabilities.txt \e[0m"
}

#a function to zip all the data found in the scans
	#a function to zip all the data found in the scans
	function ZIP()
	{
		#A selection menu for the user.
		echo -e "\033[1;34m Choose an option: \e[0m"
		echo -e "\033[1;34m do you want to zip the reasults?  \e[0m"
		echo -e "\033[1;34m press (Z) to zip anything elese will continue the script \e[0m"
		read -p "Enter the number of your choice: " CHT

		case $CHT in
			Z)
			#presents the scan log
			echo -e "\033[1;34m zipping \e[0m"
			zip -r "$DIR.zip" "$DIR"
        
        ;;
			*)
			# For any other input, continue.

			
        ;;
	esac
	
	}	

	#a function to notify which type of scan options exist
	function BF()
{
	
		echo -e  " \033[1;35m please Select:  \e[0m "
		echo -e  " \033[1;35m B for a basic or F for a full scan: \e[0m "
		read CHOICE

		case $CHOICE in
		B)
		echo -e "\033[1;32m  basic scan  starts now.  \e[0m"
		NMAP
		WC
		VIWB
		ZIP
		echo -e "\033[1;32m  the scan ended  \e[0m"

	

		;; 

		F)
		echo -e "\033[1;32m a full scan starts now.    \e[0m"
		NMAP
		FS
		WC
		VIWF
		ZIP
		echo -e "\033[1;32m  the scan ended    \e[0m"

	
		;; 

		*)
		echo -e  "\033[1;32m You entered wrong choice, start again and choose basic or full \e[0m"
		BF
		;; 
	esac 


}
	IP
	DIRCT
	PSLT
	BF
	

	
	
