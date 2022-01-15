function up --description='alias for update and upgrade on Debian-based distros'
    command sudo apt-get update && sudo apt-get upgrade -y
end
