# Scripts for Automatic proxy detection and configuation on Ubuntu Xenial, Trusty and Artful.

Can be installed directly by

```bash
sudo apt-add-repository ppa:rishav1/iitg-rishav1
sudo apt-get update
sudo apt-get install iitg-acproxy
```

Contains two scripts, *proxy-search* and *iitg-acproxy*.

1. *proxy-search* is a script that searches for open http and https proxies on the default subnet 172.16.0.0/16 over ports 808, 3128 & 8080. It has the following syntax and options.

```bash
proxy-search [-h] [-S] [-r] [-s <start_address> <end_address>] [-f <destination_filename>] [-p <ports>] [-t <timeout>]
```

..* -h                                -- Display help
..* -S                                -- Run in silent mode
..* -r                                -- Re-evaluate and upadte the existing list of proxies
..* -s <start_address> <end_address>  -- Set IP range for subnet search
..* -f <destination_filename>         -- Set proxy output file
..* -p <ports>                        -- Set list of ports to be checked
..* -t <timeout>                      -- Set the timeout for individual proxy verification
 
2. *iitg-acproxy* is a script that uses *proxy-search* and redsocks to discover open proxies and set up a transparent redirector for all http, https requests to the discovered proxy server.
Makes it possible to access internet without having to change proxy settings, even during blocked hours, provided some kind soul has an open proxy server set up in the subnet. (Dozens of open
proxy servers are almost always available in IITG campus 24/7).

```bash
proxy-search [--config] {start, stop, restart, status}
```

..* --config		-- Configure subnet, ports and timeout setting for proxy search.
..* start		-- Start the redirector using discovered proxies. If no discovered proxy, then start the discovery using *proxy-search*.
..* stop		-- Kill the redsocks redirector.
--* status		-- See the status of the redirector.
--* restart		-- Restart the redirector.
