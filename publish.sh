#! /bin/bash

if git status | grep -q "Your branch is up to date with 'origin/main'"; then
	git push origin main
	main_hash=$(git log -n 1 --pretty=format:"%H")
	npm install
	npm run-script build
	cp ./dist /tmp/dist -r
	git checkout workers
	mv /tmp/dist/* ./public/
	git add -A
	git commit -m "Update for $main_hash"
	git push origin workers
	npm install
	wrangler publish
	git checkout main
	git reset --hard
	git clean -fd
	rm /tmp/dist -rf
else
	echo Not all changes have been commited. You probably need to push your commits to main.
	echo Run 'git status' for more information.
fi
