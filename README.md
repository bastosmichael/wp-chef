# WP-Chef

I'm transitioning all of my working chef recipes for WordPress into a single install utility. Basically this is a shortcut to setting up a Wordpress dev & production environment using Vagrant on VirtualBox (Locally) & EC2 (Remotely) provisioned with Chef. Updated to support Vagrant 2 (1.3.5) configuration.

## Usage

One: Install Vagrant 1.3.5.

```
http://downloads.vagrantup.com/tags/v1.3.5
```

Two: Clone this repository.

```
git clone https://github.com/bastosmichael/wp-chef.git
```

Three: Install desired Vagrant Plugins

```
#For AWS Deployment
sudo vagrant plugin install vagrant-aws
sudo vagrant plugin install vagrant-awsinfo

#For Rackspace Deployment
sudo vagrant plugin install vagrant-rackspace

#For Digital Ocean Deployment
sudo vagrant plugin install vagrant-digitalocean
```

Four: Configure Vagrantfile for Production.

```
    # You may need to change to a dummy box the first time you run it
    config.vm.box = "dummy"
    config.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"

    # Add your configurations for AWS Deployment
    aws.access_key_id = "YOUR KEY"
    aws.secret_access_key = "YOUR SECRET KEY"
    aws.keypair_name = "KEYPAIR NAME"
    override.ssh.private_key_path = "PATH TO YOUR PRIVATE KEY"

    # Add your configurations for RackSpace Deployment
    rs.username = "YOUR USERNAME"
    rs.api_key  = "YOUR API KEY"


    # Lockdown your system database for apache (:server_root_password is database password)
    "dbhost" => "localhost",
    "database" => "wordpressdb",
    "dbuser" => "wordpressuser",
    :server_root_password   => "YOUR RANDOM PASSWORD",
    :server_repl_password   => "YOUR RANDOM PASSWORD",
    :server_debian_password => "YOUR RANDOM PASSWORD"

    # Lockdown your system database for nginx & redis ("server_root_password" is database password)
    "dbhost" => "localhost",
    "database" => "wordpressdb",
    "dbuser" => "wordpressuser",
    "server_root_password"  => "password",
```

Five: Vagrant up to deploy locally.

```
cd wp-chef
vagrant up

#This takes a few minutes

Configure your blog at [http://localhost:8000/wp-admin/install.php](http://localhost:8000/wp-admin/install.php).
```

Six: Vagrant up to deploy to Remote Service.

```
# For AWS Deployment, may take a few minutes
cd wp-chef
vagrant up --provider=aws
vagrant awsinfo -k host
# Use vagrant awsinfo -m default -p to view all the instance data

# For Rackspace Deployment, may take a few minutes
cd wp-chef
vagrant up --provider=rackspace

# For Digital Ocean Deployment, may take a few minutes
cd wp-chef
vagrant up --provider=digital_ocean

Configure your blog at [http://YOUR_HOST/wp-admin/install.php](http://YOUR_HOST/wp-admin/install.php).
```
