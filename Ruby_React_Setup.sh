cd ~

ARC=$(uname -m)

echo "Installing Homebrew"

if [[ "$ARC" == "arm64" ]]; then
    echo "x86 Conversion"
    arch -x86_64 mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
else
    echo "No Conversion"
    mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
fi

echo "Installing rbenv"
brew install rbenv

echo "Setting up rbenv"
rbenv init

if ! grep -Fxq 'eval "$(rbenv init -)"' .zshrc
then
    echo 'eval "$(rbenv init -)"' >> .zshrc
    source .zshrc
fi

read -p "Insert the ruby version that you want to install in the formant X.X.X: " VER
while ! [[ $VER =~ ^([0-9]*.){1,5}$ ]]
do 
    echo "Invalid ruby version syntax"
    echo "Insert the ruby version that you want to install in the formant X.X.X"
    read ruby_version
done

echo "Attempting to install ruby $VER"

rbenv install $VER
rbenv global $VER

echo "Checking rbenv installation"
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash

echo "Installing bundler"
gem install bundler

echo "Installing Node.js"
brew install node

echo "Installing create-react-app"
npm install create-react-app
