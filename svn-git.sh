#!/bin/sh

SVN_ALIAS=$(alias svn 2>/dev/null|sed -e 's/alias svn=//')
svn_root() {
	[ -d .svn ] || (echo "No .svn directory found" && return)

	OLDPWD=$PWD
	while [ -d ../.svn ]
	do
		cd ..
	done

	SVN_INFO_URL=$(svn info 2>/dev/null | grep URL:) || return
	SVN_URL=$(echo $SVN_INFO | sed -e 's/URL: //')
	SVN_BRANCH=$(echo $SVN_INFO | grep -oe '\(trunk\|branches/[^/]\+\|tags/[^/]\+\)')
	[ -n "$SVN_BRANCH" ] || return
	SVN_ROOT=${SVN_URL%$SVN_BRANCH}
	echo "$SVN_ROOT"
	cd $OLDPWD
}

# Makes changing branches in Subversion more like Git
svn_git_checkout() {
    if echo "$@" | grep "://"
    then
        svn "$@"
        return
    fi

	NEW_BRANCH="$1"
	[ -n "$NEW_BRANCH" ] || (echo "No branch specified" && return)
	[ -d .svn ] || (echo "No .svn directory found" && return)

	SVN_ROOT=$(svn_root)

	if [ $NEW_BRANCH != "trunk" ]
	then
		echo "Searching branches for $NEW_BRANCH"
		for BRANCH in $(svn ls ${SVN_ROOT}/branches)
		do
			[ "$NEW_BRANCH/" != $BRANCH ] && continue
			FOUND_BRANCH="branches/$BRANCH"
			break
		done

		if [ -z "$FOUND_BRANCH" ]
		then
			echo "Searching tags for $NEW_BRANCH"
			for TAG in $(svn ls ${SVN_ROOT}/tags)
			do
				[ "$NEW_BRANCH/" != $TAG ] && continue
				FOUND_BRANCH="tags/$TAG"
				break
			done
		fi

		if [ -z "$FOUND_BRANCH" ]
		then
			echo "Could not find a branch or tag named $NEW_BRANCH"
			cd $OLDPWD
			return
		else
			NEW_BRANCH="$FOUND_BRANCH"
		fi
	fi

	OLDPWD=$PWD
	while [ -d ../.svn ]
	do
		cd ..
	done

	echo svn switch "$SVN_ROOT$NEW_BRANCH"
	svn switch "$SVN_ROOT$NEW_BRANCH"
	cd $OLDPWD
}

case "$1" in
    co)
        svn_git_checkout "$@"
        ;;
    checkout)
        svn_git_checkout "$@"
        ;;
    log)
        svn "$@"|less -FX
        ;;
    branch)
        SVN_ROOT=$(svn_root)
        echo "Branches:"
        svn ls ${SVN_ROOT}/branches
        echo
        echo "Tags:"
        svn ls ${SVN_ROOT}/tags
        ;;
    diff)
        [ -n "$DIFF" ] && DIFF_ARG="--diff-cmd=$DIFF"
        svn $DIFF_ARG "$@"|less -FXR
        ;;
    *)
        svn "$@"
        ;;
esac

alias svn=$SVN_ALIAS
