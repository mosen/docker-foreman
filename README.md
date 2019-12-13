# Unofficial Foreman All-In-One Container #

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
- Every feature enabled.
- Every plugin that i could install without it throwing an exception at startup.

## Usage ##

TODO: To run the Smart-Proxy instead of the server, start the container with the "proxy" command.

### Environment Variables ###

#### From Foreman/Rails ####

    FOREMAN_ENV=production  # The Rails environment to run as. 99% of the time you want production.
    FOREMAN_PORT=3000       # The WEBrick port (if not using passenger to serve the web app).
    FOREMAN_BIND=0.0.0.0    # Bind to all interfaces
    SEED_ADMIN_PASSWORD=changeme    # Set the `admin` account password to this (Does not seem to work currently).
                                    # For the moment, the admin password is generated at startup and printed to stdout.
    
    
## TODO ##

- Expose many more configuration variables as ENV.

