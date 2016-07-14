# Skaardb tools
export VENV=local

run_local_skaardb () {
if ! pgrep skaardb > /dev/null; then
	if ! pgrep gnatsd > /dev/null; then
		echo "Starting gnatsd in background!"
		gnatsd& > /dev/null
	fi

	if ! pgrep messaging-frontend > /dev/null; then
		echo "Starting messaging-frontend in background!"
		messaging-frontend& > /dev/null
	fi

	if [ -f ./skaardb ]; then
		echo "Starting local skaardb!"
		./skaardb
	else
		echo "Starting global skaardb!"
		skaardb
	fi
else
	echo "skaardb already running!"
fi
}

alias ddev='pub run dart_dev'

# Add pub bin to cache
export PATH="$PATH":"$HOME/.pub-cache/bin"

# Use dart_dev completions
if [ -n "$ZSH_VERSION" ]; then
	autoload -U compinit
	compinit
	autoload -U bashcompinit
	bashcompinit
	eval "$(pub global run dart_dev bash-completion)"
elif [ -n "$BASH_VERSION" ]; then
	eval "$(pub global run dart_dev bash-completion)"
fi