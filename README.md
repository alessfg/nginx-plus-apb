# Ansible Playbook Bundle for NGINX Plus

An Ansible Playbook Bundle (APB) for deploying a single instance of NGINX Plus.

**Please Note**: This is still a WIP. Any upstream changes might break the APB without previous warning.

## Setup

To test this APB you will first need to setup an OpenShift Origin environment with a Service Catalog and Ansible Service Broker. [Catasb](https://github.com/fusor/catasb) is a nice tool that will allow you to easily create an OpenShift Docker cluster on your local machine and install all the required dependencies.

You will also need to install the [APB application](https://github.com/fusor/ansible-playbook-bundle).

Finally, you will need to build an OpenShift NGINX Plus image. A Dockerfile to build the image can be found in the `dev` folder. You will need to copy your certs into the `certs` folder for the Docker image to work.

## How to Install the NGINX Plus Service

1. Login to your `oc` cluster via the command that [catasb](https://github.com/fusor/catasb) will output at the end of the installation process.
2. Clone this repository.
3. Navigate to the repository and run `apb build`.
4. Run `apb push`.
5. Open your browser at https://192.168.37.1:8443. You'll be greeted by the OpenShift service catalog.
6. Select the NGINX service, add it to `My Project`, select `Create` and click `View Project`.
7. After waiting for a few seconds you should see a URL pop in the top-right corner of the console. That URL will take you to the default NGINX landing page. Alternatively you can select `Applications/Pods` via the left-side navbar and select the NGINX pod. From here you'll be able to use a terminal to manipulate NGINX.

## Sample Tutorial Walkthrough

### Option 1

1. Follow steps 1-5 listed in the **How to Install the NGINX Plus Service**.
2. Deploy Python and PHP web servers by clicking each of the respective icons in the service catalog. For each service, select the `try sample repository` option, click `create` and finally `view project`. Wait for a few minutes until the deployment has completed.
3. Once the deployment has finished, for each service select the drop-down arrow and click the link under the service header. You will be able to see the internal IP of the pod from here. Store the internal IP of both pods (note: while not explicitly specified all default pods are open at port 8080 instead of the normal default port 80 due to security reasons).
4. Select the NGINX service. You will be able to edit a few NGINX configuration options. Select `Enable Proxy Servers` and input the internal IPs of the Python and PHP services as a comma separated list in the `Proxy Servers` textfield. You can also select `Enable Status Dashboard` if you want to see the NGINX Plus live status dashboard. Once you are done add the service to `My Project`, select `Create` and click `View Project`.
4. Click the drop-down arrow for the NGINX Plus service. You will see two routes have been created. Cliking the route with `web` will take you to the NGINX Load Balancer. Clicking the route with `status` will take you to the NGINX live status dashboard.

### Option 2

1. Follow the steps listed in the **How to Install the NGINX Plus Service** section.
2. Deploy Python and PHP web servers by clicking each of the respective icons in the service catalog. For each service, select the ‘try sample repository’ option, click `create` and finally `view project`. Wait for a few minutes until the deployment has completed.
3. Once the deployment has finished, for each service select the drop-down arrow and click the link under the service header. You will be able to see the internal IP of the pod from here. Store the internal IP of both pods (note: while not explicitly specified all default pods are open at port 8080 instead of the normal default port 80 due to security reasons).
4. Navigate to the terminal of your NGINX instance and edit your default.conf file. Add a proxy_pass directive and an upstream group with two server directives pointing to the internal IPs you previously wrote down (remember to add :8080). Save your changes and type `nginx -s reload`. Click the same URL as in step 7 of the `How to Install the NGINX Plus Service` section. Voila! You have a functional NGINX Load Balancer!

## Parameters

Name | Default Value | Required | Description
---|---|---|---
nginx_plus_image | openshift-nginx-plus | Yes | Name of NGINX Plus Docker image
lb | false | No | Enable Proxy Servers
server |  | No | Proxy Servers (Input as a Comma Separated List)
lb_method | round_robin | No | Load Balancing Algorithm
session_persistence | false | No | Enable Session Persistence
sticky_cookie |   | No | Name of Sticky Cookie
status | false | No | Enable Status Dashboard

## License

[Simplified BSD License](https://github.com/nginxinc/nginx-plus-apb/blob/master/LICENSE)

## Author

Alessandro Fael Garcia

[NGINX Inc](https://www.nginx.com/)
