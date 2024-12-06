#!/bin/bash 

#installation check Git
if command -v git &> /dev/null
then
    echo "Git установлен. Версия:"
    git --version
else
    echo "Git is not installed."
    read -p "Do you want to install Git?...(y|n)  " option 
    case $option in
	    y) sudo apt install git;
	        read -p "Enter a user name for Git: - " username
       	        read -p "Enter a user email for Git: - " useremail
       	        echo ------------------------------------------
		git config --global user.name $username
        	git config --global user.email $useremail
       	        echo ------------------------------------------
		git config --list
       	        echo ------------------------------------------
        	git --version;;
	    *) exit
    esac
fi

#the function will generate an SSH key
generate_ssh_for_git() {  
        	    echo ------------------------------------------
	 	    ssh-keygen -t rsa -b 4096 -C $useremail_for_ssh
        	    echo ------------------------------------------
		    eval "$(ssh-agent -s)"
        	    echo ------------------------------------------
		    ssh-add ~/.ssh/id_rsa
		    echo ------------------------------------------
		    cat ~/.ssh/id_rsa.pub
		    echo ------------------------------------------
		    echo "Copy the key and paste it here ! --->  "https://github.com/settings/keys" "
	    }
echo ------------------------------------------


myfunc(){
	read -p "Do you want to generate an SSH key ? ... (y|n)   " el1 
	case $el1 in 
		y) read -p "Enter a your email associated with your account on GitHub!  " useremail_for_ssh 
		   generate_ssh_for_git;;
		*) exit
	esac
}

myfunc

#function checks connections to GitHub
my_ssh(){
        echo ------------------------------------------
	read -p  "check connections to GitHub?...(y|n)  " el2			
        echo ------------------------------------------
	case $el2 in
		y)ssh -T git@github.com;;
		*) exit
	esac
		}

my_ssh 
