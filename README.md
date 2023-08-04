> This only is for Debian and Ubuntu for now.

# Simple System Setup

Easy way to keep all your system configuration setup files in git.

> !Warnings!
>
> This has some defaults you perhaps do not want:
>
> - It replaces `nano` with `vim`
> - This installs some common software I just need everywhere.
> - This alters some standard configs I always need everywhere.
>
> Be sore to remove the softlinks to this after `setup/init.sh`.
> `git status` is your friend.


## Usage

	sudo apt install etckeeper
	sudo apt install gawk build-essential

	git init setup
	cd setup

	git submodule add https://github.com/hilbix/setup.git
	git submodule update --init --recursive
	ln -s setup/Makefile .
	make commit

	git fetch setup/.git empty
	git rebase FETCH_HEAD

	setup/init.sh
	make commit

	git remote add origin https://your.own.and.secure.git.service/user/setup.git
	git push -u origin master:`uname -n`

Then

- `setup/add.sh /path/to/file..`
  - `sudo setup/add.sh /path/to/file..` to read privileged files
  - Starts to track some file(s)
  - `git status` to see what was done, `git add` to put them under `git` control
  - `perm` keeps file permission.  Remove it, if not needed
  - `orig` keeps the original file.  Remove it, if the file should be created
  - Use softlinks to share things or point them to some common configuration point
- `make`
  - fails if `git status` is not clean
  - pulls in new configuration changes from the files
  - You can run this by cron if you like
  - `git status` to see what changed
- `make commit`
  - To create autocommit
- `make auto`
  - same as `make commit && make && make commit`
- `make auto push`
  - same as `make auto && git push` afterwards
- sudo `setup/setup.sh`
  - updates all known configuration changes
  - This is automatic if some the original file matches
  - does not work if `git status` is not clean!

## Rationale

I need some quick and dirty way to record changes I have done to a system.  
And I need some quick and safe way to apply these changes to something else.

As the reinstall might happen with a newer version of the OS,
things might not apply cleanly.  This must be detected and reported,
such that I can adopt all necessary changes bit by bit again.

Also I want to be able to install it on some different OS versions in parallel,
such that I can see the differences of the outcome.

All this must be supported.  Quick and easy and hassle free.

As everything else failed for me (neither quick nor easy)
I created this here.  It's simple enough.


## FAQ

WTF why?

- Because things should be as simple as they can get

Why not Ansible?

- Ansible cannot track original files as this here does.
- Note that I also use Ansible in parallel

Why not `etckeeper`?

- I use `etckeeper` in parallel, of course!
- But not everything is in `/etc/`
- `etckeeper` also tracks secret data files like `/etc/shadow`
  - Such things which must be asymmetrically encrypted

Asymmetric encryption?

- Asymmetric means, all local changes can be securely recorded with the public key and be backed up a safe way
- Asymmetric means, the recorded changes cannot be decrypted locally again, as for this you need a private key!
- This is not yet implemented
- Perhaps it will show up if I the need arises at my side.
- As long as it is missing, all to-be-kept-secret data must be supplied by some different means.

`git submodule`s?

- This here is only the common code.
- It is good to keep the common code in a submodule and keep the data elsewhere
- All other trials of doing it differently failed for me
- YMMV, if you do not like it, do not use it.

License?

- Free as free beer, free speech and free Baby
- This code is protected by German Urheberrecht.
- Adding a Copyright to this code is hereby prohibited.
- A mixed with copyrighted code is allowed if the Copyright never encumbers any part of this code.
- "encumbers" includes
  - Changes which, for others, make things no more usable 100% without the copyrighted parts
  - Patents, if the patent encumber others in the area free use, reuse or distribution
  - DRM technologies, which stop others from free use, reuse, distribution or signing their changes
  - Legal documents which restrict the free use, reuse, distribution etc., even if signed by free will
- "encumbers" does not include
  - Other software or systems which use this unencumbered code
  - Optional addons which use some unencumbered plugin system and do not add restrictions to the original code 
  - Nonpublic proprietary changes which are neither made available to others nor sold or similar
  - Securing purely internal use with cryptographic/DRM technologies
  - Anything which does not negatively affect others.  By their (and not yours!) free and unencumbered choice!
  - Local applicable law which applies to everybody the same way and is compatible with Human Rights.

