# Ansible Playbook Bundle for NGINX Plus

An Ansible Playbook Bundle (APB) for deploying a single instance of NGINX Plus in the OpenShift Service Catalog.

**Please Note**: This is still a WIP. Any upstream changes might break the APB without previous warning.

## Development Environment Setup

To test this APB you will first need to setup an OpenShift Origin environment with a Service Catalog and Ansible Service Broker. [`catasb`](https://github.com/fusor/catasb) is a nice tool that will allow you to easily create an OpenShift Docker cluster on your local machine and install all the required dependencies.

As part of setting up [`catasb`](https://github.com/fusor/catasb) you will need to set some additional parameters on `config/my_vars.yml` to allow the NGINX Plus APB to function properly:
* broker_enable_basic_auth: false
* broker_bootstrap_refresh_interval: 86400s

You will also need to install the [APB application](https://github.com/fusor/ansible-playbook-bundle).

## How to Install and Test the NGINX Plus Service

1. You need to build an OpenShift NGINX Plus Docker image. A Dockerfile to build the image can be found in [`dev`](https://github.com/nginxinc/nginx-plus-apb/blob/master/dev/Dockerfile). You will need to copy your certs into the `certs` folder for the Docker image to work.
2. Login to your `oc` cluster via the command that [catasb](https://github.com/fusor/catasb) will output at the end of the installation process.
3. Clone the NGINX Plus APB repository (this repository).
4. Navigate to the repository and run `apb build`.
5. Run `apb push`.
6. Open your browser at https://192.168.37.1:8443. You'll be greeted by the OpenShift service catalog.
7. Select the NGINX service, add it to `My Project`, select `Create` and click `View Project`.
    * Do not enable load balancing at this stage or your deployment will fail.
8. After waiting for a few seconds you should see a URL pop in the top-right corner of the project overview GUI. That URL will take you to the default NGINX landing page.

## Sample Tutorial Walkthrough

1. Deploy Python and PHP web servers by clicking each of the respective icons in the service catalog. For each service, select the `try sample repository` option, click `create` and finally `view project`. Wait for a few minutes until the deployment has completed.
2. Once the deployment has finished, for each service select the drop-down arrow and click the link under the service header. You will be able to see the internal IP of the pod from here. Store the internal IP of both pods (note: while not explicitly specified all default pods are open at port 8080 instead of the normal default port 80 due to security reasons).
3. Select the NGINX service. You will be able to edit a few NGINX configuration options. Select `Enable Load Balancing` and input the internal IPs of the Python and PHP services as a comma separated list in the `Load Balanced Servers` textfield. You can also select `Enable Status Dashboard` if you want to see the NGINX Plus live status dashboard. Once you are done add the service to `My Project`, select `Create` and click `View Project`.
4. Click the drop-down arrow for the NGINX Plus service. You will see two routes have been created. Cliking the route with `web` will take you to the NGINX Load Balancer. Clicking the route with `status` will take you to the NGINX live status dashboard.

## Parameters

Name | Default Value | Required | Description
---|---|---|---
nginx_plus_image | openshift-nginx-plus | Yes | Name of NGINX Plus Docker image
lb | false | No | Enable Load Balancing
server | - | No | Load Balanced Servers (Input as a Comma Separated List)
lb_method | round_robin | No | Load Balancing Algorithm
session_persistence | false | No | Enable Session Persistence
sticky_method | - | No | Session Persistence Method
sticky_learn_cookie | - | No | Name of Sticky (Normal or Learn) Cookie
sticky_route_cookie | - | No | Name of Sticky Route Cookie
sticky_route_cookie_regex | - | No | Regex for Sticky Route Cookie
sticky_route_cookie_regex_capture | - | No | Regex to Capture for Sticky Route Cookie
sticky_route_uri | - | No | NGINX Variable to use for Sticky Route URI
sticky_route_uri_regex | - | No | Regex for Sticky Route URI
sticky_route_uri_regex_capture | - | No | Regex to Capture for Sticky Route URI
routes | - | No | Proxy Servers Sticky Routes (Input as a Comma Separated List)
status | false | No | Enable Status Dashboard
healthcheck | false | No | Enable Active Healthchecks
cache | false | No | Enable Proxy Cache

## License

[Simplified BSD License](https://github.com/nginxinc/nginx-plus-apb/blob/master/LICENSE)

## Author

Alessandro Fael Garcia

[NGINX Inc](https://www.nginx.com/)
