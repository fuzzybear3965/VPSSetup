#!/bin/bash
# If no IP value is supplied as an HTTP query string, then it defaults to the IP
# address of the machine making the HTTP request. So, we'll leave the &ip= off
# of the url.
curl https://dynamicdns.park-your-domain.com/update?host=@&domain=theline.design&password=[ddns_password]
