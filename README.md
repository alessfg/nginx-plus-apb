# Ansible Playbook Bundle for NGINX Plus

An Ansible Playbook Bundle (APB) for deploying a single instance of NGINX Plus.

**Please Note**: This is still a WIP

## Setup

To test this APB you will first need to setup an OpenShift Origin environment with a Service Catalog and Ansible Service Broker. [Catasb](https://github.com/fusor/catasb) is a nice tool that will allow you to easily create an OpenShift cluster on your local machine and install all the required dependencies.

You will also need to install the [APB application](https://github.com/fusor/ansible-playbook-bundle).

Finally, you will need to build an OpenShift NGINX Plus image. A Dockerfile to build the image can be found in the `dev` folder.

## How to Use

1. Login to your `oc` cluster via the command that [catasb](https://github.com/fusor/catasb) will output at the end of the installation process.
2. Clone this repository.
3. Navigate to the repository and run `apb build`.
4. Run `apb push`.
5. Open your browser at https://192.168.37.1:8443. You'll be greeted by the OpenShift service catalog.
6. Select the NGINX service, add it to `My Project`, select `Create` and click `View Project`.
7. After waiting for a few seconds you should see a URL pop in the top-right corner of the console. That URL will take you to the default NGINX landing page. Alternatively you can select `Applications/Pods` via the left-side navbar and select the NGINX pod. From here you'll be able to use a terminal to manipulate NGINX.

## Parameters

Name | Default Value | Required | Description
---|---|---|---
nginx_plus_image | openshift-nginx-plus | Yes | Name of NGINX Plus Docker image

## License

[Simplified BSD License](https://github.com/nginxinc/nginx-plus-apb/blob/master/LICENSE)

## Author

Alessandro Fael Garcia

[NGINX Inc](https://www.nginx.com/)
