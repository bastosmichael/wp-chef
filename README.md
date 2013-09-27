# WP-Chef

I'm transitioning all of my working chef recipes for WordPress into a single install utility. Basically this is a shortcut to setting up a Wordpress dev & production environment using Vagrant on VirtualBox (Locally) & EC2 (Remotely) provisioned with Chef. Updated to support Vagrant 2 (1.2) configuration.

## Development Strategy

Apache Beta: Currently working
```
Deploys cookbook both to Vagrant and EC2
```

Nginx Beta: Currently working.
```
Deploys cookbook both to Vagrant and EC2
```

Redis Alpha: Currently working.
```
Deploys cookbook both to Vagrant and EC2 with Redis Caching
```

Distributed Concept: Currently Under Development.
```
I have the chef script to do distributed but I have to rewrite it to have it work with Vagrant.
```

## Usage

One: Install Vagrant 1.2.2.

```
http://downloads.vagrantup.com/tags/v1.2.2
```

Two: Clone this repository.

```
git clone https://github.com/bastosmichael/WP-Chef.git
```

Three: Install desired Vagrant Plugins

```
#For AWS Deployment
vagrant plugin install vagrant-aws
vagrant plugin install vagrant-awsinfo

#For Rackspace Deployment
vagrant plugin install vagrant-rackspace
```

Four: Copy Apache or Nginx Vagrantfile
```
cp Vagrantfile.apache Vagrantfile #For Apache Setup

or

cp Vagrantfile.nginx Vagrantfile  #For Nginx Setup

or 

cp Vagrantfile.redis Vagrantfile  #For Redis Setup
```

Five: Configure Vagrantfile for Production.

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

Six: Vagrant up to deploy locally.

```
cd wp-chef
vagrant up 

#This takes a few minutes

Configure your blog at [http://localhost:8000/wp-admin/install.php](http://localhost:8000/wp-admin/install.php).
```

Seven: Vagrant up to deploy to Remote Service.

```
# For AWS Deployment, may take a few minutes
cd wp-chef
vagrant up --provider=aws
vagrant awsinfo -k host
# Use vagrant awsinfo -m default -p to view all the instance data

# For Rackspace Deployment, may take a few minutes
cd wp-chef
vagrant up --provider=rackspace

Configure your blog at [http://YOUR_HOST/wp-admin/install.php](http://YOUR_HOST/wp-admin/install.php).
```
