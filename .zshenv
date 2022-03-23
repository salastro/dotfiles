# variables
export EDITOR='nvim'
export BROWSER='/bedrock/cross/bin/brave'
export TERMINAL='st'
export FILES='$TERMINAL bicon.bin nnn -r -C -d -e'
export EMAIL='$TERMINAL bicon.bin neomutt'

# paths
export PATH=$PATH:$(go env GOROOT)/bin:$(go env GOPATH)/bin
# export JAVA_HOME="/lib/jvm/java-1.8-openjdk/"
source "$HOME/.cargo/env"
