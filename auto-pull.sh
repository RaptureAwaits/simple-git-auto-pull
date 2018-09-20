#!/bin/bash

function check_commit_id() {
	git fetch # Fetch the most recent commit to the master branch from the remote repository
	remoteid=$(git log origin/master --format="%H" -n 1)
	localid=$(git log --format="%H" -n 1) # Assign the most recent commit hash from the remote and local branches to their respective variables

	if [ "$remoteid" == "$localid" ] # If the two hashes are equal, then there is no difference between remote and local repos, hence no change needs to be made
	then
		printf "Local master branch matches remote.\n\n"
		return
	else
		printf "Local master branch is behind, pulling from remote master branch...\n"
		git pull # If there is a difference, pull from the remote repository
		return
	fi
}

while [ TRUE ]; # Compares the commit IDs every 60 seconds
do
	printf "Checking commit IDs...\n"
	check_commit_id
	sleep 60
done
