# WP-Chef

I'm transitioning all of my working chef recipes for WordPress into a single install utility. Basically this is a shortcut to setting up a Wordpress dev & production environment using Vagrant on VirtualBox (Locally) & EC2 (Remotely) provisioned with Chef. Updated to support Vagrant 2 (1.2) configuration. Currently only the Apache version works 100%.

## Development Strategy

Apache Beta: Currently working
```
Deploys cookbook both to Vagrant and EC2
```

Nginx Alpha: Currently under redevelopment
```
Deployment to Vagrant & EC2 coming.
```

Distributed: Planned development
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
git clone https://github.com/bastosmichael/wp-chef.git
```

Three: Install Vagrant Amazon Web Services (AWS) plugins

```
vagrant plugin install vagrant-aws
vagrant plugin install vagrant-awsinfo
```

Four: Copy Apache or Nginx Vagrantfile
```
cp Vagrantfile.apache Vagrantfile #For Apache Setup

or

cp Vagrantfile.nginx Vagrantfile  #For Nginx Setup Pending
```

Five: Configure Vagrantfile for AWS.

```
    # Add your AWS configuration
    aws.access_key_id = "YOUR KEY"
    aws.secret_access_key = "YOUR SECRET KEY"
    aws.keypair_name = "KEYPAIR NAME"
    override.ssh.private_key_path = "PATH TO YOUR PRIVATE KEY"

    # Lockdown your system passwords
    :server_root_password   => "YOUR RANDOM PASSWORD",
    :server_repl_password   => "YOUR RANDOM PASSWORD",
    :server_debian_password => "YOUR RANDOM PASSWORD"
```

Six: Vagrant up to deploy locally.

```
cd wp-chef
vagrant up 

#This takes a few minutes

Configure your blog at [http://localhost:8000/wp-admin/install.php](http://localhost:8000/wp-admin/install.php).
```

Seven: Vagrant up to deploy to AWS.

```
cd wp-chef
vagrant up --provider=aws

#This takes a few minutes

vagrant awsinfo -k host

# Use vagrant awsinfo -m default -p to view all the instance data

Configure your blog at [http://YOUR_AWS_HOST/wp-admin/install.php](http://YOUR_AWS_HOST/wp-admin/install.php).
```