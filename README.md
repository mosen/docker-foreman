# Unofficial Foreman + All Features Container Image #

This repo contains build sources for a foreman image that contains *almost* every possible feature and plugin 
to foreman.

I built this because I wanted to experiment with [Katello](https://www.theforeman.org/plugins/katello/), 
the upstream of Red Hat Satellite, in an orchestrated container environment.
 
I split [pulpcore](https://pulpproject.org/docs/) and [candlepin](https://www.candlepinproject.org/) into standalone 
containers, and this image does not necessarily depend on them, but it should be able to make use of them. 

I did not want to use the puppet based [foreman-installer](https://github.com/theforeman/foreman-installer) as this
would contain too many design concerns for a non containerised platform.

## Contents ##

- [Foreman](https://www.theforeman.org/introduction.html), both the core server and (soon) Smart-Proxy.
- Every feature (provider) enabled.
- Every plugin that i could install without it throwing an exception at startup.

## Usage ##

TODO: To run the Smart-Proxy instead of the server, start the container with the "proxy" command.

## Configuration ##

### Database ###

Foreman is a Rails application, and rails will accept a database connection given by the environment variable 
`DATABASE_URL` as described in 
[configuring a database](https://edgeguides.rubyonrails.org/configuring.html#configuring-a-database)

For example:

    DATABASE_URL=postgresql://postgresql-container/foreman

The default container will use a built-in SQLite database, not intended for anything except a sandbox or proof of
concept instance.

#### From Foreman/Rails ####


    FOREMAN_ENV=production  # The Rails environment to run as. 99% of the time you want production.
    FOREMAN_PORT=3000       # The WEBrick port (if not using passenger to serve the web app).
    FOREMAN_BIND=0.0.0.0    # Bind to all interfaces
    SEED_ADMIN_PASSWORD=changeme    # Set the `admin` account password to this (Does not seem to work currently).
                                    # For the moment, the admin password is generated at startup and printed to stdout.
    SEED_ORGANIZATION=Default Organization  # The default organization name
    SEED_LOCATION=Default Location  # The default location name
    
    # If using an SSL connection to QPID for Katello, you will need a cert db.
    QPID_SSL_CERT_DB=
    
## TODO ##

- Expose many more configuration variables as ENV.

